/*
 * delay.h
 *
 *  Created on: 26-Aug-2020
 *      Author: jijeesh
 */

#ifndef DELAY_H_
#define DELAY_H_

#include "hw_platform.h"
#include "CMSIS/m2sxxx.h"
#include "CMSIS/system_m2sxxx.h"

void SysTick_Init (void);
void delay_ms (uint32_t t);
uint32_t millis (void);




#endif /* DELAY_H_ */
