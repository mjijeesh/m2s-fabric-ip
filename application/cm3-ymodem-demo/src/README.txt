The uart downlaoder app

This will download a bin file into the target board's ddr memory .

on the creative board, the target address is at 0xa8000000;

baud rate is 1152000

use tera term for file transfer. 

fiel -> send file-> select the neorv32_exe.bin file

Make sure taht teh raw file check box is selected.

right now the file requires the first 4 bytes to  have signature field followed by size field and the checksum.
this fiel is created usign the neorv32 sw utilities.

the hexviewer application is used to display the downloaded file .
Note: the header part will not be stored in the target location. it will b stripped of before writing.



May 12th 2023 