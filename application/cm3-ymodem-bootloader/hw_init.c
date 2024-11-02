/*
 * hw_init.c
 *
 *  Created on: Oct 23, 2024
 *      Author: jijeesh
 */



#include "fpga_design_config/fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreTimer/core_timer.h"
#include "drivers/fpga_ip/CoreSPI/core_spi.h"


#include "delay/delay.h"
#include "spi_flash/spi_flash.h"
#include "stdio/uart_downloader.h"
#include "stdio/uart_hexview.h"
#include "stdio/uart_stdio.h"

UART_instance_t g_uart;
gpio_instance_t g_gpio;
spi_instance_t  g_spi_0;


void hw_init(void){

    /* Turn off the watchdog */
         SYSREG->WDOG_CR = 0;

        SystemCoreClockUpdate();

        /* Initialise Systick for delay_ms */
         SysTick_Init ();

        /*--------------------------------------------------------------------------
         * Configure GPIOs
         */
        //gpio_init();
        //MSS_GPIO_init(); // initialise the GPIO peripheral
        GPIO_init( &g_gpio,    COREGPIO_C1, GPIO_APB_32_BITS_BUS );



        /*  gpio is preconfigured in Libero , so no need to do it here */




        GPIO_config( &g_gpio,GPIO_0, GPIO_OUTPUT_MODE); // LED0:
        GPIO_config( &g_gpio,GPIO_1, GPIO_OUTPUT_MODE); // LED1:


        GPIO_config( &g_gpio,GPIO_2, GPIO_OUTPUT_MODE); // LCD_BL: DISPLAY Backlit
        GPIO_config( &g_gpio,GPIO_3, GPIO_OUTPUT_MODE); // SD_CS:
        GPIO_config( &g_gpio,GPIO_4, GPIO_OUTPUT_MODE); // TP_CS

        GPIO_config( &g_gpio,GPIO_5, GPIO_OUTPUT_MODE); // LED1
        GPIO_config( &g_gpio,GPIO_6, GPIO_OUTPUT_MODE); // LED2:

        GPIO_config( &g_gpio,GPIO_7, GPIO_INPUT_MODE); // TP_IRQ

        /* Configure the UART */

        UART_init(&g_uart, COREUARTAPB_C0,BAUD_VALUE_115200, (DATA_8_BITS | NO_PARITY) );



        /*--------------------------------------------------------------------------
             * Configure SPI. CORESPI_C0 is connected to onboard SPI flash memory
             */


            SPI_init(&g_spi_0, CORESPI_C0,32 );
            SPI_configure_master_mode( &g_spi_0 );
            SPI_enable(&g_spi_0);


}

