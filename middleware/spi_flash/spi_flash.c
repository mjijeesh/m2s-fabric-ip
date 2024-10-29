/*
 * spi_flash.c
 *
 *  Created on: 12-May-2023
 *      Author: jijeesh
 */

#include <stdint.h>
#include <stdio.h>
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

/* implmented in ymodem.c */
uint32_t ymodem_download_file_spi_flash(uint32_t spi_flash_address,uint32_t length,spi_file_t *file_info);


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





 void spi_print_dir(void) {

     spi_dir_t* spi_dir_ptr =  &spi_dir;

     printf("\r\nSPI Flash Directory:\n");

     printf("\rSPI Flash File Count : %d\n",      spi_dir_ptr->file_count);
     printf("\rSPI Flash Next Addr  : 0x%-12X\n", spi_dir_ptr->next_addr);
     printf("\rSPI Flash init flag  : 0x%-12X\n", spi_dir_ptr->init_status);

     printf("\r----------------------------------------------------------------------------\n");
     printf("\r| %-4s | %-34s | %-10s | %-12s |\n", "#", "File Name", "Size (KB)", "Addr Offset");
     printf("\r----------------------------------------------------------------------------\n");

     for (int i = 0; i < spi_dir_ptr->file_count; i++) {
         spi_file_t *spi_file = &spi_dir_ptr->files[i];  // Pointer to the current file
         if (spi_file->file_name[0] != '\0') {       // Check if entry is valid
             printf("\r| %-4d | %-34s  |  %10.2f| 0x%-10X |\n",
                    i + 1,
                    spi_file->file_name,
                    spi_file->file_size / 1024.0,
                    spi_file->file_addr);
         }
     }
     printf("\r----------------------------------------------------------------------------\n");
 }



 /* Add the File entry to the spi_file_sys */

 int spi_add_file_to_dir(spi_file_t* file_info) {
      uint32_t next_addr ;

      spi_dir_t* spi_dir_ptr =  &spi_dir;

      // Find the first empty slot or calculate the start address for the new file
      for (uint8_t i = 0; i < SPI_MAX_FILES; i++) {
          spi_file_t *file = &spi_dir_ptr->files[i]; // Pointer to the current file

          if (file->file_name[0] == '\0') {  // empty slot found
              // Empty entry found, use this slot for the new file entry
                strncpy(file->file_name, file_info->file_name, sizeof(file->file_name) - 1);
                file->file_name[sizeof(file->file_name) - 1] = '\0';  // Ensure null-termination
                file->file_size = file_info->file_size;
                file->file_addr = file_info->file_addr; // update the current file addr with the value from dir entry

                spi_dir_ptr->file_count++;  // Increment the file count in the directory

                next_addr = (file->file_addr + file->file_size  + SPI_SECTOR_SIZE - 1) & ~(SPI_SECTOR_SIZE - 1);
                spi_dir_ptr->next_addr = next_addr; // this is the addr for next file

                // Update the directory on SPI flash
                spi_flash_write_file(SPI_DIR_ROOT_ADDR, (uint8_t *)&spi_dir, sizeof(spi_dir));
                return 0;  // Success
          }
      }

      return -1;  // No empty slot available
  }



/* initialise the File system in SPI Flash Memory and load it in ram for look up */
 void init_spi_file_sys (void){
     uint8_t buffer[SPI_SECTOR_SIZE];

     spi_dir_t* spi_dir_ptr =  &spi_dir;

     // Read sector zero from SPI flash into buffer
      spi_flash_read_file(SPI_DIR_ROOT_ADDR, buffer, SPI_SECTOR_SIZE);
      memcpy(&spi_dir, buffer, sizeof(spi_dir)); // Load the buffer into the global spi_dir

      if ( spi_dir_ptr->init_status != 0xAA55AA33){

          memset(buffer, 0x00, SPI_SECTOR_SIZE);  // Clear the directory structure

          printf("\rSPI Directory not initialised\n");
          // Set the initialization status
           spi_dir_ptr->init_status = 0xAA55AA33;

           spi_dir_ptr->file_count = 0;
           spi_dir_ptr->next_addr = SPI_FILE_ROOT_ADDR; // file storage start address

           /* update the spi flash with new modifications */
           spi_flash_write_file(SPI_DIR_ROOT_ADDR, (uint8_t *)&spi_dir, sizeof(spi_dir));


      } else

      {

          printf("\rSPI Directory is initialised and loaded\n");

      }
 }


 void clear_spi_file_sys (void){

      spi_dir_t* spi_dir_ptr =  &spi_dir;

      // Clear the SPI directory structure in memory
          memset(&spi_dir, 0x00, sizeof(spi_dir_t));  // Clear the entire structure


       // Set the initialization status
        spi_dir_ptr->init_status = 0xAA55AA33;

        spi_dir_ptr->file_count = 0;
        spi_dir_ptr->next_addr = SPI_FILE_ROOT_ADDR; // file storage start address

        /* update the spi flash with new modifications */
       spi_flash_write_file(SPI_DIR_ROOT_ADDR, (uint8_t *)&spi_dir, sizeof(spi_dir));

        printf("\rSPI File System Reinitialized\n");



  }


 /* copy the  file from ddr memory to spiflash memory  spi_file_sys, and update the directory */

 /*
 void spi_flash_file_sys_download (spi_file_t * spi_file){

     uint8_t buffer[SPI_SECTOR_SIZE];

     uint32_t spi_offset_addr;

     spi_dir_t* spi_dir = (spi_dir_t*)buffer;
    // Read sector zero from SPI flash into buffer
     spi_flash_read_file(SPI_DIR_ROOT_ADDR, buffer, SPI_SECTOR_SIZE);

    ///* read the next_file store location from directory
     spi_offset_addr = spi_dir->next_addr;

     spi_flash_write_file (spi_offset_addr, (uint8_t *)spi_offset_addr,spi_file->file_size);

     ///* update the directory entry with new file info
     spi_add_file_to_directory(spi_file);


 }
 */


  uint32_t spi_file_download(void)
 {
     uint32_t file_size;
     spi_file_t spi_file_info ;
     uint32_t spi_offset_addr;
     spi_dir_t* spi_dir_ptr =  &spi_dir;

     //uint8_t *g_bin_base = (uint8_t *)dest_address;
     uint32_t MAX_FILE_SIZE = 8*1024 * 1024 * 8; // maximum size of the file to download  is set to  8MB

     /* read the next_file store location from directory */
     spi_offset_addr = spi_dir_ptr->next_addr;

     PRINT_TEXT( "\r\n------------------------ Starting YModem file transfer ------------------------\r\n" );
     PRINT_TEXT( "Please select file and initiate transfer on host computer.\r\n" );



     //SysTick_Config(SystemCoreClock/100); // is this needed ?

     file_size = ymodem_download_file_spi_flash(spi_offset_addr, MAX_FILE_SIZE, &spi_file_info);




     if (file_size > 0) {


         print_spi_file_info(&spi_file_info);

         spi_add_file_to_dir(&spi_file_info);

         } else {
             PRINT_TEXT("File received: \n");

         }
     return file_size;

 }


  void spi_file_display(uint8_t index ){

      spi_dir_t* spi_dir_ptr =  &spi_dir;  // point to the spi_dire structure in ram

      spi_file_t *spi_file = &spi_dir_ptr->files[index-1]; //  1st file is at location '0'


      uint32_t spi_addr = spi_file->file_addr;
      uint32_t size     = spi_file->file_size;

      PRINT_TEXT("\r\n File Details:");

      printf("\r| %-30s | %10.2fkb | 0x%-12X |\n",
                          spi_file->file_name,
                          spi_file->file_size / 1024.0,
                          spi_file->file_addr);
      hex_view_spi_flash(spi_addr, size);

  }


  void print_spi_file_info(spi_file_t *file_info)
  {

         printf("\r%-30s %10u  0x%-8X\n", file_info->file_name, file_info->file_size, (uint32_t)(file_info->file_addr));


  }





