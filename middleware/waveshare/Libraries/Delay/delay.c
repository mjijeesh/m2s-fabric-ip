/**
  ******************************************************************************
  * @file    xxx.c 
  * @author  Waveshare Team
  * @version 
  * @date    xx-xx-2014
  * @brief   xxxxx.
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
//#include "LIB_Config.h"
#include "delay.h"

#include "m2sxxx.h"
#include "system_m2sxxx.h"
#include "drivers/mss_ip/mss_timer/mss_timer.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static uint8_t  s_chFacMicro = 0;
static uint16_t s_hwFacMill = 0;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/**
 * @brief initializes delay.
 * @param wSystemCoreClock comes from system core clock.
 * @retval None
 */
void delay_init(uint32_t wSystemCoreClock)	 
{
	//SysTick_CLKSourceConfig(SysTick_CLKSource_HCLK_Div8);


	s_chFacMicro = wSystemCoreClock /1000000;	  //SystemCoreClock
	s_hwFacMill = (uint16_t)s_chFacMicro * 1000;//   
}								    

/**
 * @brief delay for n us.
 * @param wMicro = nus / (SystemCoreClock / 8000000)
 * @retval None 
 */


/*
void delay_us(uint32_t wMicro)
{		
	uint32_t wTemp;
	uint32_t tm1_load_value;

	tm1_load_value = (uint32_t)wMicro * s_chFacMicro;

	MSS_TIM1_init(MSS_TIMER_ONE_SHOT_MODE);
	MSS_TIM1_load_immediate(tm1_load_value);
	MSS_TIM1_start();
	MSS_TIM1_disable_irq();
	do {
			wTemp = MSS_TIM1_get_current_value();
		}
	while(wTemp > 0x00);
	 MSS_TIM1_stop();
}


*/

/*
void delay_ms(uint32_t wMicro){

	while(wMicro--);
}
*/


/**
 * @brief delay for n ms.
 * @param hwMill = (nms / (SystemCoreClock / 8000000)) * 1000
 * @retval None
 */

/*
void delay_ms(uint32_t hwMill)
{	 		  	  
	uint32_t wTemp;
	

	SysTick->LOAD = (uint32_t)hwMill * s_hwFacMill;
	SysTick->VAL = 0x00;           
	SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk ;         
	do {
		wTemp = SysTick->CTRL;
	}
	while((wTemp & 0x01) && !(wTemp & (1 << 16)));
	SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;       
	SysTick->VAL = 0X00;       
} 
*/



void delay_ms(uint32_t hwMill)
{
	uint32_t wTemp;
	uint32_t tm1_load_value;


	tm1_load_value = (uint32_t)hwMill * s_hwFacMill;



	MSS_TIM1_init(MSS_TIMER_ONE_SHOT_MODE);
	MSS_TIM1_load_immediate(tm1_load_value);
    MSS_TIM1_start();
  	MSS_TIM1_disable_irq();
  	do {
  			wTemp = MSS_TIM1_get_current_value();
  		}
  	while(wTemp > 0x00);
  	 MSS_TIM1_stop();

}



/*-------------------------------END OF FILE-------------------------------*/

