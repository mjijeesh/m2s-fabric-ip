#
# Makefile for Cortex-M3 
# 
# Example makes use of the Smartfusion2  MSS peripheral Library
#
# Authored by jijeesh@tecnomic.com
## MakFile Type 1:  uses the below command for findign and building object files
# # this create the object files into the build directory instead of the source folder.
# the vpath provides a virtual path of each source file inside the build folder 
#OBJS = $(addprefix $(BUILD_DIR)/,$(notdir $(SRCS:.c=.o)))
#vpath %.c $(sort $(dir $(SRCS)))

#OBJS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SRCS:.S=.o)))
#vpath %.S $(sort $(dir $(ASM_SRCS)))

#APP_SRC ?= $(wildcard ./*.c) $(wildcard ./*.s) $(wildcard ./*.cpp)
#APP_ASM ?= $(wildcard ./*.S)


# enable or disable the verbose message in compile

include platform/config/openocd.mk
include platform/config/gdb.mk
include platform/config/drivers.mk
include platform/config/middleware.mk



# Select the board files based on the slection, default to m2s-creative-brd if no BOARD specified
ifneq ("$(wildcard boards/${BOARD}/Makefile)","")
  include boards/${BOARD}/Makefile
else
  ifndef BOARD
    BOARD:=m2s-creative-brd
    export BOARD
    $(info INFO: BOARD not specified, defaulting to ${BOARD}) # default to creative board if nothing found
    include boards/${BOARD}/Makefile
  else
    $(error Board >>${BOARD}<< not found)
  endif
endif



ifeq ($(V), 1)
else
.SILENT:
endif


OUT         ?= firmware
TARGET_NAME ?=firmware
BUILD_DIR    = build
OBJ_DIR      = $(BUILD_DIR)/obj

TARGET      ?= firmware
BINDIR      ?= build


# Cross-compiler tools
CROSS_COMPILE ?= arm-none-eabi-
CC      = $(CROSS_COMPILE)gcc
AS      = $(CROSS_COMPILE)gcc -x assembler-with-cpp
LD      = $(CROSS_COMPILE)gcc
GDB     = $(CROSS_COMPILE)gdb
SIZE    = $(CROSS_COMPILE)size
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
NM      = $(CROSS_COMPILE)nm
ECHO    = echo
MAKE    = make
CP      = cp



# User's application include folders (don't forget the '-I' before each entry)
APP_INC ?= -I .
# User's application include folders - for assembly files only (don't forget the '-I' before each entry)
ASM_INC ?= -I .


USER_FLAGS += -D MSCC_NO_RELATIVE_PATHS


CORE_SRC   +=  platform/hal/CortexM3/cortex_nvic.c \
        	platform/CMSIS/system_m2sxxx.c

CORE_SRC  += platform/CMSIS/startup_gcc/newlib_stubs.c
# add newlib library for CoreUART or MSS_UART implmentations
#ifneq (,$(findstring MSCC_STDIO_THRU_CORE_UART_APB,$(USER_FLAGS)))
#CORE_SRC  += platform/CMSIS/startup_gcc/newlib_coreuart.c
#else
#CORE_SRC  += platform/CMSIS/startup_gcc/newlib_stubs.c
#endif
        		        		

ASM_SRCS +=	platform/hal/CortexM3/GNU/hal.S \
        	platform/hal/CortexM3/GNU/hw_reg_access.S \
        	platform/CMSIS/startup_gcc/startup_m2sxxx.S

CORE_INC += -I platform/CMSIS \
    	   -I platform/hal \
    	   -I platform/hal/CortexM3 \
    	   -I platform/hal/CortexM3/GNU \
    	  
    	  

# Define all sources

SRCS     += $(CORE_SRC)
SRCS     += $(APP_SRC)
SRCS     += $(DRIVER_SRC)
SRCS     += $(C_SRCS)


## below is to avoid error if the user application doesn't include any assembly files
ifdef APP_ASM
ASM_SRCS +=$(APP_ASM)
endif

INCDIRS  +=$(INCS)
INCDIRS  +=$(CORE_INC)
INCDIRS  +=$(APP_INC)
INCDIRS  +=$(DRIVER_INC)
INCDIRS  +=$(BOARD_INC)

# Define all object files

# this create teh object files into the build directory instead of the source folder.
# the vpath provides a virtual path of each source file inside the build folder 

#OBJS = $(addprefix $(OBJ_DIR)/,$(notdir $(SRCS:.c=.o)))
#vpath %.c $(sort $(dir $(SRCS)))

#OBJS += $(addprefix $(OBJ_DIR)/,$(notdir $(ASM_SRCS:.S=.o)))
#vpath %.S $(sort $(dir $(ASM_SRCS)))


OBJS := $(patsubst %.c,$(BINDIR)/%.o,$(SRCS))
vpath %.c $(sort $(dir $(SRCS)))

OBJS += $(patsubst %.S,$(BINDIR)/%.o,$(ASM_SRCS))
vpath %.S $(sort $(dir $(ASM_SRCS)))



# if no linker file specified in the user Makefile, use the default linker file
LDFILE ?= CMSIS/startup_gcc/debug-m2s-esram.ld


# Target output file names
# Output files
APP_ELF = $(BINDIR)/$(TARGET).elf
APP_BIN = $(BINDIR)/$(TARGET).bin
APP_HEX = $(BINDIR)/$(TARGET).hex
APP_LST = $(BINDIR)/$(TARGET).lst
APP_MAP = $(BINDIR)/$(TARGET).map
APP_SYM = $(BINDIR)/$(TARGET).sym


OPT_FLAG   := -O0
DEBUG_FLAG := -g3

#-------------------- Compile and Linking options -----------------------------#
# C Source compile options
CFLAGS	  :=-mcpu=cortex-m3 -mthumb -O0 -g3  -std=gnu11
CFLAGS    +=-specs=cmsis.specs 
CFLAGS	  +=-fmessage-length=0 -fsigned-char -fdata-sections -ffunction-sections


# Linking options 
LDFLAGS   :=-mcpu=cortex-m3 -mthumb -O0 -g3 -T$(LDFILE)
LDFLAGS	  += -Xlinker --gc-sections
LDFLAGS   +=-fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections 

# optional option to print te ram,flash utilisation
#LDFLAGS   +=-Wl,--print-memory-usage
#LDFLAGS   +=-Wl,-Map,$(BUILD_DIR)/$(APP_MAP)

# assembly files  compile options
ASM_FLAGS :=-mcpu=cortex-m3 -mthumb -O0 -g3  -x assembler-with-cpp
ASM_FLAGS +=-fmessage-length=0 -fsigned-char -fdata-sections -ffunction-sections


LIBS ?=


# below are the build list for easy access. 
# COMPILE_DIR has to be created before evry other call
#asm:     $(BUILD_DIR) $(APP_ASM)
elf:     $(BINDIR) $(APP_ELF)
hex:     $(BINDIR) $(APP_HEX)
bin:     $(BINDIR) $(APP_BIN)
lst:     $(BINDIR) $(APP_LST)
sym:     $(BINDIR) $(APP_SYM)

all: elf bin hex sym  lst size

clean_all : clean all



$(info OPTIMIZATION  = $(OPT_FLAG))
$(info DEBUG LEVEL   = $(DEBUG_FLAG))
$(info DIRS          = $(INCDIRS))
$(info SRCS          = $(SRCS))
#$ add (OBJS)  below to get individual module size
size:  $(APP_ELF)
	$(SIZE) --format=berkeley $^


$(APP_SYM): $(APP_ELF)
	$(ECHO) " NM        $@"
	@$(NM) $< > $@

$(APP_LST):$(APP_ELF)
	$(ECHO) " OBJDUMP   $@"
	$(OBJDUMP) --source --all-headers --demangle --line-numbers --wide $(APP_ELF) > $(APP_LST)
	

$(APP_HEX): $(APP_ELF)
	$(ECHO) " OBJCOPY   $@"
	@$(OBJCOPY) -O ihex $< $@

$(APP_BIN): $(APP_ELF)
	$(ECHO) " OBJCOPY   $@"
	@$(OBJCOPY) -O binary $< $@


$(APP_ELF): $(OBJS)
	$(ECHO) " LD        $@"
	@$(LD) $(OBJS) $(LDFLAGS)  -o $@

$(BINDIR):
	mkdir -p $(BINDIR)



$(BINDIR)/%.o: %.c
	$(ECHO) " CC        $@"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(INCDIRS) $(USER_FLAGS)   -c $< -o $@
	
$(BINDIR)/%.o: %.S
	$(ECHO) " AS        $@"
	@mkdir -p $(dir $@)
	@$(CC) $(ASM_FLAGS) -c $< -o $@
	


clean:
	rm -rf $(BUILD_DIR)
