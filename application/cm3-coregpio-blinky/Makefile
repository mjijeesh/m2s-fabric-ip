

## Select the Drivers needed for the application

CONFIG_USE_CORE_GPIO    = Y
CONFIG_USE_CORE_UART    = Y
CONFIG_USE_CORE_SPI     = N
CONFIG_USE_CORE_TIMER   = N

# need the below to enable printf funtions via coreuart
USER_FLAGS += -D MSCC_STDIO_THRU_CORE_UART_APB

LDFILE      = platform/CMSIS/startup_gcc/linker/debug-in-microsemi-smartfusion2-envm.ld



APP_HOME      ?= application/$(TARGET)


APP_SRC = $(APP_HOME)/main.c 		  
		  
 
		  
APP_ASM  +=  middleware/boot/bx_user_code_ddr.S
