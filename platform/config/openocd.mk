
### OpenOCD Debugger Related stuff
# OpenOCD executable
OPENOCD = openocd
# M2S_DEVICE needs to be defiend with a proper value . by defaul defined in the boards/makefile
M2S_DEVICE ?= M2S025

# OpenOCD target and configuration files
TARGET_CFG = board/microsemi-cortex-m3.cfg

# Optional OpenOCD arguments
OPENOCD_ARGS =   $(TARGET_CFG)

# OpenOCD command to set the device, provided by borads/Makefile
OPENOCD_DEVICE_CMD =  "set DEVICE $(M2S_DEVICE)"

# Other OpenOCD commands tobe used 

#adapter_khz 1000 ; reset_config srst_only ;
#OPENOCD_CMD = gdb_port 3333 ; telnet_port 4444 ; tcl_port 6666 ; init; reset halt; sleep 100;
OPENOCD_CMD = gdb_port 3333 ; telnet_port 4444 ; tcl_port 6666 ; 



## always provide the DEVICE argument before -f file.cfg argument
openocd:
	$(OPENOCD) -c $(OPENOCD_DEVICE_CMD)  -f $(OPENOCD_ARGS)  -c "$(OPENOCD_CMD)"