/*******************************************************************************
*  Timer with Single shot
 */

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "fpga_design_config/fpga_design_config.h"


#include "delay/delay.h"
#include "spi_flash/spi_flash.h"
#include "stdio/uart_downloader.h"
#include "stdio/uart_hexview.h"
#include "stdio/uart_stdio.h"



void print_help(void);



/* buffers to keep data for SPI write and read access */
extern uint8_t g_flash_wr_buf[BUFFER_SIZE];
extern uint8_t g_flash_rd_buf[BUFFER_SIZE];

//static uint8_t file_name[FILE_NAME_LENGTH + 1]; /* +1 for nul */



/*
 * LEDs masks used to switch on/off LED through GPIOs.
 */
#define LED_MASK   (uint32_t)0x0000000F

/*
 * Push buttons mask used to detect that a button connected to the GPIO is being
 * pushed.
 */
#define SW2_MASK    (uint32_t)0x00000200

/*
 * LEDs pattern
 */
volatile uint32_t g_gpio_pattern = LED_MASK;




//UART_instance_t g_uart;
//gpio_instance_t g_gpio;
//spi_instance_t  g_spi_0;


void display_options(void);
void display_prompt(void);
void menu (void);
void hw_init(void);



/* this is implemented in assembly file under  boot folder */
void bx_user_code_ddr(void);    // remap to the DDR and jump to the user code

uint8_t *g_ddr_upload_ptr =  (uint8_t *)DDR_DOWNLOAD_BASE_ADDRESS;
uint8_t *g_ddr_boot_ptr   =  (uint8_t *)DDR_BOOT_BASE_ADDR;



/* following global variables are declared in uart_downloader.c */

extern




/*==============================================================================
 * main function.
 */


int main()
{
    uint32_t gpio_in;
    uint32_t timer2_load_value;
    uint8_t  key;
    uint32_t char_count=0;

    uint8_t  char_array[16];



    hw_init();



    /* load the spi_file_sys into the spi_dir structure;*/

     init_spi_file_sys ();


    /*--------------------------------------------------------------------------
         * Send greeting message over the UART.
         *
    */

        PRINT_TEXT("\n\n\n<< Smartfusion2  Ymodem Bootloader >>\n\n");

        print_help();
        display_prompt();




    /*--------------------------------------------------------------------------
     * Foreground loop.
     */
    for(;;)
    {

        menu();

    }
}


void display_prompt(void) {

    PRINT_TEXT("\r\nCREATIVE-BRD>");

}







void menu (void){
  uint8_t key,i,errors ;
  uint32_t addr_offset=0;
  uint32_t d_size = 256 ;
  uint32_t spi_addr;
  uint32_t g_buffer[4] ;
  uint32_t test_addr;
  uint32_t offset;

  spi_addr = SPI_FILE_BASE_ADDR;
  uint8_t  file_valid;
  errors = 0;
  offset =0;
  file_t file_info;
  uint32_t g_file_size;  /* ymodem recieved file size in bytes */




    while(1)
        {


             /**********************************************************************
             * Read data received by the UART.
             *********************************************************************/

                key = uart_getchar();
                uart_putc(key);


                switch(key)
                {

                    case 'h':
                        print_help();
                        break;
                    case 'i':
                       clear_spi_file_sys();

                            break;
                    case 'u':

                        g_file_size = spi_file_download();
                        break;

                    case 'L':
                    case 'l':

                        spi_print_dir();
                            break;

                            /*
                    case 's':
                        PRINT_TEXT("\r\nWriting into the SPI Flash Memory  Location @  ");
                        PRINT_XNUM(spi_addr);
                        spi_flash_write_file(spi_addr,g_ddr_upload_ptr, g_file_size);
                        PRINT_TEXT("\r\nVerifying the SPI Data  Written .....");
                        errors = spi_flash_verify_write(g_ddr_upload_ptr, g_ddr_boot_ptr,spi_addr, g_file_size);
                        PRINT_TEXT("\r\nFound  ");
                        PRINT_DNUM(errors);
                        PRINT_TEXT(" Errors  ");
                        update_spi_flash_dir(&g_image_file );
                        break;

                        */

                              /*
                    case 'k':
                        read_spi_flash_dir(&spi_dir );
                        g_file_size = spi_dir.bytes;
                        PRINT_TEXT(" \r\n---- Loading file from  SPI Flash ----@  ");
                        PRINT_XNUM(spi_dir.addr);
                        PRINT_TEXT("  ");
                        PRINT_XNUM(spi_dir.bytes);
                        PRINT_TEXT(" Bytes");

                        spi_flash_read_file(spi_dir.addr, g_ddr_upload_ptr, spi_dir.bytes);
                        break;
               */

                        /*
                    case 'b':


                        PRINT_TEXT("\r\n Flash address:");
                        PRINT_XNUM(SPI_DIR_ROOT_ADDR);
                        hex_view_spi_flash(SPI_DIR_ROOT_ADDR, 4096);
                     */



                    case 'd':
                      //PRINT_TEXT("\r\n Flash address:");
                      //PRINT_XNUM(spi_addr);
                      //hex_view_spi_flash(SPI_DIR_ROOT_ADDR, 4096);

                      spi_print_dir();

                      PRINT_TEXT("\r\n Enter the File index to Display content:");
                      key = uart_getchar();
                      uart_putc(key);

                      int index = key - '0';  // Subtract '0' to get the integer value


                      spi_file_display(index );
                      break;


                    case 'x':
                        if (g_file_size){
                            /*copy the file from downlaod location to boot location */
                            memcpy(g_ddr_boot_ptr,g_ddr_upload_ptr, g_file_size );
                            bx_user_code_ddr();
                        }

                        else{
                            PRINT_TEXT("\r\n upload a  binary file to execute from ddr");
                            }
                        break;



                }

                display_prompt();


        }

}




/**********************************************************************//**
 * Print help menu.
 **************************************************************************/
void print_help(void) {

  PRINT_TEXT("Available CMDs:\n"
                     " h: Help\n"
                     " i: Initialize the File system: delete all entries\n"
                     " u: Upload binary file via Ymodem Protocol\n"
                     " d: Display SPI Flash Directory and File in hex view\n"
                     " l: List The File system Directory\n"

                     );
}








