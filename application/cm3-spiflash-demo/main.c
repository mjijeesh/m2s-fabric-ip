/*******************************************************************************
*  Timer with Single shot
 */


#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "fpga_design_config/fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreTimer/core_timer.h"
#include "drivers/fpga_ip/CoreSPI/core_spi.h"


#include "delay/delay.h"
#include "spi_flash/spi_flash.h"
#include "stdio/uart_downloader.h"
#include "stdio/uart_hexview.h"
#include "stdio/uart_stdio.h"



//#define BUFFER_SIZE 128

static uint8_t g_flash_sig_buf[5];

extern uint8_t g_flash_wr_buf[BUFFER_SIZE];
extern uint8_t g_flash_rd_buf[BUFFER_SIZE];



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


UART_instance_t g_uart;
gpio_instance_t g_gpio;
spi_instance_t  g_spi_0;

void flash_device_info(void);
void display_options(void);
void display_prompt(void);
void init_buffers (void);
void menu (void);
void init_buffers (void);
void Flash_Read_Sector (uint32_t addr);
void Flash_Write_Sector (uint32_t addr);
void Flash_Write_Signature (uint32_t addr);
void Flash_Erase_Sectors (uint32_t addr, uint32_t size);
void sp_flash_write_file ( uint32_t addr, uint8_t *  buffer, uint32_t size);
void print_help(void);

void  LEDToggle (void);


// these are declared in uart_downloader.c

extern uint32_t g_file_size;
extern uint32_t g_checksum;

void hw_init(void);




void  LEDToggle (void) {


    GPIO_set_outputs(&g_gpio, 1);
    delay_ms(1000);
    GPIO_set_outputs(&g_gpio,0);
    delay_ms(1000);

}


/*==============================================================================
 * main function.
 */

uint32_t address;
int main()
{
    uint32_t gpio_in;
    uint32_t timer2_load_value;
    uint8_t  key;
    uint32_t char_count=0;

    uint8_t  char_array[16];



    address = 0;


    hw_init();

    /* initialise the buffer for reading/writing */
    spi_demo_init_buffers();

    /*--------------------------------------------------------------------------
         * Send greeting message over the UART.
         *
    */

        PRINT_TEXT("\n\n\n<< Smartfusion2  SPI Flash Demo >>\n\n");

        print_help();
        display_prompt();




    /*--------------------------------------------------------------------------
     * Foreground loop.
     */
    for(;;)
    {
        //LEDToggle ();
        menu();

    }
}


void display_prompt(void) {

    PRINT_TEXT("\r\nCREATIVE-BRD>");

}


void menu (void){
  uint8_t key,i ;
  uint32_t addr_offset=0;
  uint32_t d_size = 256 ;
  uint32_t spi_addr;
  uint32_t g_buffer[4] ;
  uint32_t test_addr;

  spi_addr = 0; //SPI_ROOT_ADDR;




    while(1)
        {


             /**********************************************************************
             * Read data received by the UART.
             *********************************************************************/

                key = uart_getchar();
                uart_putc(key);


                switch(key)
                {
                    case 'i':
                        spi_flash_device_info();

                        break;
                    case 'd':
                           PRINT_TEXT("\r\n Flash address:");
                           PRINT_XNUM(spi_addr);
                           hex_view_spi_flash(spi_addr, 4096);
                           break;
                    case '1':
                        spi_addr = spi_addr + 4096;

                        break;
                    case '2':
                        spi_addr = spi_addr - 4096;
                            break;
                    case 'w':
                        spi_flash_write_sector (spi_addr);
                        break;

                    case 'h':
                    case 'H':
                        print_help();
                        break;

                  /*
                    case 'u':
                        get_exe(EXE_STREAM_UART);
                        PRINT_TEXT("\r\n File Size : ");
                        PRINT_XNUM(g_file_size);
                        PRINT_TEXT("\r\n File Checksum : ");
                        PRINT_XNUM(g_checksum);

                        break;
                    case 'f':
                        save_exe();
                        PRINT_TEXT("\r\n File Size : ");
                        PRINT_XNUM(g_file_size);
                        PRINT_TEXT("\r\n File Checksum : ");
                        PRINT_XNUM(g_checksum);

                            break;
                    case 'm':
                        PRINT_TEXT("\r\n DDR location :");
                        PRINT_XNUM(DDR_DOWNLOAD_BASE_ADDRESS);
                        hex_view_buffer(g_file_ptr,0, 4096);
                        break;

                    case 'd':
                        hex_view_spi_flash(SPI_ROOT_ADDR, g_file_size);
                        break;
                   */
                    case 'e':
                        spi_flash_erase_sectors (spi_addr, 9120);
                        break;
                    case 'x':

                        spi_demo_init_buffers ();

                        break;


                }
               // display_options();
                display_prompt();


        }

}





void hw_init(void){

    /* Turn off the watchdog */
         SYSREG->WDOG_CR = 0;

        SystemCoreClockUpdate();

        /* Initialise Systick for delay_ms */
         SysTick_Init ();

        /*--------------------------------------------------------------------------
         * Configure GPIOs
         */
        //gpio_init();
        //MSS_GPIO_init(); // initialise the GPIO peripheral
        GPIO_init( &g_gpio,    COREGPIO_C1, GPIO_APB_32_BITS_BUS );



        /*  gpio is preconfigured in Libero , so no need to do it here */




        GPIO_config( &g_gpio,GPIO_0, GPIO_OUTPUT_MODE); // LED0:
        GPIO_config( &g_gpio,GPIO_1, GPIO_OUTPUT_MODE); // LED1:


        GPIO_config( &g_gpio,GPIO_2, GPIO_OUTPUT_MODE); // LCD_BL: DISPLAY Backlit
        GPIO_config( &g_gpio,GPIO_3, GPIO_OUTPUT_MODE); // SD_CS:
        GPIO_config( &g_gpio,GPIO_4, GPIO_OUTPUT_MODE); // TP_CS

        GPIO_config( &g_gpio,GPIO_5, GPIO_OUTPUT_MODE); // LED1
        GPIO_config( &g_gpio,GPIO_6, GPIO_OUTPUT_MODE); // LED2:

        GPIO_config( &g_gpio,GPIO_7, GPIO_INPUT_MODE); // TP_IRQ

        /* Configure the UART */

        UART_init(&g_uart, COREUARTAPB_C0,BAUD_VALUE_115200, (DATA_8_BITS | NO_PARITY) );



        /*--------------------------------------------------------------------------
             * Configure SPI. CORESPI_C0 is connected to onboard SPI flash memory
             */


            SPI_init(&g_spi_0, CORESPI_C0,32 );
            SPI_configure_master_mode( &g_spi_0 );
            SPI_enable(&g_spi_0);


}


/**********************************************************************//**
 * Print help menu.
 **************************************************************************/
void print_help(void) {

  PRINT_TEXT("Available CMDs:\n"
                     " h: Help\n"
                     " i: Display SPI Flash Device Info\n"
                     " d: Display SPI Flash Content at spi_addr \n"
                     " 1: Increment the spi_addr by 4K\n"
                     " 2: Decrementthe spi_addr by 4K\n"
                     " w: Write the initialized buffer content to SPI Flash @spi_addr\n"
                     " e: erase multiple sector of SPI flash starting at spi_addr  \n"
                     " x: initialize the buffers for read/write operation\n"

                     );
}


