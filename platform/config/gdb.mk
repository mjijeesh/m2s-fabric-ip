
# Paths to your symbol and executable files
SYM_FILE  := $(APP_ELF)
EXEC_FILE := $(APP_ELF)
GDB       := C:\Microchip\SoftConsole-v2021.1\arm-none-eabi-gcc\bin\arm-none-eabi-gdb



GDB_TARGET   = -ex "target remote localhost:3333";
#GDB_COMMANDS = -ex "load"; -ex "monitor halt"; -ex "set mem inaccessible-by-default off" -ex "set remotetimeout 7" -ex "break main"



#gdb:$(APP_ELF)
#	$(GDB) $(APP_ELF) $(GDB_TARGET) $(GDB_COMMANDS)


#debug: $(APP_ELF)
#	@$(GDB) --nx  $(APP_ELF) \
	-ex "set mem inaccessible-by-default off" \
	-ex "set remotetimeout 100" \
	-ex "target remote localhost:3333" \
	-ex "monitor arm semihosting enable off" \
	-ex "monitor init" \
	-ex "monitor halt" \
	-ex "load" \
	-ex "break main" \
	-ex "continue"

	
debug: $(APP_ELF)
	@$(GDB) $(APP_ELF) \
	-ex "set mem inaccessible-by-default off" \
	-ex "target remote localhost:3333" \
	-ex "monitor arm semihosting enable off" \
	-ex "monitor init" \
	-ex "load" \
	-ex "break main" \
	-ex "continue"

debug_new:
	@$(GDB)  \
		-ex "file $(EXEC_FILE)" \
		-ex "symbol-file $(SYM_FILE)" \
		-ex "target remote localhost:3333" \
		-ex "monitor reset halt" \
		-ex "load" \
		-ex "break main" \
		-ex "continue"
debug2:
	@$(GDB) \
		-ex "file $(APP_ELF)"\
		-ex "symbol-file $(SYM_FILE)" \
		-ex "target remote localhost:3333"