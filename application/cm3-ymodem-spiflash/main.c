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
void add_file_to_list(file_t *file_info);
static uint32_t file_download();
void print_dir(void);
void print_file_info(file_t *file_info);
void print_file_header(void);

/* this is implemented in assembly file under  boot folder */
void bx_user_code_ddr(void);    // remap to the DDR and jump to the user code

uint8_t *g_ddr_upload_ptr =  (uint8_t *)DDR_DOWNLOAD_BASE_ADDRESS;
uint8_t *g_ddr_boot_ptr   =  (uint8_t *)DDR_BOOT_BASE_ADDR;



/* following global variables are declared in uart_downloader.c */

extern uint32_t g_file_size;  /* ymodem recieved file size in bytes */
uint32_t g_file_size;  /* ymodem recieved file size in bytes */
extern uint32_t g_checksum;   /* checksum for  file if used */


/* binary image file info */
file_t g_image_file ;

/* SPI Flash directory structure.
 * Now using a single file structure only , this can be expanded to have multiple files with a different
 * structure type later
 */

file_t  spi_dir;

// Global variable to track the current DDR memory location for the next download
uint8_t *current_ddr_ptr = (uint8_t *)DDR_DOWNLOAD_ADDRESS;


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
    uint32_t g_rx_size = 1024 * 1024 * 8; // maximum size of the file to download  is set to  1MB


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


static uint32_t file_download(void)
{
    uint32_t file_size;
    //uint8_t *g_bin_base = (uint8_t *)dest_address;
    uint32_t MAX_FILE_SIZE = 1024 * 1024 * 8; // maximum size of the file to download  is set to  1MB
    file_t file_info; // structure to keep the current downlaoded file info

    PRINT_TEXT( "\r\n------------------------ Starting YModem file transfer ------------------------\r\n" );
    PRINT_TEXT( "Please select file and initiate transfer on host computer.\r\n" );

    SysTick_Config(SystemCoreClock/100); // is this needed ?

    file_size = ymodem_receive(current_ddr_ptr, MAX_FILE_SIZE, &file_info);




    if (file_size > 0) {


        print_file_header();
        print_file_info(&file_info);


        // Add the received file to the file list
           add_file_to_list(&file_info);


        } else {
            PRINT_TEXT("File received: \n");

        }

    //g_image_file.addr     = SPI_FILE_BASE_ADDR;
    //g_image_file.checksum = VALID_KEY;

    //PRINT_TEXT("\r\nTarget SPI File Location:");
    //PRINT_XNUM(g_image_file.addr);


    return file_size;

}



/* add the ymodem recived file info to the file_list directory */
void add_file_to_list(file_t *file_info) {
    if (file_list.file_count < MAX_FILES) {



        // Add file details to the list
        strncpy(file_list.files[file_list.file_count].name, file_info->name, sizeof(file_list.files[file_list.file_count].name) - 1);
        file_list.files[file_list.file_count].name[sizeof(file_list.files[file_list.file_count].name) - 1] = '\0'; // Ensure null termination

        strncpy(file_list.files[file_list.file_count].size, file_info->size, sizeof(file_list.files[file_list.file_count].size) - 1);
        file_list.files[file_list.file_count].size[sizeof(file_list.files[file_list.file_count].size) - 1] = '\0'; // Ensure null termination


        file_list.files[file_list.file_count].bytes    = file_info->bytes; // Copy the size in bytes
        file_list.files[file_list.file_count].file_ptr = file_info->file_ptr; // Copy the pointer
        file_list.files[file_list.file_count].checksum = file_info->checksum; // Copy the checksum

        // Increment file count
        file_list.file_count++;

       // Update the DDR pointer for the next file (align to 4-byte boundary)
       current_ddr_ptr += (file_info->bytes + 3) & ~3; // Round size up to nearest 4-byte multiple


        // Check for DDR overflow
        // Optionally, check for DDR overflow
                    if (current_ddr_ptr >= (uint8_t *)(DDR_DOWNLOAD_ADDRESS + MAX_DDR_SIZE)) {
                        PRINT_TEXT("No more space in DDR for additional files!\n");

                    }
    } else {
        // Handle error: max files reached
        PRINT_TEXT("Error: Maximum number of files reached.\n");
    }
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

                        //g_file_size = rx_app_file(g_ddr_upload_ptr);
                        g_file_size =  file_download();
                        break;
                    case 'L':

                            //g_file_size = rx_app_file(g_ddr_upload_ptr);
                           print_dir(); // list teh directory
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


void print_dir(void){
// Print the file list
    int i;

    uint8_t *ptr =  (uint8_t *)DDR_DOWNLOAD_BASE_ADDRESS;

print_file_header();

// Loop through each file in the list and print details
    for (uint8_t i = 0; i < file_list.file_count; i++) {
        file_t *file = &file_list.files[i]; // Pointer to the current file

        printf("\r%-10d %-30s %-10s 0x%-14X\n",i+1, file->name, file->size, (uint32_t)(file->file_ptr));

    }



}

void print_file_info(file_t *file_info)
{

       printf("\r%-10s %-30s %-10s 0x%-14X\n", 1,file_info->name, file_info->size, (uint32_t)(file_info->file_ptr));


}

/*
void print_file_header(void)
{

    //PRINT_TEXT("File #     Name                       Size       Location  \r\n");
    PRINT_TEXT("    Name                       Size       Location  \r\n");
    PRINT_TEXT("--------------------------------------------------- \r\n");

}
*/

// Function to print the header
void print_file_header() {
    printf("\r%-10s %-30s %-10s %-15s\n", "File#", "Name", "Size", "Location");
    printf("\r%s\n", "---------------------------------------------------------------");
}
