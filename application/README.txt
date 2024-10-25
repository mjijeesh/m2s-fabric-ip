================================================================================
                    SmartFusion2  FlashLoader
================================================================================


This design is targted to the M2S-090 -Security Eval Board .
M3 Clock = 50Mhz and DDR-CLK=150 Mhz.
The Baudrate used is 115200 ( other baudrate also will work)

g_mss_uart_1 is used ( last in the listing of COM port is used)

Options:

  * option 1 will download the .bin file to the DDR.
  
  * option 2 will copy the Downloaded im age to SPi Flash
  
  * option 3 will copy the existing image from SPI flash to DDR memory
  
  * option 4 will start execution of the user program copid/downloded into the DDR memory.
  
   
  * option 8 will downlaod the File via UART directly to the SPI flash memory ( without using the DDR). So the program can be used
    in the boards without DDR. The YMODEM function will get the 1K packet from the terterm an will be directly send to the SPIFlash-Write()
    function. Here the erasing of the SPI flash sector will be need to base. The erase will be called only when the address to be written crossess
     the 4K page boundary. So only required pages will be erased rather than erasing the entire allocated pages.
 
  * If the Board has DDR then use Option 1 to download the File to DDR memory . followed by option 2 to copy the Downlaoded file to the SPI flash 
    memory. Here again the same address location selection is available or flash.
  
  
  
  * for running applications from DDR use option 1 followed by option 4.
  
  * for existing application saved i nSPI flash, use option 3 followed by option 4 to run.
  
  
  What is new :
  
       * changed the remap and jump to the new user code into a assembly code. these are available i nthe "boot" folder
       * fixed some uart names. Noe if  needed to change the usrt, change only in once place ( defenition ara)
       * to use this code with another evaluation board., change the settings in ymodem/sf2_bl_user_opts.h, enable the define of board you are using and disable the unused
       
         
       * added the  ( #define BLOCK_ALIGN_MASK_4K      0xFFFFF000) so that the IMAGE start address in SPI flash will be alwasy 
         alighned to 4K boundary. this is a requirment for the first sector in the code (spi_write)
         
       *  fixed the g_error reporting from ymodem_recieve for getting flash-write errors.
          now the errors will be transmitted to the top level. 
       *  program execution will not happen if a previous g_error is reported while downlaoding  

                                          
  Last Updated 14th December
    