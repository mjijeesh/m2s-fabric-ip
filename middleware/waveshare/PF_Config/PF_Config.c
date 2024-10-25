/**
  ******************************************************************************
  * @file    LIB_Config.c 
  * @author  Waveshare Team
  * @version 
  * @date    13-October-2014
  * @brief     This files provide
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, WAVESHARE SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "LIB_Config.h"
#include <stdio.h>
#include <stdlib.h>

#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreTimer/core_timer.h"
#include "drivers/fpga_ip/CoreSPI/core_spi.h"
#include "hal.h"
#include "hw_platform.h"
void lcd_clear_screen(uint16_t hwColor)  ;
//Platform Configuration


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
//uint16_t g_hwDevId = 0;

/* Private function prototypes -----------------------------------------------*/
void system_init(void);

static void lcd_driver_init(void);
static void gpio_init(void);
static void lcd_spi_init(void);
static void uart_init(void);


extern UART_instance_t g_uart;
extern gpio_instance_t g_gpio;
extern spi_instance_t  g_spi_1;
extern spi_instance_t  g_spi_0;


void set_clk( spi_instance_t * this_spi, uint8_t div_val )
{

SPI_disable(LCD_SPI_INSTANCE);
HAL_set_8bit_reg( this_spi->base_addr, CLK_DIV,  div_val );
SPI_enable(LCD_SPI_INSTANCE);

}

/**
  * @brief  System initialization.
  * @param  None
  * @retval  None
  */
void system_init(void)
{

	/* Get the Clock Values from System Registers */
	SystemCoreClockUpdate();
	

/* Initialise the Timer1 with System Clock values for Delay() functions */
	//delay_init(SystemCoreClock);

	//SysTick_Init ();

/* Initialise the GPIO to use for LCD_DC, and  LCD_BK pins */
	gpio_init();


	uart_init();

/* Initialise the SPI Isntance &spi_instance_1 for the LCD Communication */
    lcd_spi_init();


/* Initialise the LCD Panel */

    lcd_driver_init();
}


static void lcd_driver_init(void)
{
	lcd_init();
    delay_ms(1000);
	lcd_clear_screen(RED);
	delay_ms(1000);
	lcd_clear_screen(GREEN);
	delay_ms(1000);
	lcd_clear_screen(BLUE);
	delay_ms(1000);
    lcd_clear_screen(BLACK);


}

static void gpio_init(void)
{
	
	GPIO_init( &g_gpio,    COREGPIO_0, GPIO_APB_32_BITS_BUS );


	/* Configured in Libero  not needed here again*/

	        //GPIO_config( &g_gpio,GPIO_0, GPIO_OUTPUT_MODE); // LCD_Cs:
			//GPIO_config( &g_gpio,GPIO_1, GPIO_OUTPUT_MODE); // LCD_DC:
			//GPIO_config( &g_gpio,GPIO_2, GPIO_OUTPUT_MODE); // LCD_BL: DISPLAY Backlit
			//GPIO_config( &g_gpio,GPIO_3, GPIO_OUTPUT_MODE); // SD_CS:
			//GPIO_config( &g_gpio,GPIO_4, GPIO_OUTPUT_MODE); // TP_CS

			//GPIO_config( &g_gpio,GPIO_5, GPIO_OUTPUT_MODE); // LED1
			//GPIO_config( &g_gpio,GPIO_6, GPIO_OUTPUT_MODE); // LED2:

			//GPIO_config( &g_gpio,GPIO_7, GPIO_INPUT_MODE); // TP_IRQ



}

static void uart_init(void){

              UART_init(&g_uart, COREUARTAPB_0,UART_BAUD_115200, (DATA_8_BITS | NO_PARITY) );
}


static void lcd_spi_init(void){



	    		/*--------------------------------------------------------------------------
					 * Configure SPI. LCD_SPI_INSTANCE
					 */

					//SPI_init(&g_spi_1, CORESPI_1,32 );
					//SPI_configure_master_mode( &g_spi_1 );
					//SPI_enable(&g_spi_1);

	    		SPI_init(LCD_SPI_INSTANCE, CORESPI_1,32 );
	    		SPI_configure_master_mode( LCD_SPI_INSTANCE );
	    		SPI_enable(LCD_SPI_INSTANCE);
	    		set_clk( &g_spi_1, 2 );




					// changing the spi_clk to pclk/32 from default ( pclk/100)
					// 127 provide 190Khz clock
					//SPI_set_clk( &g_spi_1, 127 );


}

/*-------------------------------END OF FILE-------------------------------*/

