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


#include <stdio.h>
#include "fpga_design_config/fpga_design_config.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "CMSIS/system_m2sxxx.h"



gpio_instance_t g_gpio;



/*==============================================================================
  Private functions.
 */
static void delay(void);



/*==============================================================================
 * main() function.
 */
int main()
{
    uint8_t g_gpio_pattern;
    uint32_t count=0;

    /* Turn off the watchdog */
         SYSREG->WDOG_CR = 0;

         SystemCoreClockUpdate();



    /* Configure  Fabric GPIOs */

      GPIO_init( &g_gpio,    COREGPIO_C1, GPIO_APB_32_BITS_BUS );

      GPIO_config(  &g_gpio,     GPIO_0, GPIO_OUTPUT_MODE);
      GPIO_config(  &g_gpio,     GPIO_1, GPIO_OUTPUT_MODE);


    /* Foreground loop.  */
            for(;;)
            {

                delay();
                count++;

               g_gpio_pattern = GPIO_get_outputs(&g_gpio);
               g_gpio_pattern = g_gpio_pattern ^ 0xff;
               GPIO_set_outputs(&g_gpio, g_gpio_pattern);

               //iprintf("Hello World v4 : %d\r\n",count);
            }
}

/*==============================================================================
  Delay between displays of the watchdog counter value.
 */
static void delay(void)
{
    volatile uint32_t delay_count = SystemCoreClock / 128u;
    
    while(delay_count > 0u)
    {
        --delay_count;
    }
}
