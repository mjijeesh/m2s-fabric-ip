
Ymodem- SPI Flash:


This branch adds the spi flash into the Ymodem Application
Added the SPI Flash directory structure.
Now after downloading the file into the ddr memory , the same file info is added to the spi_dir and update teh same in the sector 0( 4KB)

SPI Flash Directory:
SPI Flash File Count : 2
--------------------------------------------------------------------------
| File Name                      | Size (KB)  | Addr Offset    |
--------------------------------------------------------------------------
| cm3-ymodem-spiflash.sym        |      12.35 | 0x1000         |
| cm3-ymodem-spiflash.bin        |      41.61 | 0x5000         |
--------------------------------------------------------------------------

File#      Name                           Size       Location
---------------------------------------------------------------
1          cm3-ymodem-spiflash.bin        42608      0xA0200000

SPI Flash Directory:
SPI Flash File Count : 2
--------------------------------------------------------------------------
| File Name                      | Size (KB)  | Addr Offset    |
--------------------------------------------------------------------------
| cm3-ymodem-spiflash.sym        |      12.35 | 0x1000         |
| cm3-ymodem-spiflash.bin        |      41.61 | 0x5000         |
--------------------------------------------------------------------------

29th Oct,2024
Ymodem Branch
--------------

This branch will add the yMODEM feature to the application.

Updated the Ymodem Application with pritf functions for file infor and dir listing.

launching gdb from terminal is workign for some reason.  no need to launch the gdb debug from SoftConsole. previously the make gdb was not workign with M@S external hw reset error

PS C:\jijeesh\github\m2s-fabric-ip> make openocd

followed by 

PS C:\jijeesh\github\m2s-fabric-ip> make debug // in another termianal.

TODO : Download the file contents and directory structure to the SPI Flash memory.


27th October 2024

------------------------------------------------------------------------------------------


25 Oct 2024


This  workspace provide the use of Makefile for the Cortex-M3 target.

The project is build into the build folder and all the object files are kept there.
This way the source file folders are kept neat.

The building process also provides option to generate the hex, bin , elf and lst file
the size of the elf and the individual object files are also listed.

for running the project follow the below step

# make  BOARD=m2s-creative-brd TARGET=cm3-systick-blinky clean all

This will  build the project  for cm3-systick-blinky example targeted o BOARD m2s-craive-brd 

# make  clean all 
If you don't specify any board , the default BOARD will  use m2s-creative-brd .
Similarly the TARGET example application will default to  cm3-systick-blinky if not specified.

# make BOARD=m2s-creative-brd   // default TARGET will be  cm3-systick-blinky

You can also specify the TARGET and BOARD in the Makefile as well.

modify the below lines to  proper values as desired

TARGET   ?= cm3-systick-blinky
BOARD    ?= m2s-creative-brd

The compilation will generate the object files inside the build folder with the respective folder structure kept.
The build also generate he map , bin, hex etc. file in the build folder.

PS C:\wip\m2s> make clean all
BOARD  = m2s-creative-brd
TARGET = cm3-systick-blinky
 CLEAN   BUILD directory
 Cleaned build directory.

 CC      build/platform/hal/CortexM3/cortex_nvic.o
 CC      build/platform/CMSIS/system_m2sxxx.o
 CC      build/platform/CMSIS/startup_gcc/newlib_stubs.o
 CC      build/src/cm3-systick-blinky/main.o
 CC      build/boards/m2s-creative-brd/drivers_config/sys_config/sys_config.o
 CC      build/platform/drivers/fpga_ip/CoreGPIO/core_gpio.o
 CC      build/platform/drivers/fpga_ip/CoreTimer/core_timer.o
 CC      build/platform/drivers/fpga_ip/CoreSPI/core_spi.o
 CC      build/platform/drivers/fpga_ip/CoreUARTapb/core_uart_apb.o
 AS      build/platform/hal/CortexM3/GNU/hal.o
 AS      build/platform/hal/CortexM3/GNU/hw_reg_access.o
 AS      build/platform/CMSIS/startup_gcc/startup_m2sxxx.o
 LD      build/cm3-systick-blinky.elf
 BIN     build/cm3-systick-blinky.bin
 HEX     build/cm3-systick-blinky.hex
 SYM     build/cm3-systick-blinky.sym
 LST     build/cm3-systick-blinky.lst
   text    data     bss     dec     hex filename
   3344    1152   64384   68880   10d10 build/cm3-systick-blinky.elf
PS C:\wip\m2s>


Debug with opencod and gdb
----------------------------------------------------------------

once the binary files are generated we can launch the openocd .
launch a new terminal window and launch openocd using command ( terminal needs to be in the same diectory)

#make openocd 

for openccd to work properly, teh variable M2S_DEVICE is needed. this can be specified in the command line or best kept in the board/Makefile for respective board.

eg. M2S_DEVICE = M2S025  // for creative board, M2S090 for security board etc.


PS C:\wip\m2s> make openocd
BOARD  = m2s-creative-brd
TARGET = cm3-systick-blinky
xPack OpenOCD (Microchip SoftConsole build), x86_64 Open On-Chip Debugger 0.10.0+dev-00859-g95a8cd9b5-dirty (2022-03-15-14:08)
Licensed under GNU GPL v2
For bug reports, read
        http://openocd.org/doc/doxygen/bugs.html
M2S025
Info : only one transport option; autoselect 'jtag'
do_board_reset_init
Info : No Embedded FlashPro6 (revision B) devices found
fpServer v17 waiting for incoming connections on the port 3334 with API v5
Info : 1 1729668978857 microsemi_flashpro_server.c:1751 microsemi_flashpro_initialize() FlashPro ports available: E200108CTE
Info : 2 1729668978857 microsemi_flashpro_server.c:1752 microsemi_flashpro_initialize() FlashPro port selected:   E200108CTE
Info : clock speed 1000 kHz
Info : JTAG tap: M2S025.tap tap/device found: 0x2f8041cf (mfg: 0x0e7 (GateField), part: 0xf804, ver: 0x2)
Info : JTAG tap: M2S025.tap disabled
Info : JTAG tap: M2S025.cpu enabled
Info : Cortex-M3 IDCODE = 0x4ba00477
Info : M2S025.cpu: hardware has 6 breakpoints, 4 watchpoints
Info : Listening on port 3333 for gdb connections
target halted due to debug-request, current mode: Thread
xPSR: 0x01000000 pc: 0x00000190 msp: 0x20010000
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections


keep this winow aside for the openocd to function.

Launch the gdb fro mthe original terminal or with a new terminal

# make debug

This will launch gdb debugger with necessary commands

we will be using the below options in the gdb 
"set mem inaccessible-by-default off" 
"set remotetimeout 100"
"target remote localhost:3333" 
"monitor reset"
"monitor halt"
"load"
"break main"
"continue"


PS C:\wip\m2s> make debug
BOARD  = m2s-creative-brd
TARGET = cm3-systick-blinky
GNU gdb (xPack GNU Arm Embedded GCC, 64-bit) 8.3.0.20190709-git
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-w64-mingw32 --target=arm-none-eabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from build/cm3-systick-blinky.elf...
Remote debugging using localhost:3333
_start () at platform/CMSIS/startup_gcc/startup_m2sxxx.S:150
150         mov r11, #0
target halted due to debug-request, current mode: Thread
xPSR: 0x01000000 pc: 0x00000896 msp: 0x2000fff0
Loading section .vector_table, size 0x190 lma 0x60000000
Loading section .boot_code, size 0x610 lma 0x60000190
Loading section .text, size 0x570 lma 0x600007a0
Loading section .data, size 0x480 lma 0x60000d10
Start address 0x190, load size 4496
Transfer rate: 3 KB/sec, 1124 bytes/write.
Breakpoint 1 at 0x830: file src/cm3-systick-blinky/main.c, line 86.
Continuing.


-----------------------------------------------------------------------------

Using the project in SoftConsole.

In soft console, create a new C project

1. File->New-> Makefile project with existing code
2. Browse to the root of the project folder and Add.
3. Right click on the project settings
4. Select Make sure that the Toolchain of arm-gcc is listed and selected. Save the project
5. compile the project ( Ctrl+B)
6. Add a new debug configuration for cortex-m3 
7. Launch the debug configuration and run as usual.



Notes:

newlib_stub.c  in CMSIS folder is  modified to incorporate teh CORE_UART_APB also.
using the  USER_FLAG += MSCC_STDIO_THRU_CORE_UART_APB


October 23 , 2024