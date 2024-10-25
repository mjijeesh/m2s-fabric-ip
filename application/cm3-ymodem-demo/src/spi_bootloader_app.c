/*******************************************************************************
*  Timer with Single shot
 */

#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "../../cm3-ymodem-demo/src/hw_platform.h"



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




UART_instance_t g_uart;
gpio_instance_t g_gpio;
spi_instance_t  g_spi_0;


void display_options(void);
void display_prompt(void);
void menu (void);
void hw_init(void);

/* this is implemented in assembly file under  boot folder */
void bx_user_code_ddr(void);    // remap to the DDR and jump to the user code

uint8_t *g_ddr_upload_ptr =  (uint8_t *)DDR_DOWNLOAD_BASE_ADDRESS;
uint8_t *g_ddr_boot_ptr   =  (uint8_t *)DDR_BOOT_BASE_ADDR;



/* following global variables are declared in uart_downloader.c */

extern uint32_t g_file_size;  /* ymodem recieved file size in bytes */
extern uint32_t g_checksum;   /* checksum for  file if used */


/* binary image file info */
file_t g_image_file ;

/* SPI Flash directory structure.
 * Now using a single file structure only , this can be expanded to have multiple files with a different
 * structure type later
 */

file_t  spi_dir;




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

        PRINT_TEXT("\n\n\n<< Smartfusion2   SPI Bootloader Demo >>\n\n");

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



/*
 * Put image received via ymodem into memory
 */
static uint32_t rx_app_file(uint8_t *dest_address)
{
    uint32_t received;
    uint8_t *g_bin_base = (uint8_t *)dest_address;
    uint32_t g_rx_size = 1024 * 1024 * 8;


    SysTick_Config(SystemCoreClock/100);


    PRINT_TEXT( "\r\n------------------------ Starting YModem file transfer ------------------------\r\n" );
    PRINT_TEXT( "Please select file and initiate transfer on host computer.\r\n" );

    received = ymodem_receive(g_bin_base, g_rx_size, &g_image_file);
    PRINT_TEXT("\r\nOK. Upload Completed.");
    PRINT_TEXT("\r\nFile Name:");
    PRINT_TEXT(g_image_file.name);
    PRINT_TEXT("\r\nFile Size:");
    PRINT_TEXT(g_image_file.size);
    PRINT_TEXT(" Bytes   ");

    g_image_file.addr     = SPI_FILE_BASE_ADDR;
    g_image_file.checksum = VALID_KEY;

    PRINT_TEXT("\r\nTarget SPI File Location:");
    PRINT_XNUM(g_image_file.addr);


    return received;

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
                    case 'u':

                        g_file_size = rx_app_file(g_ddr_upload_ptr);
                        break;
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

                    case 'l':
                        read_spi_flash_dir(&spi_dir );
                        g_file_size = spi_dir.bytes;
                        PRINT_TEXT(" \r\n---- Loading file from  SPI Flash ----@  ");
                        PRINT_XNUM(spi_dir.addr);
                        PRINT_TEXT("  ");
                        PRINT_XNUM(spi_dir.bytes);
                        PRINT_TEXT(" Bytes");

                        spi_flash_read_file(spi_dir.addr, g_ddr_upload_ptr, spi_dir.bytes);
                        break;


                    case 'b':

                        PRINT_TEXT("\r\n  Copying File from SPI Flash to DDR and Execute...");
                        boot_from_spi_flash();


                    case 'd':

                        read_spi_flash_dir(&spi_dir );
                        display_spi_file_info(&spi_dir );
                        g_file_size = spi_dir.bytes;
                        hex_view_spi_flash(spi_dir.addr, spi_dir.bytes);

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
                //display_options();
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


            SPI_init(&g_spi_0, CORESPI_0,32 );
            SPI_configure_master_mode( &g_spi_0 );
            SPI_enable(&g_spi_0);

}


/**********************************************************************//**
 * Print help menu.
 **************************************************************************/
void print_help(void) {

  PRINT_TEXT("Available CMDs:\n"
                     " h: Help\n"
                     " u: Upload binary file via Ymodem Protocol\n"
                     " d: Display SPI Flash Directory and File in hex view\n"
                     " s: Save the Uploaded File into SPI Flash Memory\n"
                     " l: Load SPI Flash File into DDR memory\n"
                     " x: execute the uploaded file from DDR \n"
                     " b: Load and Execute binary file from SPI Flash ( Flash-> DDR-> execute)\n"

                     );
}



