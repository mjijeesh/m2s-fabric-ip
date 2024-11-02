## -------------------------------------------
## Specify the Platform Folder where the Cortex-m3 system files and the middleware fiels are located

$(info   TARGET = cm3-ymodem-bootloader)

APP_HOME      ?= application/$(TARGET)

## Select the Drivers needed for the application

CONFIG_USE_CORE_GPIO    = Y
CONFIG_USE_CORE_UART    = Y
CONFIG_USE_CORE_SPI     = Y
CONFIG_USE_CORE_TIMER   = Y


# provide the linker fil path here, else use the default linker file
#LDFILE    ?= $(ARCH_HOME)/boards/$(TARGET_BOARD)/platform_config/linker/miv-rv32-ram.ld
#LDFILE      = $(CM3_HOME)/platform/linker/debug-in-microsemi-smartfusion2-sram.ld

# define CONFIG_SPI_MICROCHIP_SST26VF  to use the SST26 SPI flash drivers

CONFIG_USE_SPI_FLASH       = Y
CONFIG_USE_DELAY           = Y
CONFIG_USE_PRINT           = Y
CONFIG_USE_PRINT_SPI       = Y
CONFIG_USE_UART_DOWNLOADER = N
CONFIG_USE_YMODEM          = Y



USER_FLAGS +=-DMSCC_STDIO_THRU_CORE_UART_APB 


#------------------------------------------------------------
# Application Source Files
#------------------------------------------------------------

APP_SRC += $(APP_HOME)/main.c
APP_SRC += $(APP_HOME)/hw_init.c

ASM_SRCS += middleware/boot/bx_user_code_ddr.S

INCS  +=  -I $(APP_HOME)

