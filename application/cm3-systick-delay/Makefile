## -------------------------------------------
## Specify the Platform Folder where the Cortex-m3 system files and the middleware fiels are located

$(info   TARGET = cm3-coretimer-blinky)

## Select the Drivers needed for the application

CONFIG_USE_CORE_GPIO    = Y
CONFIG_USE_CORE_UART    = Y
CONFIG_USE_CORE_SPI     = N
CONFIG_USE_CORE_TIMER   = Y

# Middleware function to be used 
CONFIG_USE_DELAY       = Y


APP_HOME      ?= application/$(TARGET)

# need the below to enable printf funtions via coreuart
USER_FLAGS += -D MSCC_STDIO_THRU_CORE_UART_APB

# provide the linker fil path here, else use the default linker file
#LDFILE    ?= $(ARCH_HOME)/boards/$(TARGET_BOARD)/platform_config/linker/miv-rv32-ram.ld
#LDFILE      = $(CM3_HOME)/platform/linker/debug-in-microsemi-smartfusion2-sram.ld




#------------------------------------------------------------
# Application Source Files
#------------------------------------------------------------

APP_SRC = $(APP_HOME)/main.c 

INCS  +=  -I $(APP_HOME)

