/*
 * uart_hex_view.c
 *
 *  Created on: 11-May-2023
 *      Author: jijeesh
 */


#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define SPI_FLASH_EN 1

#include <middleware/stdio/uart_stdio.h>
#include <middleware/stdio/uart_downloader.h>
#include <middleware/spi_flash/spi_flash.h>



/**********************************************************************//**
 * Print the Header for the Hex file/buffer
 *
 * @note This function is blocking.
 *
 * @param[in] c Char to be send.
 **************************************************************************/

void print_hex_header(void)
{

    uint8_t idk;
    PRINT_TEXT("\r\n             ");  // 12 spaces for address

    for ( idk=0 ; idk < 16 ; idk++){

        print_hex_digit(idk);
        PRINT_TEXT(" ");  // one space between bytes

    }


}

/**********************************************************************//**
 * Print one line of  data containing 16 locations.
 *  hex value followed by ascci value
 * @note This function is blocking.
 *
 * @param  addr  :  address of the buffer wher the data is kpet.
 * @param  value :  pointer to the buffer where the data is kept.
 **************************************************************************/

void print_hex_line( uint32_t addr, uint8_t *value){
    uint32_t index = 0;

    PRINT_TEXT("  ");
    PRINT_XNUM(addr);
    PRINT_TEXT("| "); // two spaces between the address and data bytes

    for ( index =0 ; index < 16; index++){
        print_hex_digit(value[index]);
        PRINT_TEXT(" "); // one space
        }
    PRINT_TEXT("  "); // two spaces


}


/**********************************************************************//**
 * Print one line of  data containing 16 locations. ascci value printing
 * @note This function is blocking.
 *
 * @param  addr  :  address of the buffer wher the data is kpet.
 * @param  value :  pointer to the buffer where the data is kept.
 **************************************************************************/

void print_ascii_line( uint32_t addr, uint8_t *value){
    uint32_t index = 0;
    PRINT_TEXT("  "); // two spaces
    PRINT_XNUM(addr);
    PRINT_TEXT("| "); // two spaces between the address and data bytes

    for ( index =0 ; index < 16; index++){
            PRINT_PUTC(value[index]);
            PRINT_TEXT(" "); // one space between each data byte
            }

}




/**********************************************************************//**
 * Print entire buffer in hex . each line with 16 location followed by its ascii value
 *
 * @note This function is blocking.
 *
 * @param  buffer      :  uint8_t pointer to input buffer where the data is available
 * @param  addr_offset :  use this field if needed to print values with a offset location other than the beginning
 *                        provide 0 if not needed
 *         size        : size of the data to be printed in bytes
 **************************************************************************/
void hex_view_buffer( uint8_t *buffer ,uint32_t addr_offset, uint32_t size){
    uint32_t addr;
    uint32_t idk;
    print_hex_header();
    addr = (uint32_t)buffer + addr_offset; // if there is an address offset  add that as well
    for ( idk=0;  idk < size;  idk = idk + 16){
    PRINT_TEXT("\r\n");
    print_hex_line(addr, &buffer[addr_offset + idk]); // get the value from pointer offset location
    print_ascii_line(addr, &buffer[addr_offset + idk]); // get the value from pointer offset location
    addr = addr + 16;  // next line increment the addr by 16
    }

}



/**********************************************************************//**
 * Print entire buffer in hex . each line with 16 location followed by its ascii value
 *
 * @note This function is blocking.
 *
 * @param  buffer      :  uint8_t pointer to input buffer where the data is available
 * @param  addr_offset :  use this field if needed to print values with a offset location other than the beginning
 *                        provide 0 if not needed
 *         size        : size of the data to be printed in bytes
 **************************************************************************/
void hex_buffer_compare( uint8_t *buffer1 , uint8_t *buffer2, uint32_t size){
    uint32_t addr1, addr2;
    uint32_t idk;
    print_hex_header();
    addr1 = (uint32_t)buffer1 ;  // if there is an address offset  add that as well
    addr2 = (uint32_t)buffer2 ;
    for ( idk=0;  idk < size;  idk = idk + 16){
    PRINT_TEXT("\r\n ");
    print_hex_line(addr1, &buffer1[idk]); // get the value from pointer offset location
    print_hex_line(addr2, &buffer2[idk]); // get the value from pointer offset location
    addr1 = addr1 + 16;  // next line increment the addr by 16
    addr2 = addr2 + 16;  // next line increment the addr by 16
    }

}





/**********************************************************************//**
 * Reads data from the SPI flash memory and prints as hex format
 *
 * @note This function is blocking.
 *
 * @param  flash_addr  :  uint32_t  flash address
 * @param  size        :  size of the data to be read in bytes
 *
 **************************************************************************/
void hex_view_spi_flash(uint32_t flash_addr, uint32_t size){
#if ( SPI_FLASH_EN != 0)
    uint32_t addr_offset =0;
    uint32_t idk,i;
    uint8_t key;
    uint8_t flash_rd_buf[256];


    print_hex_header();

   addr_offset = 0;
   while ( addr_offset < size){
          /* read as many as 128 Bytes at a time ( size of the g_rd_buf buffer */
          spi_flash_read(flash_addr + addr_offset, flash_rd_buf, sizeof(flash_rd_buf));


          /* print the read 128 bytes into 16 bytes per line 8 */
      for ( idk=0;  idk < sizeof(flash_rd_buf);  idk = idk + 16){
       PRINT_TEXT("\r\n");
       print_hex_line(flash_addr + addr_offset +idk , &flash_rd_buf[idk]); // get the value from pointer offset location
       print_ascii_line(flash_addr + addr_offset +idk , &flash_rd_buf[idk]); // get the value from pointer offset location
      }

    addr_offset = addr_offset + sizeof(flash_rd_buf);

    PRINT_TEXT("\r\n press any key to continue or 'x' to exit");
    key = PRINT_GETC();

        if ( key == 'x')
             break;
        else
            continue;

   }
#else

   return 0;
#endif

}


