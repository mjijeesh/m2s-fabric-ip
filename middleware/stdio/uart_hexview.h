/*
 * uart_hex_view.h
 *
 *  Created on: 11-May-2023
 *      Author: jijeesh
 */

#ifndef MIDDLEWARE_STDIO_UART_HEXVIEW_H_
#define MIDDLEWARE_STDIO_UART_HEXVIEW_H_

void print_hex_header(void);
void print_hex_line( uint32_t addr, uint8_t *value);
void print_ascii_line( uint32_t addr, uint8_t *value);
void hex_view_buffer( uint8_t *buffer ,uint32_t addr_offset, uint32_t size);
void hex_view_spi_flash(uint32_t flash_addr, uint32_t size);
void print_hex_line_notext( uint32_t addr, uint8_t *value);
void hex_buffer_compare( uint8_t *buffer1 , uint8_t *buffer2, uint32_t size);

#endif /* MIDDLEWARE_STDIO_UART_HEXVIEW_H_ */
