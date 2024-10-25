/*******************************************************************************
*  Timer with Single shot
 */

#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "../../cm3-ymodem-demo/src/hw_platform.h"


#define BUFFER_A_SIZE   512





/*
 * Static global variables
 */
static uint8_t g_flash_wr_buf[BUFFER_A_SIZE];
static uint8_t g_flash_rd_buf[BUFFER_A_SIZE];



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


void display_options(void);
void display_prompt(void);
void init_buffers (void);
void menu (void);
void print_help(void) ;

#define DDR_BASE_ADDRESS               0xA0000000

uint8_t *g_bin_base = (uint8_t *)DDR_BASE_ADDRESS;

uint8_t *buffer_ptr =  (uint8_t * )g_flash_wr_buf;

const char test_str[] = " ------DDR memory content for Testing------ ";


// these are declared in uart_downloader.c

extern uint32_t g_file_size;
extern uint32_t g_checksum;
uint8_t * g_file_ptr = (uint8_t*)DDR_DOWNLOAD_BASE_ADDRESS;
void hw_init(void);
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

    /*--------------------------------------------------------------------------
         * Send greeting message over the UART.
         *
         */

        PRINT_TEXT("\n\n\n<< Smartfusion2 UART Downloader >>\n\n");

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
  uint8_t key ;
  uint32_t addr_offset=0;
  uint32_t d_size = 256 ;




    while(1)
        {




             /**********************************************************************
             * Read data received by the UART.
             *********************************************************************/
                //rx_size = UART_Polled_Rx( g_my_uart,rx_data, 1) ;
                key = uart_getchar();
                uart_putc(key);


                switch(key)
                {
                    case '0':
                    case 'h':
                    case 'H':
                        print_help();
                        break;
                    case 'u':
                        get_exe(EXE_STREAM_UART);
                        PRINT_TEXT("\r\n File Size : ");
                        PRINT_XNUM(g_file_size);
                        PRINT_TEXT("\r\n File Checksum : ");
                        PRINT_XNUM(g_checksum);

                        break;

                    case 'd':
                        while (addr_offset < g_file_size){
                           hex_view_buffer(g_file_ptr,addr_offset, d_size);
                           addr_offset = addr_offset+ 256;
                           PRINT_TEXT(" \\r\nPress any key to continue , press 'x' to exit ");
                           key = uart_getchar();
                           if (key == 'x'){
                                  break;
                           }
                           else{
                                continue;
                           }

                        }



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
        GPIO_init( &g_gpio,    COREGPIO_0, GPIO_APB_32_BITS_BUS );


        /* Configure the Individual GPIO bits*/

        /*  gpio is preconfigured in Libero , so no need to do it here

        GPIO_config( &g_gpio,GPIO_0, GPIO_OUTPUT_MODE); // LCD_Cs:
        GPIO_config( &g_gpio,GPIO_1, GPIO_OUTPUT_MODE); // LCD_DC:
        GPIO_config( &g_gpio,GPIO_2, GPIO_OUTPUT_MODE); // LCD_BL: DISPLAY Backlit
        GPIO_config( &g_gpio,GPIO_3, GPIO_OUTPUT_MODE); // SD_CS:
        GPIO_config( &g_gpio,GPIO_4, GPIO_OUTPUT_MODE); // TP_CS

        GPIO_config( &g_gpio,GPIO_5, GPIO_OUTPUT_MODE); // LED1
        GPIO_config( &g_gpio,GPIO_6, GPIO_OUTPUT_MODE); // LED2:

        GPIO_config( &g_gpio,GPIO_7, GPIO_INPUT_MODE); // TP_IRQ

        /* Configure the UART */

        UART_init(&g_uart, COREUARTAPB_0,UART_BAUD_115200, (DATA_8_BITS | NO_PARITY) );



        /*--------------------------------------------------------------------------
             * Configure SPI.
             */

        /*
            SPI_init(&g_spi_0, CORESPI_0,32 );
            SPI_configure_master_mode( &g_spi_0 );
            SPI_enable(&g_spi_0);

            // changing the spi_clk to pclk/32 from default ( pclk/100)
            // 127 provide 190Khz clock
            SPI_set_clk(&g_spi_0, 127 );
 */
}


/**********************************************************************//**
 * Print help menu.
 **************************************************************************/
void print_help(void) {

  PRINT_TEXT("Available CMDs:\n"
                     " h: Help\n"
                     " u: Upload binary file \n"
                     " d: Display Uploaded file in ddr memory\n"
                     " b: Load and Execute binary file  DDR \n"

                     );
}

