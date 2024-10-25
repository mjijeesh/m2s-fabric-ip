


$(info BOARD      = M2S-CREATIVE-BRD)


BOARD_DIR= boards/m2s-creative-brd

# set the device partnumer for openocd
M2S_DEVICE = M2S025

BOARD_INC      += -I $(BOARD_DIR)
BOARD_INC      += -I $(BOARD_DIR)/drivers_config/sys_config
BOARD_INC      += -I $(BOARD_DIR)/fpga_design_config

#INCS +=	-I $(BOARD_DIR)/fpga_design_config
#INCS   += -I $(BOARD_DIR)

CORE_SRC   += $(BOARD_DIR)/drivers_config/sys_config/sys_config.c





################################################################################################
#
# Extra hardware dependency rules for SPI FLASH
#
ifdef CONFIG_USE_SPI_FLASH
$(info SPIFLASH = MICROCHIP_SST26VF Selected)
USER_FLAGS   += -D CONFIG_SPI_FLASH_MICROCHIP_SST26VF
DRIVER_INC   += -I platform/drivers/off_chip/sst26vf
DRIVER_SRC   +=  platform/drivers/off_chip/sst26vf/sst26vf.c

#C_SRCS-$(CONFIG_SERVICE_QSPI) += drivers/off_chip/sst26vf/sst26vf.c

endif


################################################################################################
#
# Linker Scripts
#
LDFILE ?= $(BOARD_DIR)/platform_config/linker/debug-in-m2s-esram.ld

$(info LINKER     = $(LDFILE))

