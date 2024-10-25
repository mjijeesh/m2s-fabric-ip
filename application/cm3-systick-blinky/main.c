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
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"


#define LED_MASK   (uint32_t)0x0F

//UART_instance_t g_uart;
gpio_instance_t g_gpio;
//spi_instance_t  g_spi_0;


volatile uint8_t g_gpio_pattern = LED_MASK;






//uint8_t g_message[]  = "\r\n Systick Timer Interrupt Counter";
/*==============================================================================
 * Toggle LEDs in every 1 second. every interrupt will occur at 10 ms frequency.
 * LEDs toggle at every 100 interrupt occurances
 */
void SysTick_Handler(void)
{

        static uint8_t count;
        /*
         * Toggle GPIO output pattern by doing an exclusive OR of all
         * pattern bits with ones.
         */



        if(count++>=100)
        {


            count=0;
            g_gpio_pattern = GPIO_get_outputs(&g_gpio);
            g_gpio_pattern = g_gpio_pattern ^ 0xff;
            GPIO_set_outputs(&g_gpio, g_gpio_pattern);

           // UART_polled_tx_string( &g_uart, g_message );
        }




}




/*==============================================================================
 * main() function.
 */
int main()
{
    uint32_t systick_load_value;


    /*--------------------------------------------------------------------------
         * Ensure the CMSIS-HAL provided g_FrequencyPCLK0 global variable contains
         * the correct frequency of the APB bus connecting the MSS timer to the
         * rest of the system.
         */
        SystemCoreClockUpdate();



    /* Configure  Fabric GPIOs */

      GPIO_init( &g_gpio,    COREGPIO_C1, GPIO_APB_32_BITS_BUS );

      GPIO_config(  &g_gpio,     GPIO_0, GPIO_OUTPUT_MODE);
      GPIO_config(  &g_gpio,     GPIO_1, GPIO_OUTPUT_MODE);



         /* Configure Systick Timer
          *  A load value of ( SystemCoreClock/100)  will generate interrupt at every 10ms.*/


        systick_load_value = SystemCoreClock/100;

        /* The below function loads the systick_counter laod value ,
         * the counter will be enabled and the M3 clock will be used as the clock and the interrupt is also enabled
         *
         */
        SysTick_Config(systick_load_value);



    /* Foreground loop.  */
            for(;;)
            {
                ;
            }
}

