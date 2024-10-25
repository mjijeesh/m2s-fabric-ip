/*
 * misc.c
 *
 *  Created on: 30-Jul-2020
 *      Author: jijeesh
 */




#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <middleware/stdio/uart_stdio.h>

#include "hal.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "hw_platform.h"

/* this has to be declared in the main.c
 *
 * mss_uart_instance_t * const g_uart  =  &g_mss_uart0 ;
 * */
extern UART_instance_t g_uart;

uint8_t uart_getchar () {
	uint8_t rx_size=0;
	uint8_t rx_buff;

	  do {
	rx_size = UART_get_rx(&g_uart, &rx_buff, sizeof(rx_buff));

	  }while ( rx_size < 1);

	return rx_buff;
}


void  uart_print_char (uint8_t txbyte) {

	UART_send(&g_uart, &txbyte, sizeof(txbyte));


}


/**********************************************************************//**
 * Send single char via UART0.
 *
 * @note This function is blocking.
 *
 * @param[in] c Char to be send.
 **************************************************************************/
void  uart_putc (char  txbyte) {

    UART_send(&g_uart, &txbyte, sizeof(txbyte));


}

/**********************************************************************//**
 * Get char from UART0.
 *
 * @note This function is blocking and does not check for UART frame/parity errors.
 *
 * @return Received char.
 **************************************************************************/
char uart_getc(void) {

  uint32_t d = 0;
  uint8_t rx_size=0;
  uint8_t rx_buff;

      do {
         rx_size = UART_get_rx(&g_uart, &rx_buff, sizeof(rx_buff));

           }while ( rx_size < 1);

      return (char)rx_buff;
    }

/**********************************************************************//**
 * Print string (zero-terminated) via UART0. Print full line break "\r\n" for every '\n'.
 *
 * @note This function is blocking.
 *
 * @param[in] s Pointer to string.
 **************************************************************************/
void uart_print(const char *s) {

  char c = 0;
  while ((c = *s++)) {
    if (c == '\n') {
      uart_putc('\r');
    }
      uart_putc(c);
  }
}


/**********************************************************************//**
 * Print 32-bit number as 8-digit hexadecimal value (with "0x" suffix).
 *
 * @param[in] num Number to print as hexadecimal.
 **************************************************************************/
void print_hex_word(uint32_t num) {

  static const char hex_symbols[16] = "0123456789ABCDEF";

  PRINT_TEXT("0x");

  int i;
  for (i=0; i<8; i++) {
    uint32_t index = (num >> (28 - 4*i)) & 0xF;

    PRINT_PUTC(hex_symbols[index]);
  }

}


/**********************************************************************//**
 * Private function to cast a string to UPPERCASE.
 *
 * @param[in] len Total length of input string.
 * @param[in,out] ptr Pointer for input/output string.
 **************************************************************************/
static void uart_touppercase(uint32_t len, char *ptr) {

  char tmp;

  while (len > 0) {
    tmp = *ptr;
    if ((tmp >= 'a') && (tmp <= 'z')) {
      *ptr = tmp - 32;
    }
    ptr++;
    len--;
  }
}



void print_dec_num(uint32_t value )
{

    uint8_t conv_array[NB_NIBBLES_IN_INT];
    unsigned int uvalue;
    unsigned int remainder;
    unsigned int digit_idx,nb_digits;
    uint8_t * p_result;
    uint8_t result_size;

    uvalue = (uint32_t)value;
    digit_idx=0;
    if (uvalue)
    {
        while (uvalue)
        {
            remainder = uvalue % 10;
            conv_array[digit_idx] = remainder + '0';
            uvalue /= 10;
            digit_idx++;
        }
    }
    else
    {
        conv_array[digit_idx] = '0';
        digit_idx++;
    }


    nb_digits = digit_idx;
    for ( digit_idx = 0; (digit_idx < nb_digits); digit_idx++ )
    {
        p_result[digit_idx] = conv_array[nb_digits - digit_idx - 1];
        PRINT_PUTC(p_result[digit_idx]);

    }

    //return digit_idx;

}

/**********************************************************************//**
 * Print 8-bit number as 2-digit hexadecimal value (with "0x" suffix).
 *
 * @param[in] num Number to print as hexadecimal.
 **************************************************************************/
void print_hex_byte(uint8_t num) {

  static const char hex_symbols[16] ="0123456789ABCDEF";

  PRINT_TEXT("0x");

  int i;
  for (i=6; i<8; i++) {
    uint32_t index = (num >> (28 - 4*i)) & 0xF;
    PRINT_PUTC(hex_symbols[index]);
  }

}


/**********************************************************************//**
 * Print 8-bit number as 2-digit hexadecimal value (without "0x" suffix).
 *
 * @param[in] num Number to print as hexadecimal.
 **************************************************************************/
void print_hex_digit(uint32_t num) {



  static const char hex_symbols[16] = "0123456789ABCDEF";

  //PRINT_TEXT("0x");

  int i;
  for (i=6; i<8; i++) {
    uint32_t index = (num >> (28 - 4*i)) & 0xF;
    PRINT_PUTC(hex_symbols[index]);
  }

}

/**********************************************************************//**
 * Printthe memory array in hex format like a hex editor (without "0x" suffix).
 *
 * @param[in] num Number to print as hexadecimal.
 **************************************************************************/


void print_hex_file(uint8_t *value,uint32_t bytes){
    uint32_t index = 0;

    for ( index =0 ; index < bytes; index=index+ 16){
        uart_print("\r\n ");

        print_array(&value[index],16);
        uart_print("\r\n ");

}
}
/**********************************************************************//**
 * Print memory array in hex format (without "0x" suffix).
 *
 * @param[in] num Number to print as hexadecimal.
 **************************************************************************/

void print_array(uint8_t *value, uint32_t bytes)
{
    int idx;
        for (idx=0;idx<bytes;idx++)
        {
            print_hex_digit(value[bytes-1-idx]);
            uart_print_text(" ");
        }
        return;

}


void uart_print_string( const uint8_t * text , size_t size)
{

    UART_send(&g_uart,text,size);

}


void uart_print_text(const uint8_t * text)
{

    uint8_t length;
    length = 0;
    while (text[length++]!='\0');
    UART_polled_tx_string(&g_uart,text);

}


void uart_print_array(uint8_t *value, uint16_t bytes, uint8_t descriptive)
{
	int idx;
	    for (idx=0;idx<bytes;idx++)
	    {
	        uart_print_number(value[bytes-1-idx], descriptive);
	        uart_print_text(" ");
	    }
	    return;

}

void uart_print_memory(uint8_t *value,uint16_t bytes, uint8_t descriptive){
	uint16_t index = 0;

	for ( index =0 ; index < bytes; index=index+ 16){
		uart_print_text("\r\n ");

		uart_print_array(&value[index],16,descriptive);
	    uart_print_text("\r\n ");

}
}




uint32_t to_hex_digit(uint32_t value, uint8_t * p_result, uint8_t result_size)
{
    int nibble_idx, nb_nibbles;
    uint8_t conv_array[NB_NIBBLES_IN_INT];
    unsigned int uvalue;
    nibble_idx = 0;
    uvalue = (uint32_t)value;

    do {
        int nibble = uvalue & 0x0F;

        if ( nibble < 10 )
            conv_array[nibble_idx] = nibble + '0';
        else
        conv_array[nibble_idx] = nibble  - 10 + 'A';
        uvalue = (uvalue >> 4);
        nibble_idx++;
    } while ( ( nibble_idx < NB_NIBBLES_IN_INT ) && ( uvalue > 0 ) );

    nb_nibbles = nibble_idx;
    for ( nibble_idx = 0; (nibble_idx < nb_nibbles) && (nibble_idx < result_size) ;nibble_idx++ )
    {
        p_result[nibble_idx] = conv_array[nb_nibbles - nibble_idx - 1];
    }
    return nibble_idx;
}

uint32_t to_dec_digit(uint32_t value, uint8_t * p_result, uint8_t result_size)
{

    uint8_t conv_array[NB_NIBBLES_IN_INT];
    unsigned int uvalue;
    unsigned int remainder;
    unsigned int digit_idx,nb_digits;

    uvalue = (uint32_t)value;
    digit_idx=0;
    if (uvalue)
    {
        while (uvalue)
        {
            remainder = uvalue % 10;
            conv_array[digit_idx] = remainder + '0';
            uvalue /= 10;
            digit_idx++;
        }
    }
    else
    {
        conv_array[digit_idx] = '0';
        digit_idx++;
    }


    nb_digits = digit_idx;
    for ( digit_idx = 0; (digit_idx < nb_digits && (digit_idx < result_size)); digit_idx++ )
    {
        p_result[digit_idx] = conv_array[nb_digits - digit_idx - 1];
    }
    return digit_idx;
}




void uart_print_number(uint32_t value,uint8_t descr)
{
	/* User Specific Code */
	uint8_t value_text[256];
	uint8_t text_size;
	    if (descr == HEX)
	    {
	        text_size = to_hex_digit( value, value_text, 8);
	    }
	    else
	    {
	        text_size = to_dec_digit( value, value_text, 8);
	    }
	   // UART_send (&g_stdio_uart, value_text, text_size);
	    UART_send(&g_uart, value_text, text_size);
	    return;
}


void UART_puthex8(uint8_t val) {
	uart_print_number(val,HEX);

}







/*

void press_any_key(void)
{
    uint8_t rx_size = 0;
    uint8_t rx_data = 0;

    MSS_UART_polled_tx_string(g_my_uart,(uint8_t *)"\r\nPress any key to continue...");
    do {
        rx_size = MSS_UART_get_rx(g_my_uart, &rx_data,1);
    } while(rx_size == 0);

}

*/


uint32_t xatoi (                                             /* 0:Failed, 1:Successful */
		       uint8_t  **str,                          /* Pointer to pointer to the string */
		       uint32_t  *res                             /* Pointer to the valiable to store the value */
)
{
		        uint32_t val;
                uint8_t c, r, s = 0;


                *res = 0;

                while ((c = **str) == ' ') (*str)++;               /* Skip leading spaces */

                if (c == '-') {                         /* negative? */
                                s = 1;
                                c = *(++(*str));
                }

                if (c == '0') {
                                c = *(++(*str));
                                switch (c) {
                                case 'x':                                /* hexdecimal */
                                case 'X':

                                                r = 16; c = *(++(*str));
                                                break;
                                case 'b':                                /* binary */
                                case 'B':

                                                r = 2; c = *(++(*str));
                                                break;
                                default:
                                                if (c <= ' ') return 1;          /* single zero */
                                                if (c < '0' || c > '9') return 0;          /* invalid char */
                                                r = 8;                      /* octal */
                                }
                } else {
                                if (c < '0' || c > '9') return 0;          /* EOL or invalid char */
                                r = 10;                                    /* decimal */
                }

                val = 0;
                while (c > ' ') {
                                if (c >= 'a') c -= 0x20;
                                c -= '0';
                                if (c >= 17) {
                                                c -= 7;
                                                if (c <= 9) return 0;           /* invalid char */
                                }
                                if (c >= r) return 0;                           /* invalid char for current radix */
                                val = val * r + c;
                                c = *(++(*str));
                }
                if (s) val = 0 - val;                                               /* apply sign if needed */

                *res = val;
                return 1;
}


uint32_t  getParity(uint32_t n)
{
	uint32_t parity = 0;
    while (n)
    {
        parity = !parity;
        n      = n & (n - 1);
    }
    return parity;
}


