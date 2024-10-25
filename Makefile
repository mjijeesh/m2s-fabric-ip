

# cm3-systick-blinky, cm3-coretimer-blinky,cm3-systick-delay,cm3-spiflash-demo,cm3-coreuart-ymodem
#TARGET   ?= cm3-coreuart-printf-v5
TARGET   ?= cm3-ymodem-demo
BOARD    ?= m2s-creative-brd

# need the below to enable printf funtions via coreuart
USER_FLAGS += -D MSCC_STDIO_THRU_CORE_UART_APB 


APP_INC += -I . \
           -I application \
		   -I middleware \
		   -I platform
		   

APP_SRC += $(MIDDLEWARE_SRC)


# Select the target application 
# provide the TARGET name in either through the  command or  specify  here in the top 
# make  BOARD=m2s-creative-brd TARGET=cm3-systick-blinky clean all 
# eg TARGET   ?= cm3-systick-blinky
# refer to the readme for valid exampel TARGET apps.

ifneq ("$(wildcard application/${TARGET}/Makefile)","")
  include application/${TARGET}/Makefile
else
  ifndef TARGET
    TARGET:=cm3-systick-blinky
    export TARGET
    $(info INFO: TARGET not specified, defaulting to ${TARGET}) # default to creative board if nothing found
    include application/${TARGET}/Makefile
  else
    $(error application >>${TARGET}<< not found)
  endif
endif


# include the  common makefile commands file
include platform/config/build.mk