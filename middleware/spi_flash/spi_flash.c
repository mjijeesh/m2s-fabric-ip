/*
 * spi_flash.c
 *
 *  Created on: 12-May-2023
 *      Author: jijeesh
 */

#include <stdint.h>
#include <string.h>

#include <middleware/delay/delay.h>
#include <middleware/spi_flash/spi_flash.h>
#include <middleware/stdio/uart_downloader.h>
#include <middleware/stdio/uart_hexview.h>
#include <middleware/stdio/uart_stdio.h>
#include "drivers/fpga_ip/CoreSPI/core_spi.h"
#include "ymodem/ymodem.h"

#include "spi_flash.h"


//#define DEBUG

#ifndef DDR_BOOT_BASE_ADDR
#define DDR_BOOT_BASE_ADDR 0x20000000
#endif



extern spi_instance_t * g_spi_0;

//#define SPI_FLASH_CS  SPI_SLAVE_0

#define  spi_trans(a)    SPI_transfer_frame( g_spi_0, a)
#define  spi_cs_en(ss)   SPI_set_slave_select(g_spi_0, ss)
#define  spi_cs_dis(ss)  SPI_clear_slave_select(g_spi_0, ss)



uint8_t g_flash_wr_buf[BUFFER_SIZE];
uint8_t g_flash_rd_buf[BUFFER_SIZE];


// -------------------------------------------------------------------------------------
// SPI flash driver functions
// -------------------------------------------------------------------------------------


/**********************************************************************//**
 *  Write the entire file to the SPI Flash memory
 *  The file needs to be stored in a memory location , either SRAM or the DDR space.
 *   *
 * @param[in] addr    :  target spi location .
 * @param[in] buffer  :  uint8_t pointer to the buffer where file is kept.
 * @param[in] size    :  size of the image to be written in bytes
 **************************************************************************/


void spi_flash_write_file ( uint32_t addr, uint8_t *  buffer, uint32_t size){

     uint32_t i,numb_4k_sectors;
     uint32_t  sector_addr =  addr;

     /* erase atleast 1 sector */
     numb_4k_sectors = (size / (SPI_FLASH_4K_SIZE)) + 1;
     #ifdef DEBUG
     PRINT_TEXT("\r\n Number of sectors to be erased :  " );
     PRINT_DNUM(numb_4k_sectors);
     #endif

    /* disable the protection bit if not doen already */

    spi_flash_global_unprotect();

   /* this function uses the 48 block erase command,
    * you can also use the 64K sector erase command as well */

  for (i= 0 ; i < numb_4k_sectors ; i++ ){
    #ifdef DEBUG
      PRINT_TEXT("\r\n Erasing Sector @ " );
     PRINT_XNUM(sector_addr);
    #endif
    //memset(g_flash_wr_buf, 'p', 1024);
    /* erase each sector */
    spi_flash_erase_4k_block(sector_addr);
    #ifdef DEBUG
     PRINT_TEXT("\r\n Erasing Completed \r\n :");
    #endif
    /* added a delay to make sure that the erase is completed */
     delay_ms(50);

    sector_addr += SPI_FLASH_4K_SIZE;
  }
  /* program the file to the locatio nspecified */
  spi_flash_write(addr, buffer, size);
  PRINT_TEXT("\r\nProgramming  Completed \r\n");

}




/**********************************************************************//**
 * Read  multiple bytes from  SPI flash. and print on the terminal
 * This is a helper function for the demo
 * @param[in] addr  : Flash read address.
 * @return Read byte from SPI flash.
 **************************************************************************/


void spi_flash_read_file (uint32_t addr , uint8_t *  rd_buffer ,uint32_t size ){

   uint8_t *file_ptr;
   uint32_t rcvd_size;
   uint32_t addr_offset;
   uint32_t spi_addr;

   spi_addr = addr;
   file_ptr = rd_buffer;
   addr_offset =0;

   spi_flash_read(addr , rd_buffer, size);



#ifdef DEBUG
    PRINT_TEXT("\r\nReading data From SPI Flash Addr :");
    PRINT_XNUM(addr);
    PRINT_TEXT("\r\n");
    hex_view_buffer( rd_buffer,0, size);
#endif

}



/**********************************************************************//**
 * Write data into a single sector.
 * This is a helper function for the demo.
 * keep the data ready in g_flash_wr_buf for writing
 * @param[in] addr  :  flash memory address location  uint32_t
 * @return Read byte from SPI flash.
 **************************************************************************/
void spi_flash_write_sector (uint32_t addr ){


    spi_flash_global_unprotect();

    PRINT_TEXT("\r\n Erasing Sector @ " );
    PRINT_XNUM(addr);

    spi_flash_erase_4k_block(addr);
    spi_flash_write(addr, g_flash_wr_buf, sizeof(g_flash_wr_buf));
    PRINT_TEXT("\r\nProgramming Completed \r\n :");

}

/**********************************************************************//**
 * erase multiple sector of the flsh memory
 * This is a helper function for the demo.
 * keep the data ready in g_flash_wr_buf for writing
 * @param[in] addr    :  flash memory  start location address  uint32_t
 * * @param[in] size  :   total size of the location to be erased in bytes
 * @return Read byte from SPI flash.
 **************************************************************************/



void spi_flash_erase_sectors(uint32_t addr, uint32_t size){

     uint32_t i,numb_4k_sectors;

     uint32_t  sector_addr = addr;

     numb_4k_sectors = (size / (SPI_FLASH_4K_SIZE)) + 1;
     PRINT_TEXT("\r\n Number of sectors to be erased :  " );
     PRINT_DNUM(numb_4k_sectors);

    spi_flash_global_unprotect();

  for (i= 0 ; i < numb_4k_sectors ; i++ ){
     PRINT_TEXT("\r\n Erasing Sector @ " );
    PRINT_XNUM(sector_addr);

    spi_flash_erase_4k_block(sector_addr);

    PRINT_TEXT("\r\n Erasing Completed \r\n :");
    delay_ms(500);
    sector_addr += SPI_FLASH_4K_SIZE;
  }


}

/**********************************************************************//**
 * print spi flash device info.
 * This is a helper function for the demo.

 **************************************************************************/

void spi_flash_device_info(void){

    uint8_t idcode;
    uint8_t device_id;

    spi_flash_read_device_id(&idcode, &device_id);
    PRINT_TEXT(" \r\nIdcode : ");
    print_hex_byte(idcode);
    PRINT_TEXT(" , Device ID  : ");
    print_hex_byte(device_id);
}

/**********************************************************************//**
 * This function is used to initialise the read and write buffers
 * for the spi flash demo usage..
 * This is a helper function for the demo.

 **************************************************************************/


void spi_demo_init_buffers (void){

    uint16_t loop_count;
    const char test_str[] = "****DDR memory content for Testing****";


    /*--------------------------------------------------------------------------
     * Initialize  buffer with binary data using this methods
    */
    for(loop_count = 0; loop_count < (BUFFER_SIZE/2); loop_count++)
    {
        g_flash_wr_buf[loop_count] = 0xAA;
        g_flash_rd_buf[loop_count] = 0x00;
    }


    /* below method are used for initialising the buffers with string data */
    strcpy(g_flash_wr_buf, " This is a Test String for the DDR MEmeory at 0xA0000000");
    //strncpy (g_bin_base, test_str, sizeof(test_str));

    /* copy the string / data from one buffer to another suign this method */
    memcpy (g_flash_wr_buf, test_str, sizeof(test_str));

    /* set the 128 location of the buffer with 'j' as default value */
     memset(g_flash_wr_buf,'j', 128);

    /* copy the string value to the location offset 128 of the buffer */
    memcpy (&g_flash_wr_buf[128], test_str, sizeof(test_str));


    strncpy((uint8_t *)g_flash_wr_buf, "AA55" , sizeof("AA55"));



}

void update_spi_flash_dir(file_t* file_name ){

    uint32_t spi_dir_addr = SPI_ROOT_ADDR; // always write to the first sector

    PRINT_TEXT("\r\n Updating the SPI Flash File Directory....");

    spi_flash_global_unprotect();

    PRINT_TEXT("\r\nErasing Sector @ " );
    PRINT_XNUM(SPI_ROOT_ADDR);

    spi_flash_erase_4k_block(SPI_ROOT_ADDR);
    spi_flash_write(SPI_ROOT_ADDR, (uint8_t *) file_name, sizeof(file_t));
    PRINT_TEXT("\r\n Programming  sector @ ");
    PRINT_XNUM(SPI_ROOT_ADDR);

    PRINT_TEXT("\r\nUpdated the SPI Directory");
#ifdef DEBUG
    hex_view_spi_flash(SPI_ROOT_ADDR, 256);
    hex_view_spi_flash(SPI_BOOT_BASE_ADDR, 256);
#endif

}

void read_spi_flash_dir(file_t* spi_dir ){
    flash_content_t  spi_file;
    uint32_t spi_dir_addr = SPI_ROOT_ADDR; // always write to the first sector

    spi_flash_read (spi_dir_addr, (uint8_t *) spi_dir, sizeof(file_t));

    display_spi_file_info(spi_dir );

    //PRINT_TEXT("\r\n Updated the SPI Directory");

}


void display_spi_file_info(file_t* spi_file_ptr ){

    PRINT_TEXT("\r\nFile Name : ");
    PRINT_TEXT(spi_file_ptr->name);
    PRINT_TEXT("\r\nFile Size : ");
    PRINT_DNUM(spi_file_ptr->bytes);
    PRINT_TEXT(" Bytes");
    PRINT_TEXT("\r\nFile Addr : ");
    PRINT_XNUM(spi_file_ptr->addr);


}

/***************************************************************************//**
 * Read the date from SPI FLASH and compare the same with write buffer.
 */
 uint8_t spi_flash_verify_write(uint8_t* write_buff, uint8_t* read_buff, uint32_t spi_addr,  uint16_t size)
{
    uint8_t error = 0;
    uint16_t index = 0;

    spi_flash_read(spi_addr,read_buff,size);

    while(size != 0)
    {
        if(write_buff[index] != read_buff[index])
        {
            error++;
           // break;  ideally we need to break whenever a error occured
        }
        index++;
        size--;
    }

    return error;
}


 /***************************************************************************//**
  * Read the  SPi Flash Root directory and check for any valid file written.
  * Then load the DDR memory with this file if available.
  * Boot fro mthe DDR location with the image loaded.
  */
 int  boot_from_spi_flash(void){

     /*  read the spi directory to check for any valid file available*/

     uint8_t *g_ddr_boot_ptr   =  (uint8_t *)DDR_BOOT_BASE_ADDR;

     file_t * file_ptr;

     file_ptr = (file_t *)g_flash_rd_buf;

     spi_flash_read(SPI_ROOT_ADDR, g_flash_rd_buf, sizeof(g_flash_rd_buf));

     for ( int i=0 ;i < 5; i ++){

     if (file_ptr->checksum == VALID_KEY){

       display_spi_file_info(file_ptr);
       spi_flash_read_file(file_ptr->addr, g_ddr_boot_ptr, file_ptr->bytes);

       bx_user_code_ddr();  // jump to the ddr location and execute

       return 0;

     }
     file_ptr++;  // go to next file
      }

     PRINT_TEXT ( "\r\nNo valid File Found in the spi file directory");
     return -1;
 }



