/*
 * uart_downloader.h
 *
 *  Created on: 11-May-2023
 *      Author: jijeesh
 */

#ifndef MIDDLEWARE_STDIO_UART_DOWNLOADER_H_
#define MIDDLEWARE_STDIO_UART_DOWNLOADER_H_

uint32_t get_exe_word(int src, uint32_t addr);
void get_exe(int src);
void system_error(uint8_t err_code);
void get_exe(int src);
void save_exe(void);





/**********************************************************************//**
 * Valid executable identification signature
 **************************************************************************/
#define EXE_SIGNATURE 0x4788CAFE

/**********************************************************************//**
  Executable stream source select
 **************************************************************************/
enum EXE_STREAM_SOURCE {
  EXE_STREAM_UART  = 0, /**< Get executable via UART */
  EXE_STREAM_FLASH = 1  /**< Get executable via SPI flash */
};

#endif /* MIDDLEWARE_STDIO_UART_DOWNLOADER_H_ */
