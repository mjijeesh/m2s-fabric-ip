/*
 * uart_downloader.c
 *
 *  Created on: 11-May-2023
 *      Author: jijeesh
 */

#include <middleware/spi_flash/spi_flash.h>
#include <middleware/stdio/uart_downloader.h>
#include <middleware/stdio/uart_stdio.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>


#define SPI_EN 1


#ifndef DDR_DOWNLOAD_BASE_ADDRESS

 #define DDR_DOWNLOAD_BASE_ADDRESS   0xA1000000

#endif

uint32_t g_file_size;
uint32_t g_checksum;



/**********************************************************************//**
 * Error codes
 **************************************************************************/
enum ERROR_CODES {
  ERROR_SIGNATURE = 0, /**< 0: Wrong signature in executable */
  ERROR_SIZE      = 1, /**< 1: Insufficient instruction memory capacity */
  ERROR_CHECKSUM  = 2, /**< 2: Checksum error in executable */
  ERROR_FLASH     = 3  /**< 3: SPI flash access error */
};


/**********************************************************************//**
 * NEORV32 executable
 **************************************************************************/
enum NEORV32_EXECUTABLE {
  EXE_OFFSET_SIGNATURE =  0, /**< Offset in bytes from start to signature (32-bit) */
  EXE_OFFSET_SIZE      =  4, /**< Offset in bytes from start to size (32-bit) */
  EXE_OFFSET_CHECKSUM  =  8, /**< Offset in bytes from start to checksum (32-bit) */
  EXE_OFFSET_DATA      = 12, /**< Offset in bytes from start to data (32-bit) */
};


/**********************************************************************//**
 * Error messages
 **************************************************************************/
const char error_message[4][24] = {
  "exe signature fail",
  "exceeding IMEM capacity",
  "checksum fail",
  "SPI flash access failed"
};

/**********************************************************************//**
 * This global variable keeps the size of the available executable in bytes.
 * If =0 no executable is available (yet).
 **************************************************************************/
volatile uint32_t exe_available;


/**********************************************************************//**
 * Only set during executable fetch (required for capturing STORE BUS-TIMOUT exception).
 **************************************************************************/
volatile uint32_t getting_exe;



/**********************************************************************//**
 * Store content of instruction memory to SPI flash.
 **************************************************************************/
void save_exe(void) {


  // size of last uploaded executable
  uint32_t size = exe_available;
  uint8_t idcode;
  uint8_t device_id;

  if (size == 0) {
    PRINT_TEXT("No executable available.");
    return;
  }

  uint32_t spi_addr = (uint32_t)SPI_FILE_BASE_ADDR;



   //  check this function is needed later 23 october 2024
  //spi_flash_read_device_id(&idcode, &device_id);


  // check if flash ready (or available at all)
    if (idcode == 0x00) { // manufacturer ID
      system_error(ERROR_FLASH);
    }

    PRINT_TEXT("\r\nFlash ID : ");
    PRINT_XNUM(idcode);
    PRINT_TEXT("\r\nFlash Type : ");
    PRINT_XNUM(device_id);

  // info and prompt
  PRINT_TEXT("Write ");
  PRINT_XNUM(size);
  PRINT_TEXT(" bytes to SPI flash @0x");
  PRINT_XNUM(spi_addr);
  PRINT_TEXT("? (y/n) ");

  char c = PRINT_GETC();
  PRINT_PUTC(c);
  if (c != 'y') {
    return;
  }



  PRINT_TEXT("\nFlashing... ");




  PRINT_TEXT("\r\n Finished Erasing Sectors   : ");

  // write EXE signature
 // spi_flash_write_word(addr + EXE_OFFSET_SIGNATURE, EXE_SIGNATURE);

  // write size
 // spi_flash_write_word(addr + EXE_OFFSET_SIZE, size);

  // store data from instruction memory and update checksum
  uint32_t checksum = 0;
 // uint32_t *pnt = (uint32_t*)DDR_LOAD_BASE_ADDR;
 // addr = addr + EXE_OFFSET_DATA;
  spi_flash_write_file ( spi_addr, (uint8_t*)DDR_DOWNLOAD_BASE_ADDRESS, size);

  PRINT_TEXT(" Flashing OK");

}


/**********************************************************************//**
 * Get executable stream.
 *
 * @param src Source of executable stream data. See #EXE_STREAM_SOURCE.
 **************************************************************************/
void get_exe(int src) {

  getting_exe = 1; // to inform trap handler we were trying to get an executable

  // flash image base address
  uint32_t addr = (uint32_t)SPI_FILE_BASE_ADDR;

  // get image from flash?
  if (src == EXE_STREAM_UART) {
    PRINT_TEXT("Awaiting neorv32_exe.bin... ");
  }


  // check if valid image
  uint32_t signature = get_exe_word(src, addr + EXE_OFFSET_SIGNATURE);
  if (signature != EXE_SIGNATURE) { // signature
    system_error(ERROR_SIGNATURE);
    return;
  }

  // image size and checksum
  uint32_t size  = get_exe_word(src, addr + EXE_OFFSET_SIZE); // size in bytes
  uint32_t check = get_exe_word(src, addr + EXE_OFFSET_CHECKSUM); // complement sum checksum

  g_file_size  = size;
  g_checksum   = check;

  // transfer program data
  uint32_t *pnt =  (uint32_t*)DDR_DOWNLOAD_BASE_ADDRESS;
  uint32_t checksum = 0;
  uint32_t d = 0, i = 0;
  addr = addr + EXE_OFFSET_DATA;
  while (i < (size/4)) { // in words
    d = get_exe_word(src, addr);
    checksum += d;
    pnt[i++] = d;
    addr += 4;
  }

  // error during transfer?
  if ((checksum + check) != 0) {
    system_error(ERROR_CHECKSUM);
  }
  else {
    PRINT_TEXT("OK");
    exe_available = size; // store exe size
  }

  getting_exe = 0; // to inform trap handler we are done getting an executable
}


/**********************************************************************//**
 * Get word from executable stream
 *
 * @param src Source of executable stream data. See #EXE_STREAM_SOURCE.
 * @param addr Address when accessing SPI flash.
 * @return 32-bit data word from stream.
 **************************************************************************/
uint32_t get_exe_word(int src, uint32_t addr) {

  union {
    uint32_t uint32;
    uint8_t  uint8[sizeof(uint32_t)];
  } data;

  uint32_t i;
  for (i=0; i<4; i++) {
    if (src == EXE_STREAM_UART) {
      data.uint8[i] = (uint8_t)PRINT_GETC();
    }
#if (SPI_EN != 0)
    else {
      //data.uint8[i] = spi_flash_read_byte(addr + (3-i));
      //PRINT_XNUM(data.uint8[i]);
      //PRINT_TEXT("");

    }
#endif
  }

  return data.uint32;
}


/**********************************************************************//**
 * Output system error ID and stall.
 *
 * @param[in] err_code Error code. See #ERROR_CODES and #error_message.
 **************************************************************************/
void system_error(uint8_t err_code) {

  PRINT_TEXT("\a\nERROR_"); // output error code with annoying bell sound
  PRINT_PUTC('0' + ((char)err_code));
  PRINT_PUTC(':');
  PRINT_PUTC(' ');
  PRINT_TEXT(error_message[err_code]);

 // neorv32_cpu_dint(); // deactivate IRQs
#if (STATUS_LED_EN != 0)
  if (neorv32_gpio_available()) {
    neorv32_gpio_port_set(1 << STATUS_LED_PIN); // permanently light up status LED
  }
#endif

   //while(1); // freeze
}



