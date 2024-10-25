# This file provides the  sources and included path for the drivers used i nthe project
# add or remove the driver sectiona applicable for your need

MIDDLEWARE_HOME    := middleware

BSP_HOME    := $(CM3_HOME)/bsp


# Check if TARGET_BOARD  has spi flash mmeory is MICRON_1G_SPI_FLASH
ifeq ($(CONFIG_USE_SPI_FLASH), MICRON_1G_SPI_FLASH)
    $(info  Micron 1GB SPI Flash Used)     
    C_SRCS      += $(MIDDLEWARE_HOME)/flash/mt25ql01gbbb/micron1gflash.c
    INCS        += -I $(MIDDLEWARE_HOME)/flash
    INCS        += -I $(MIDDLEWARE_HOME)/flash/mt25ql01gbbb 

endif


# Check if TARGET_BOARD  has spi flash mmeory is MICRON_1G_SPI_FLASH

ifdef CONFIG_USE_SPI_FLASH
    $(info  Microchip SST26 Flash Used)     
    C_SRCS      += $(MIDDLEWARE_HOME)/spi_flash/spi_flash.c
    INCS        += -I $(MIDDLEWARE_HOME)/spi_flash    

endif


#other  usefull functions


ifeq ($(CONFIG_USE_DELAY), Y)
$(info DELAY  = Y   Selected)
C_SRCS      += $(MIDDLEWARE_HOME)/delay/delay.c
INCS        += -I $(MIDDLEWARE_HOME)/delay
#C_SRCS-$(CONFIG_SERVICE_QSPI) += drivers/off_chip/sst26vf/sst26vf.c
endif


ifeq ($(CONFIG_USE_PRINT), Y)
$(info PRINT  = Y   Selected)
C_SRCS      += $(MIDDLEWARE_HOME)/stdio/uart_stdio.c
INCS        += -I $(MIDDLEWARE_HOME)/stdio
#C_SRCS-$(CONFIG_SERVICE_QSPI) += drivers/off_chip/sst26vf/sst26vf.c
endif


ifeq ($(CONFIG_USE_PRINT_SPI), Y)
$(info PRINT  = Y   Selected)
C_SRCS      += $(MIDDLEWARE_HOME)/stdio/uart_hexview.c
INCS        += -I $(MIDDLEWARE_HOME)/stdio
#C_SRCS-$(CONFIG_SERVICE_QSPI) += drivers/off_chip/sst26vf/sst26vf.c
endif

ifeq ($(CONFIG_USE_UART_DOWNLOADER), Y)
$(info PRINT  = Y   Selected)
C_SRCS      += $(MIDDLEWARE_HOME)/stdio/uart_downloader.c
INCS        += -I $(MIDDLEWARE_HOME)/stdio
#C_SRCS-$(CONFIG_SERVICE_QSPI) += drivers/off_chip/sst26vf/sst26vf.c
endif






INCS        += -I $(MIDDLEWARE_HOME)



ifeq ($(CONFIG_USE_YMODEM), Y)
$(info  Using Ymodem Libraries for UART )
C_SRCS      += $(MIDDLEWARE_HOME)/ymodem/ymodem.c
INCS        += -I $(MIDDLEWARE_HOME)/ymodem
endif


#sdcard library for SPI 

ifeq ($(USE_SPI_SDCARD), YES)
 $(info  Using SPI SDCARD Libraries)
C_SRCS      += $(MIDDLEWARE_HOME)/sdcard/sdcard.c
C_SRCS      += $(MIDDLEWARE_HOME)/sdcard/sdprint.c
INCS        += -I $(MIDDLEWARE_HOME)/sdcard
endif

