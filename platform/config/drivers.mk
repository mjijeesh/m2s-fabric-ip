# This file provides the  sources and included path for the drivers used i nthe project
# add or remove the driver sectiona applicable for your need

DRIVERS_HOME  := platform/drivers

FPGA_DRIVERS  := $(DRIVERS_HOME)/fpga_ip
MSS_DRIVERS   := $(DRIVERS_HOME)/mss_ip

#DRIVERS_HOME  := platform/drivers

# Check if TARGET_BOARD is splash  is equal to 'hello'
ifeq ($(TARGET_BOARD), polarfire-splash-kit)
    $(info  Polarfire Splash Kit is the Target Board)
	
else ifeq ($(TARGET_BOARD), polarfire-eval-kit)
    $(info  Polarfire Eval Kit is the Target Board)

endif


ifneq (,$(findstring MSS_TSE,$(USER_FLAGS)))
C_SRCS +=  $(MSS_DRIVERS)/mss_ethernet_mac/mss_ethernet_mac.c	      
INCS   += -I $(MSS_DRIVERS)/mss_ethernet_mac
endif


#---------------------------------------------------
# Select one of the MAC IP for the project
#   USER_FLAGS :=-D USE_CoreTSE 
#   USER_FLAGS :=-D USE_MSSTSE
#------------------------------------------------------
ifneq (,$(findstring MSS_TSE,$(USER_FLAGS)))
C_SRCS +=  $(MSS_DRIVERS)/mss_ethernet_mac/mss_ethernet_mac.c	      
INCS   += -I $(MSS_DRIVERS)/mss_ethernet_mac
endif



ifeq ($(TARGET_BOARD), polarfire-eval-kit)	

   ifneq (,$(findstring CORE_TSE,$(USER_FLAGS)))
   USER_FLAGS += -D PHY_VSC8575 
    C_SRCS += $(FPGA_DRIVERS)/CoreTSE/core_tse.c \
			$(FPGA_DRIVERS)/CoreTSE/crc32.c   			
	INCS   += -I $(FPGA_DRIVERS)/CoreTSE
	C_SRCS += $(ARCH_HOME)/middleware/ZL30364/zl30364_config.c  
    INCS   += -I $(ARCH_HOME)/middleware/ZL30364

	
  endif
endif


ifeq ($(TARGET_BOARD), polarfire-splash-kit)

   ifneq (,$(findstring CORE_TSE,$(USER_FLAGS)))
	USER_FLAGS += -D PHY_VSC8541
	C_SRCS += $(FPGA_DRIVERS)/CoreTSE/core_tse.c \
			$(FPGA_DRIVERS)/CoreTSE/crc32.c   			
	INCS   += -I $(FPGA_DRIVERS)/CoreTSE


  endif
endif


#---------------------------------------------------
# Select one of Ethernet PHY from the below 
#   USER_FLAGS :=-D PHY_VSC8541 
#   USER_FLAGS :=-D PHY_VSC8541
#   USER_FLAGS :=-D PHY_M88E1340
#------------------------------------------------------

ifneq (,$(findstring PHY_VSC8541,$(USER_FLAGS)))
C_SRCS += $(FPGA_DRIVERS)/CoreTSE/vsc8541/vsc8541_phy.c
INCS   += -I $(FPGA_DRIVERS)/CoreTSE/vsc8541
endif

ifneq (,$(findstring PHY_VSC8575,$(USER_FLAGS)))
C_SRCS += $(FPGA_DRIVERS)/CoreTSE/vsc8575/vsc8575_phy.c
INCS   += -I $(FPGA_DRIVERS)/CoreTSE/vsc8575
endif

ifneq (,$(findstring PHY_M88E1340,$(USER_FLAGS)))
C_SRCS += $(FPGA_DRIVERS)/CoreTSE/m88e1340/m88e1340_phy.c
INCS   += -I $(FPGA_DRIVERS)/CoreTSE/m88e1340
endif



# -- ---------------------------------------------
# -- Common Driver Sources 
# -------------------------------------------------      


ifeq ($(CONFIG_USE_CORE_UART), Y)
$(info CORE_UART  = Y   )
DRIVER_SRC   +=	$(FPGA_DRIVERS)/CoreUARTapb/core_uart_apb.c
INCS     +=	-I $(FPGA_DRIVERS)/CoreUARTapb
endif

ifeq ($(CONFIG_USE_CORE_GPIO), Y)
$(info CORE_GPIO  = Y   )
DRIVER_SRC   += $(FPGA_DRIVERS)/CoreGPIO/core_gpio.c
DRIVER_INC   += -I $(FPGA_DRIVERS)/CoreGPIO
endif

ifeq ($(CONFIG_USE_CORE_SPI), Y)
$(info CORE_SPI  = Y   )
DRIVER_SRC   += $(FPGA_DRIVERS)/CoreSPI/core_spi.c
DRIVER_INC   +=	-I $(FPGA_DRIVERS)/CoreSPI
endif

ifeq ($(CONFIG_USE_CORE_TIMER), Y)
$(info CORE_SPI  = Y   )
DRIVER_SRC   += $(FPGA_DRIVERS)/CoreTimer/core_timer.c
DRIVER_INC   +=	-I $(FPGA_DRIVERS)/CoreTimer
endif
	  
		   	  
INCS     += -I $(FPGA_DRIVERS)



	         

           
#-----------------------------------------------------------                 			  
		  

            