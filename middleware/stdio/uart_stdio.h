/*
 * misc.h
 *
 *  Created on: 30-Jul-2020
 *      Author: jijeesh
 */

#ifndef SRC_MISC_H_
#define SRC_MISC_H_

#include "hal.h"
#include "hw_platform.h"

#define NB_NIBBLES_IN_INT		8

#define  HEX   0
#define  DEC   1

void uart_putc (char  txbyte);
char uart_getc(void);
void uart_print(const char *s);
void print_hex_digit(uint32_t num);
void print_hex_byte(uint8_t num);
void print_array(uint8_t *value, uint32_t bytes);
void print_hex_word(uint32_t num);
//void uart_print(const uint8_t * text)
void print_dec_num(uint32_t value );

#define PRINT_TEXT(...) uart_print(__VA_ARGS__)
#define PRINT_XNUM(a) print_hex_word(a)
#define PRINT_DNUM(a) print_dec_num(a)
#define PRINT_GETC(a) uart_getc()
#define PRINT_PUTC(a) uart_putc(a)

uint8_t uart_getchar (void);
void  uart_print_char (uint8_t txbyte);
void uart_print_text(const uint8_t * text);
void uart_print_string(const uint8_t * text , size_t size);
uint32_t to_hex_digit(uint32_t value, uint8_t * p_result, uint8_t result_size);
uint32_t to_dec_digit(uint32_t value, uint8_t * p_result, uint8_t result_size);
void uart_print_number(uint32_t value,uint8_t descr);
void uart_print_array(uint8_t *value, uint16_t bytes, uint8_t descriptive);
void uart_print_memory(uint8_t *value,uint16_t bytes, uint8_t descriptive);
void UART_puthex8(uint8_t val);



uint32_t xatoi (                                             /* 0:Failed, 1:Successful */
		       uint8_t  **str,                          /* Pointer to pointer to the string */
		       uint32_t  *res                             /* Pointer to the valiable to store the value */
);
uint32_t  getParity(uint32_t n);



#endif /* SRC_MISC_H_ */
