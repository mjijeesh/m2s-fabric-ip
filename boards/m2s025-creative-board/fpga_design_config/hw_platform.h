#ifndef Bootloader_HW_PLATFORM_H_
#define Bootloader_HW_PLATFORM_H_
/*****************************************************************************
*
*Created by Microsemi SmartDesign  Tue Jul 10 12:33:01 2018
*
*Memory map specification for peripherals in Bootloader
*/


//#include "CMSIS/system_m2sxxx.h"


/* enable this below for verbose output from terminal */

#define VERBOSE
#define UI_MODE   1
//extern uint32_t g_FrequencyFIC0 = MSS_SYS_FIC_0_CLK_FREQ;
#define SYS_CLK 50000000

#ifndef UART_BAUD_115200
#define UART_BAUD_115200  (SYS_CLK /(115200 * 16)) - 1
#endif


#define COREUARTAPB_0                0x50001000U
#define COREGPIO_0                   0x50002000U
#define CORETIMER_0                  0x50003000U
#define COREGPIO_1                   0x50004000U

#define CORESPI_0                    0x50006000U
#define CORESPI_1                    0x50005000U

/*  SPi Flash is connected at CORE_SPI_0
 *  SD Card   is connected at CORE_SPI_1
 */

#define CLK_DIV_REG_OFFSET           0x2cu
#define SPI_SLAVE                    0




//#define SPI_BOOT_BASE_ADDR 0x08000000
#define DDR_BOOT_BASE_ADDR          0xA0000000
#define DDR_DOWNLOAD_BASE_ADDRESS   0xA0200000



/*-----------------------------------------------------------------------------
* CM3 subsystem memory map
* Master(s) for this subsystem: CM3 FABRIC2MSSFIC2 
*---------------------------------------------------------------------------*/
#define BOOTLOADER_SB_MSS_0             0x40020800U


/*
 * Base address of DDR memory where executable will be loaded.
 */
#define DDR_BASE_ADDRESS    			0xA0000000

#define DDR_IMAGE_ADDRESS    			0xA0000000

/*
 * Base address of eSRAM where executable will be loaded if used.
 */

#define ESRAM_BASE_ADDRESS    			0x20000000


/* The Executable Image is stored in the ENVM at this address,
 * copy from this addrees to eSRAM or DDR where it is going to execute
 */
#define ENVM_APP_ADDRESS    			0x20000000

/* UARt Baud rate , use maximum baud rate for IAP/ISP application where file size can be in megaBytes.
 * tested upto MSS_UART_230400_BAUD rate,  normal bootloader application 57600 or 1152000 will be enough
 */


#define MSS_UART_BAUD_RATE         MSS_UART_115200_BAUD

/*
 * Delay loop down counter load value.
 */
#define DELAY_LOAD_VALUE     0x00008000

/*
 * Bit mask identifying the DIP switch used to indicate whether the boot loader
 * should load and launch the application on system reset or stay running to
 * allow a new image to be programming into the SPI flash.
 */
#define BOOTLOADER_DIP_SWITCH   0x00000080






/******************************************************************************
 * Maximum receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    256

/******************************************************************************
 * Timer load value. This value is calculated to result in the timer timing
 * out after after 1 second with a system clock of 24MHz and the timer
 * prescaler set to divide by 1024.
 *****************************************************************************/
#define TIMER_LOAD_VALUE    23437







/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
//extern mss_uart_instance_t *g_my_uart;   // declared in ymodem.c



void Init_UART(void);
void Init_GPIO(void);
void Init_Timer(void);
void Timer1_IRQHandler( void );









#endif /* Bootloader_HW_PLATFORM_H_*/
