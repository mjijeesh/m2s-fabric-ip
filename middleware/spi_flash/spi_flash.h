/*
 * spi_flash.h
 *
 *  Created on: 12-May-2023
 *      Author: jijeesh
 */

#ifndef MIDDLEWARE_SPI_FLASH_SPI_FLASH_H_
#define MIDDLEWARE_SPI_FLASH_SPI_FLASH_H_

#include "hal.h"
#include "ymodem/ymodem.h"

//#define CONFIG_FLASH_MICROCHIP_SST26VF 1

#ifdef CONFIG_SPI_FLASH_MICROCHIP_SST26VF
#include "sst26vf.h"
#elif defined(CONFIG_SPI_FLASH_WINBOND_W25Q)
#include "w25q.h"
#endif


//##if  (MICROCHIP_SST26VF == 1)
//##include "bsp/flash/sst26vf/sst26vf.h"
//##endif


//#define MAX_FILE_NAME_LENGTH 32





void bx_user_code_ddr(void);    // remap to the DDR and jump to the user code

void spi_flash_read_file (uint32_t addr , uint8_t *  rd_buffer ,uint32_t size );
void spi_flash_write_file ( uint32_t addr, uint8_t *  buffer, uint32_t size);
void spi_flash_read_old(uint32_t addr , uint8_t *  rd_buffer ,uint32_t size );
void spi_flash_write_sector (uint32_t addr );
void spi_flash_erase_sectors(uint32_t addr, uint32_t size);
void spi_flash_device_info();
void spi_demo_init_buffers (void);
void update_spi_flash_dir(file_t* file_name );
void display_spi_file_info(file_t* spi_file_ptr );
uint8_t spi_flash_verify_write(uint8_t* write_buff, uint8_t* read_buff, uint32_t spi_addr,  uint16_t size);
void read_spi_flash_dir(file_t* spi_dir );
int  boot_from_spi_flash(void);

#ifndef  SPI_EN
#define SPI_EN 1
#endif

/**********************************************************************//**
 * SPI flash commands
 **************************************************************************/
enum SPI_FLASH_CMD {
  SPI_FLASH_CMD_PAGE_PROGRAM = 0x02, /**< Program page */
  SPI_FLASH_CMD_READ         = 0x03, /**< Read data */
  SPI_FLASH_CMD_READ_STATUS  = 0x05, /**< Get status register */
  SPI_FLASH_CMD_WRITE_ENABLE = 0x06, /**< Allow write access */
  SPI_FLASH_CMD_READ_ID      = 0x9F, /**< Read manufacturer ID  modified by Jm for SST flash, original value 0x9E*/
  SPI_FLASH_CMD_SECTOR_ERASE = 0xD8,  /**< Erase complete sector */
  ERASE_4K_BLOCK_OPCODE      = 0x20, /* Erase 4k block */
  WRITE_STATUS_REG           = 0x01,
  GLOBAL_UNPROTECT_OPCODE    = 0x98
};






/* ---- SPI configuration ---- */

#define VALID_KEY  0xAA55AA55
#define SPI_ROOT_ADDR 0x00000000
/** SPI flash boot base address */
#ifndef SPI_BOOT_BASE_ADDR
  #define SPI_FILE_BASE_ADDR 0x00002000
#endif



/** Enable SPI module (default) including SPI flash boot options */
#ifndef SPI_EN
  #define SPI_EN 1
#endif

/** SPI flash chip select (low-active) at SPI.spi_csn_o(SPI_FLASH_CS) */
#ifndef SPI_FLASH_CS
  #define SPI_FLASH_CS  0
#endif

/** SPI flash sector size in bytes */
#ifndef SPI_FLASH_SECTOR_SIZE
  #define SPI_FLASH_SECTOR_SIZE 65536 // default = 64kB
#endif

/** SPI flash clock pre-scaler; see #NEORV32_SPI_CTRL_enum */
#ifndef SPI_FLASH_CLK_PRSC
  #define SPI_FLASH_CLK_PRSC CLK_PRSC_8
#endif


/**@}*/

#define SPI_FLASH_4K_SIZE   4096
#define SPI_SECTOR_SIZE  4096

#define BUFFER_SIZE   256




#define SPI_DIR_ROOT_ADDR  0x00000000   // sector 0

#define SPI_FILE_ROOT_ADDR  (SPI_DIR_ROOT_ADDR + 0x4000)  // sector 5 onwards
typedef struct
{
    uint32_t validity_key;
    uint32_t spi_content_byte_size;
    uint32_t spi_content_addr;
    uint8_t  spi_content_file_name[50];
} flash_content_t;



#define SPI_MAX_FILES 10
//#define FILE_NAME_LENGTH (32)
#define FILE_SIZE_LENGTH (16)

typedef struct {
    uint8_t     file_name[FILE_NAME_LENGTH];           // File name (max 32 characters)
    uint8_t     size[FILE_SIZE_LENGTH];          // file size in string
    uint32_t    file_size;       // file size in bytes
    uint32_t    file_addr;       // addr offset in spi flash memory
    uint32_t    checksum;        // file checksum
} spi_file_t;

//spi_file_t spi_directory[SPI_MAX_FILES];    // Directory to hold spi file metadata

typedef struct {
    uint32_t   init_status;        // Number of files currently stored
    uint8_t    file_count;        // Number of files currently stored
    uint32_t   next_addr;        // next available addr for new file
    spi_file_t files[SPI_MAX_FILES];   // Array of files

} spi_dir_t;

spi_dir_t spi_directory;






int spi_add_file_to_directory(spi_file_t* file_info);
void spi_print_directory(void) ;
void spi_init_directory(void);
void init_spi_file_sys (void);
void clear_spi_file_sys (void);

void print_spi_file_info(spi_file_t *file_info);
uint32_t spi_file_download(void);
void spi_file_display(uint8_t index );

//void print_spi_file_info(spi_file_t *file_info)



#endif /* MIDDLEWARE_SPI_FLASH_SPI_FLASH_H_ */
