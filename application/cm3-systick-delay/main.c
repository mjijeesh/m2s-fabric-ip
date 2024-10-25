/*******************************************************************************
 * (c) Copyright 2009-2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * Simple SmartFusion2 microcontroller subsystem (MSS) GPIO example program.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 7923 $
 * SVN $Date: 2015-10-01 11:37:48 +0530 (Thu, 01 Oct 2015) $
 */


//#include "config.h"
#include "fpga_design_config/fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "delay/delay.h"

#define LED_MASK   (uint32_t)0x0F

UART_instance_t g_uart;
gpio_instance_t g_gpio;
//spi_instance_t  g_spi_0;


volatile uint8_t g_gpio_pattern = LED_MASK;
void  LEDToggle (void) ;
void hw_init(void);




/*==============================================================================
  Private functions.
 */
static void delay(void);


/*==============================================================================
 * main() function.
 */
int main()
{

         /* initialise the Hardware */

          hw_init();



    /* Foreground loop.  */
            for(;;)
            {
                LEDToggle ();
            }
}




void  LEDToggle (void) {


    GPIO_set_outputs(&g_gpio, 1);
    delay_ms(500);
    GPIO_set_outputs(&g_gpio,0);
    delay_ms(500);

}


void hw_init(void){

    /*--------------------------------------------------------------------------
             * Ensure the CMSIS-HAL provided g_FrequencyPCLK0 global variable contains
             * the correct frequency of the APB bus connecting the MSS timer to the
             * rest of the system.
             */
       SystemCoreClockUpdate();


    /* Configure the UART */

      UART_init(&g_uart, COREUARTAPB_C0,BAUD_VALUE_115200, (DATA_8_BITS | NO_PARITY) );

    /* Configure  Fabric GPIOs */

      GPIO_init( &g_gpio,    COREGPIO_C1, GPIO_APB_32_BITS_BUS );

      GPIO_config(  &g_gpio,     GPIO_0, GPIO_OUTPUT_MODE);
      GPIO_config(  &g_gpio,     GPIO_1, GPIO_OUTPUT_MODE);

    /* initialise the Systick for Delay generation function implmented in the delay.c
     *  */
      SysTick_Init();




}

