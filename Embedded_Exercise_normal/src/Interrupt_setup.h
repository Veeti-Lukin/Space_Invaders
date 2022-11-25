/*
 * Interrupt_setup.h
 *
 *  Created on: ------
 *      Author: ------
 */
//************************************
//***DO NOT TOUCH ANYTHING IN HERE****
//************************************

#ifndef INTERRUPT_SETUP_H_
#define INTERRUPT_SETUP_H_
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xgpiops.h"
#include "xttcps.h"
#include "xscugic.h"
#include "xparameters.h"

int SetupGpioInterruptSystem();
int SetupTimerInt();
int SetupTimerInt1();
void ButtonHandler(void *CallBackRef, u32 Bank, u32 Status);
void TickHandler(void *CallBackRef);
void TickHandler1(void *CallBackRef);
void init_interrupts();
void change_freq(uint32_t freq);


#endif /* SRC_INTERRUPT_SETUP_H_ */
