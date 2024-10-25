/**
  ******************************************************************************
  * @file    LIB_Config.h
  * @author  Waveshare Team
  * @version 
  * @date    13-October-2014
  * @brief     This file provides configurations for low layer hardware libraries.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef _USE_LIB_CONFIG_H_
#define _USE_LIB_CONFIG_H_
//Macro Definition

/* Includes ------------------------------------------------------------------*/
#include "MacroAndConst.h"
#include "m2sxxx.h"


#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "drivers/fpga_ip/CoreSPI/core_spi.h"

#include "hw_platform.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

/*------------------------------------------------------------------------------------------------------*/
//delay
//#include "delay/delay.h"

/*------------------------------------------------------------------------------------------------------*/
//SPI
#include "Libraries/SPI/SPI.h"
/*------------------------------------------------------------------------------------------------------*/
//LCD
#include "Libraries/LCD/LCD.h"
#include "Libraries/Fonts/Fonts.h"
#include "Libraries/Delay/Delay.h"

extern spi_instance_t  g_spi_1;
extern gpio_instance_t  g_gpio;

#define Bit_SET   1
#define Bit_RESET 0
//#define LCD_RST_GPIO   GPIOB
//#define LCD_BKL_GPIO   GPIOC
//#define LCD_DC_GPIO    GPIOA
//#define LCD_CS_GPIO    GPIOB
//#define LCD_CLK_GPIO   GPIOA
//#define LCD_SDI_GPIO   GPIOA
//#define LCD_SDO_GPIO   GPIOA


//#define LCD_RST_PIN    GPIO_Pin_0

#define LCD_CS_GPIO     GPIO_4
#define LCD_DC_GPIO     GPIO_6
#define LCD_BKL_GPIO    GPIO_5


#define SD_CS_GPIO      GPIO_2
#define TP_CS_GPIO      GPIO_3


#define LCD_SPI_INSTANCE   &g_spi_1



//#define LCD_CLK_PIN    GPIO_Pin_5
//#define LCD_SDO_PIN    GPIO_Pin_6
//#define LCD_SDI_PIN    GPIO_Pin_7

//#define __LCD_RST_SET()     GPIO_WriteBit(LCD_RST_GPIO, LCD_RST_PIN, Bit_SET)
//#define __LCD_RST_CLR()     GPIO_WriteBit(LCD_RST_GPIO, LCD_RST_PIN, Bit_RESET)

#define __LCD_BKL_SET()     GPIO_set_output(&g_gpio,LCD_BKL_GPIO, Bit_SET)
#define __LCD_BKL_CLR()    GPIO_set_output(&g_gpio,LCD_BKL_GPIO, Bit_RESET)

#define __LCD_CS_SET()      GPIO_set_output(&g_gpio,LCD_CS_GPIO,  Bit_SET)
#define __LCD_CS_CLR()      GPIO_set_output(&g_gpio,LCD_CS_GPIO,  Bit_RESET)

//#define CS_DISABLE()         GPIO_set_output(&g_gpio,SD_CS_PIN, 1)
#define __LCD_DC_SET()      GPIO_set_output(&g_gpio,LCD_DC_GPIO,  Bit_SET)  //Bit_SET
#define __LCD_DC_CLR()      GPIO_set_output(&g_gpio,LCD_DC_GPIO,  Bit_RESET)

#define __LCD_WRITE_BYTE(__DATA)       spi_read_write_byte(LCD_SPI_INSTANCE, __DATA)

/*------------------------------------------------------------------------------------------------------*/
#include "PF_Config/PF_Config.h"

/*------------------------------------------------------------------------------------------------------*/

/* Exported functions ------------------------------------------------------- */


#endif

/*-------------------------------END OF FILE-------------------------------*/

