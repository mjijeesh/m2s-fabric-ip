/*
 * hardware.c
 *
 *  Created on: 31-Jul-2020
 *      Author: jijeesh
 */

#include "delay/delay.h"

#include "stdio/uart_stdio.h"
volatile uint32_t ticks;

volatile uint32_t g_10ms_count;

inline uint32_t millis (void);



/* SysTick Interrupt Handler will count the number of milli seconds elapsed from the start ..
 *
 */
void SysTick_Handler (void)
 {
   ticks++;
   g_10ms_count += 10;

        /*
         * For neatness, if we roll over, reset cleanly back to 0 so the count
         * always goes up in proper 10s.
         */
       if(g_10ms_count < 10)
           g_10ms_count = 0;

 }


/* initialise the SystickTimer to generate an interrupt at every milli second.
 * Make sure this function is called in the hw_init() function before using any elay functions
 */

void SysTick_Init (void)
{
   uint32_t systick_load;
   SystemCoreClockUpdate();
   systick_load  = SystemCoreClock/1000 ;  // 1ms ticks
   //systick_load  = SystemCoreClock/100 ; /* 10ms ticks changed for ymodem */
   SysTick_Config(systick_load);

}


// return the system clock as milliseconds
uint32_t millis (void)
{
   return ticks;
}


/* using the current tick count and the elapsed tick count
 * any delay can be generated ( milli second and greater)
 *
 */

void delay_ms (uint32_t t)
{
  uint32_t start, end;
  start = millis();
  end = start + t;


  if (start < end) {
  	while ((millis() >= start) && (millis() < end)) {
  	  // do nothing
  	}
  } else {
    while ((millis() >= start) || (millis() < end)) {
      // do nothing
    };
  }
}







