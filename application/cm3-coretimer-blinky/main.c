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


#include "fpga_design_config/fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreTimer/core_timer.h"


#define LED_MASK   (uint32_t)0x0F
#define TIMER_LOAD_VALUE 500000

UART_instance_t g_uart;
gpio_instance_t g_gpio;
timer_instance_t g_core_timer_0;
//spi_instance_t  g_spi_0;


volatile uint8_t g_gpio_pattern = LED_MASK;




/*==============================================================================
  Private functions.
 */
static void delay(void);

uint8_t g_welcome[]  = "\r\nCore Timer Demo";
uint8_t g_message[]  = "\r\nCore Timer Interrupt generated";



/*
 * CoreTimer Interrupt is connected to Fabric-IRQ0
 *
 */
void FabricIrq0_IRQHandler(void)
{
    static uint8_t count;
            /*
             * Toggle GPIO output pattern by doing an exclusive OR of all
             * pattern bits with ones.
             */
           if(count++>=5)
            {
                count=0;
                g_gpio_pattern = GPIO_get_outputs(&g_gpio);
                g_gpio_pattern = g_gpio_pattern ^ 0xff;
                GPIO_set_outputs(&g_gpio, g_gpio_pattern);

                UART_polled_tx_string( &g_uart, g_message );
            }

            /* Clear the interrupt within the timer */
                TMR_clear_int(&g_core_timer_0);
}



/*==============================================================================
 * main() function.
 */
int main()
{
    
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


      /* Configure the UART */

      UART_init(&g_uart, COREUARTAPB_C0,BAUD_VALUE_115200, (DATA_8_BITS | NO_PARITY) );



      /* Initialise and configure the timer */
          TMR_init(&g_core_timer_0,
                  CORETIMER_C0,
                   TMR_CONTINUOUS_MODE,
                   PRESCALER_DIV_128,
                   TIMER_LOAD_VALUE);

     /* Enable the timer to generate interrupts */
         TMR_enable_int(&g_core_timer_0);

     /* Start the timer */
         TMR_start(&g_core_timer_0);

     /* enable fabric_iq0 in NVIC */
         NVIC_EnableIRQ(FabricIrq0_IRQn);


    /* Print the Welcome mesaage */
         UART_polled_tx_string( &g_uart, g_welcome );


    /* Foreground loop.  */
            for(;;)
            {
                ;
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
