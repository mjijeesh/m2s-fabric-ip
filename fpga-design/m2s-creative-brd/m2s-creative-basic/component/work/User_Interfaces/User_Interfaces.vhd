----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:51:31 2024
-- Version: v11.9 SP6 11.9.6.7
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- User_Interfaces entity declaration
----------------------------------------------------------------------
entity User_Interfaces is
    -- Port list
    port(
        -- Inputs
        APB3mmaster_PADDR   : in  std_logic_vector(31 downto 0);
        APB3mmaster_PENABLE : in  std_logic;
        APB3mmaster_PSEL    : in  std_logic;
        APB3mmaster_PWDATA  : in  std_logic_vector(31 downto 0);
        APB3mmaster_PWRITE  : in  std_logic;
        GPIO_0_IN           : in  std_logic;
        GPIO_1_IN           : in  std_logic;
        PCLK                : in  std_logic;
        PRESETN             : in  std_logic;
        RX                  : in  std_logic;
        SD_SDI              : in  std_logic;
        SPI_FLASH_SDI       : in  std_logic;
        -- Outputs
        APB3mmaster_PRDATA  : out std_logic_vector(31 downto 0);
        APB3mmaster_PREADY  : out std_logic;
        APB3mmaster_PSLVERR : out std_logic;
        GPIO_OUT            : out std_logic_vector(7 downto 0);
        SD_SCLK             : out std_logic;
        SD_SDO              : out std_logic;
        SD_SS               : out std_logic;
        SPI_FLASH_SCLK      : out std_logic;
        SPI_FLASH_SDO       : out std_logic;
        SPI_FLASH_SS        : out std_logic;
        TIMINT              : out std_logic;
        TX                  : out std_logic
        );
end User_Interfaces;
----------------------------------------------------------------------
-- User_Interfaces architecture body
----------------------------------------------------------------------
architecture RTL of User_Interfaces is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CoreAPB3_C0
component CoreAPB3_C0
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(31 downto 0);
        PENABLE    : in  std_logic;
        PRDATAS1   : in  std_logic_vector(31 downto 0);
        PRDATAS2   : in  std_logic_vector(31 downto 0);
        PRDATAS3   : in  std_logic_vector(31 downto 0);
        PRDATAS4   : in  std_logic_vector(31 downto 0);
        PRDATAS5   : in  std_logic_vector(31 downto 0);
        PRDATAS6   : in  std_logic_vector(31 downto 0);
        PREADYS1   : in  std_logic;
        PREADYS2   : in  std_logic;
        PREADYS3   : in  std_logic;
        PREADYS4   : in  std_logic;
        PREADYS5   : in  std_logic;
        PREADYS6   : in  std_logic;
        PSEL       : in  std_logic;
        PSLVERRS1  : in  std_logic;
        PSLVERRS2  : in  std_logic;
        PSLVERRS3  : in  std_logic;
        PSLVERRS4  : in  std_logic;
        PSLVERRS5  : in  std_logic;
        PSLVERRS6  : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        -- Outputs
        PADDRS     : out std_logic_vector(31 downto 0);
        PADDRS_0   : out std_logic_vector(31 downto 0);
        PADDRS_1   : out std_logic_vector(31 downto 0);
        PADDRS_2   : out std_logic_vector(31 downto 0);
        PADDRS_3   : out std_logic_vector(31 downto 0);
        PADDRS_4   : out std_logic_vector(31 downto 0);
        PENABLES   : out std_logic;
        PENABLES_0 : out std_logic;
        PENABLES_1 : out std_logic;
        PENABLES_2 : out std_logic;
        PENABLES_3 : out std_logic;
        PENABLES_4 : out std_logic;
        PRDATA     : out std_logic_vector(31 downto 0);
        PREADY     : out std_logic;
        PSELS1     : out std_logic;
        PSELS2     : out std_logic;
        PSELS3     : out std_logic;
        PSELS4     : out std_logic;
        PSELS5     : out std_logic;
        PSELS6     : out std_logic;
        PSLVERR    : out std_logic;
        PWDATAS    : out std_logic_vector(31 downto 0);
        PWDATAS_0  : out std_logic_vector(31 downto 0);
        PWDATAS_1  : out std_logic_vector(31 downto 0);
        PWDATAS_2  : out std_logic_vector(31 downto 0);
        PWDATAS_3  : out std_logic_vector(31 downto 0);
        PWDATAS_4  : out std_logic_vector(31 downto 0);
        PWRITES    : out std_logic;
        PWRITES_0  : out std_logic;
        PWRITES_1  : out std_logic;
        PWRITES_2  : out std_logic;
        PWRITES_3  : out std_logic;
        PWRITES_4  : out std_logic
        );
end component;
-- CoreGPIO_C0
component CoreGPIO_C0
    -- Port list
    port(
        -- Inputs
        GPIO_IN  : in  std_logic_vector(7 downto 0);
        PADDR    : in  std_logic_vector(7 downto 0);
        PCLK     : in  std_logic;
        PENABLE  : in  std_logic;
        PRESETN  : in  std_logic;
        PSEL     : in  std_logic;
        PWDATA   : in  std_logic_vector(31 downto 0);
        PWRITE   : in  std_logic;
        -- Outputs
        GPIO_OUT : out std_logic_vector(7 downto 0);
        INT      : out std_logic_vector(7 downto 0);
        PRDATA   : out std_logic_vector(31 downto 0);
        PREADY   : out std_logic;
        PSLVERR  : out std_logic
        );
end component;
-- COREGPIO_C1
component COREGPIO_C1
    -- Port list
    port(
        -- Inputs
        GPIO_IN  : in  std_logic_vector(7 downto 0);
        PADDR    : in  std_logic_vector(7 downto 0);
        PCLK     : in  std_logic;
        PENABLE  : in  std_logic;
        PRESETN  : in  std_logic;
        PSEL     : in  std_logic;
        PWDATA   : in  std_logic_vector(31 downto 0);
        PWRITE   : in  std_logic;
        -- Outputs
        GPIO_OUT : out std_logic_vector(7 downto 0);
        INT      : out std_logic_vector(7 downto 0);
        PRDATA   : out std_logic_vector(31 downto 0);
        PREADY   : out std_logic;
        PSLVERR  : out std_logic
        );
end component;
-- CoreTimer_C0
component CoreTimer_C0
    -- Port list
    port(
        -- Inputs
        PADDR   : in  std_logic_vector(4 downto 2);
        PCLK    : in  std_logic;
        PENABLE : in  std_logic;
        PRESETn : in  std_logic;
        PSEL    : in  std_logic;
        PWDATA  : in  std_logic_vector(31 downto 0);
        PWRITE  : in  std_logic;
        -- Outputs
        PRDATA  : out std_logic_vector(31 downto 0);
        TIMINT  : out std_logic
        );
end component;
-- CoreUARTapb_C0
component CoreUARTapb_C0
    -- Port list
    port(
        -- Inputs
        PADDR       : in  std_logic_vector(4 downto 0);
        PCLK        : in  std_logic;
        PENABLE     : in  std_logic;
        PRESETN     : in  std_logic;
        PSEL        : in  std_logic;
        PWDATA      : in  std_logic_vector(7 downto 0);
        PWRITE      : in  std_logic;
        RX          : in  std_logic;
        -- Outputs
        FRAMING_ERR : out std_logic;
        OVERFLOW    : out std_logic;
        PARITY_ERR  : out std_logic;
        PRDATA      : out std_logic_vector(7 downto 0);
        PREADY      : out std_logic;
        PSLVERR     : out std_logic;
        RXRDY       : out std_logic;
        TX          : out std_logic;
        TXRDY       : out std_logic
        );
end component;
-- SD_IF
component SD_IF
    -- Port list
    port(
        -- Inputs
        APB_bif_PADDR   : in  std_logic_vector(6 downto 0);
        APB_bif_PENABLE : in  std_logic;
        APB_bif_PSEL    : in  std_logic;
        APB_bif_PWDATA  : in  std_logic_vector(7 downto 0);
        APB_bif_PWRITE  : in  std_logic;
        PCLK            : in  std_logic;
        PRESETN         : in  std_logic;
        SD_SDI          : in  std_logic;
        -- Outputs
        APB_bif_PRDATA  : out std_logic_vector(7 downto 0);
        APB_bif_PREADY  : out std_logic;
        APB_bif_PSLVERR : out std_logic;
        SD_SCLK         : out std_logic;
        SD_SDO          : out std_logic;
        SD_SS           : out std_logic
        );
end component;
-- spi_flash
component spi_flash
    -- Port list
    port(
        -- Inputs
        APB_bif_PADDR   : in  std_logic_vector(6 downto 0);
        APB_bif_PENABLE : in  std_logic;
        APB_bif_PSEL    : in  std_logic;
        APB_bif_PWDATA  : in  std_logic_vector(31 downto 0);
        APB_bif_PWRITE  : in  std_logic;
        PCLK            : in  std_logic;
        PRESETN         : in  std_logic;
        SPI_FLASH_SDI   : in  std_logic;
        -- Outputs
        APB_bif_PRDATA  : out std_logic_vector(31 downto 0);
        APB_bif_PREADY  : out std_logic;
        APB_bif_PSLVERR : out std_logic;
        SPI_FLASH_SCLK  : out std_logic;
        SPI_FLASH_SDO   : out std_logic;
        SPI_FLASH_SS    : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB3mmaster_PRDATA_net_0         : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY_net_0         : std_logic;
signal APB3mmaster_PSLVERR_net_0        : std_logic;
signal CoreAPB3_C0_0_APBmslave1_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave1_PREADY  : std_logic;
signal CoreAPB3_C0_0_APBmslave1_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave1_PSLVERR : std_logic;
signal CoreAPB3_C0_0_APBmslave1_PWRITE  : std_logic;
signal CoreAPB3_C0_0_APBmslave2_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave2_PRDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave2_PREADY  : std_logic;
signal CoreAPB3_C0_0_APBmslave2_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave2_PSLVERR : std_logic;
signal CoreAPB3_C0_0_APBmslave2_PWDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave2_PWRITE  : std_logic;
signal CoreAPB3_C0_0_APBmslave3_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave3_PRDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave3_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave3_PWDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave3_PWRITE  : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PRDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PREADY  : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PSLVERR : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PWDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PWRITE  : std_logic;
signal CoreAPB3_C0_0_APBmslave5_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave5_PREADY  : std_logic;
signal CoreAPB3_C0_0_APBmslave5_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave5_PSLVERR : std_logic;
signal CoreAPB3_C0_0_APBmslave5_PWRITE  : std_logic;
signal CoreAPB3_C0_0_APBmslave6_PENABLE : std_logic;
signal CoreAPB3_C0_0_APBmslave6_PRDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave6_PREADY  : std_logic;
signal CoreAPB3_C0_0_APBmslave6_PSELx   : std_logic;
signal CoreAPB3_C0_0_APBmslave6_PSLVERR : std_logic;
signal CoreAPB3_C0_0_APBmslave6_PWDATA  : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave6_PWRITE  : std_logic;
signal GPIO_OUT_net_0                   : std_logic_vector(7 downto 0);
signal SD_SCLK_net_0                    : std_logic;
signal SD_SDO_net_0                     : std_logic;
signal SD_SS_net_0                      : std_logic;
signal SPI_FLASH_SCLK_net_0             : std_logic;
signal SPI_FLASH_SDO_net_0              : std_logic;
signal SPI_FLASH_SS_net_0               : std_logic;
signal TIMINT_net_0                     : std_logic;
signal TX_net_0                         : std_logic;
signal TX_net_1                         : std_logic;
signal TIMINT_net_1                     : std_logic;
signal SPI_FLASH_SDO_net_1              : std_logic;
signal SPI_FLASH_SS_net_1               : std_logic;
signal SD_SS_net_1                      : std_logic;
signal SD_SCLK_net_1                    : std_logic;
signal SD_SDO_net_1                     : std_logic;
signal SPI_FLASH_SCLK_net_1             : std_logic;
signal APB3mmaster_PREADY_net_1         : std_logic;
signal APB3mmaster_PSLVERR_net_1        : std_logic;
signal GPIO_OUT_net_1                   : std_logic_vector(7 downto 0);
signal APB3mmaster_PRDATA_net_1         : std_logic_vector(31 downto 0);
signal GPIO_IN_net_0                    : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GPIO_IN_const_net_0              : std_logic_vector(7 downto 2);
signal GPIO_IN_const_net_1              : std_logic_vector(7 downto 0);
signal VCC_net                          : std_logic;
signal GND_net                          : std_logic;
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0: std_logic_vector(4 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PADDR_0 : std_logic_vector(4 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PADDR   : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave1_PRDATA  : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8: std_logic_vector(31 downto 8);
signal CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PRDATA_0: std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PWDATA_0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave1_PWDATA  : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave2_PADDR_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave2_PADDR_0 : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave2_PADDR   : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave3_PADDR_0_4to2: std_logic_vector(4 downto 2);
signal CoreAPB3_C0_0_APBmslave3_PADDR_0 : std_logic_vector(4 downto 2);
signal CoreAPB3_C0_0_APBmslave3_PADDR   : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PADDR_0 : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PADDR   : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave5_PADDR_0_6to0: std_logic_vector(6 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PADDR_0 : std_logic_vector(6 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PADDR   : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave5_PRDATA  : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8: std_logic_vector(31 downto 8);
signal CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PRDATA_0: std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave5_PWDATA_0_7to0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PWDATA_0: std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave5_PWDATA  : std_logic_vector(31 downto 0);

signal CoreAPB3_C0_0_APBmslave6_PADDR_0_6to0: std_logic_vector(6 downto 0);
signal CoreAPB3_C0_0_APBmslave6_PADDR_0 : std_logic_vector(6 downto 0);
signal CoreAPB3_C0_0_APBmslave6_PADDR   : std_logic_vector(31 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GPIO_IN_const_net_0 <= B"000000";
 GPIO_IN_const_net_1 <= B"00000000";
 VCC_net             <= '1';
 GND_net             <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 TX_net_1                        <= TX_net_0;
 TX                              <= TX_net_1;
 TIMINT_net_1                    <= TIMINT_net_0;
 TIMINT                          <= TIMINT_net_1;
 SPI_FLASH_SDO_net_1             <= SPI_FLASH_SDO_net_0;
 SPI_FLASH_SDO                   <= SPI_FLASH_SDO_net_1;
 SPI_FLASH_SS_net_1              <= SPI_FLASH_SS_net_0;
 SPI_FLASH_SS                    <= SPI_FLASH_SS_net_1;
 SD_SS_net_1                     <= SD_SS_net_0;
 SD_SS                           <= SD_SS_net_1;
 SD_SCLK_net_1                   <= SD_SCLK_net_0;
 SD_SCLK                         <= SD_SCLK_net_1;
 SD_SDO_net_1                    <= SD_SDO_net_0;
 SD_SDO                          <= SD_SDO_net_1;
 SPI_FLASH_SCLK_net_1            <= SPI_FLASH_SCLK_net_0;
 SPI_FLASH_SCLK                  <= SPI_FLASH_SCLK_net_1;
 APB3mmaster_PREADY_net_1        <= APB3mmaster_PREADY_net_0;
 APB3mmaster_PREADY              <= APB3mmaster_PREADY_net_1;
 APB3mmaster_PSLVERR_net_1       <= APB3mmaster_PSLVERR_net_0;
 APB3mmaster_PSLVERR             <= APB3mmaster_PSLVERR_net_1;
 GPIO_OUT_net_1                  <= GPIO_OUT_net_0;
 GPIO_OUT(7 downto 0)            <= GPIO_OUT_net_1;
 APB3mmaster_PRDATA_net_1        <= APB3mmaster_PRDATA_net_0;
 APB3mmaster_PRDATA(31 downto 0) <= APB3mmaster_PRDATA_net_1;
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 GPIO_IN_net_0 <= ( B"000000" & GPIO_1_IN & GPIO_0_IN );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0(4 downto 0) <= CoreAPB3_C0_0_APBmslave1_PADDR(4 downto 0);
 CoreAPB3_C0_0_APBmslave1_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0(4 downto 0) );

 CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8(31 downto 8) <= B"000000000000000000000000";
 CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave1_PRDATA(7 downto 0);
 CoreAPB3_C0_0_APBmslave1_PRDATA_0 <= ( CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8(31 downto 8) & CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave1_PWDATA(7 downto 0);
 CoreAPB3_C0_0_APBmslave1_PWDATA_0 <= ( CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave2_PADDR_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave2_PADDR(7 downto 0);
 CoreAPB3_C0_0_APBmslave2_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave2_PADDR_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave3_PADDR_0_4to2(4 downto 2) <= CoreAPB3_C0_0_APBmslave3_PADDR(4 downto 2);
 CoreAPB3_C0_0_APBmslave3_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave3_PADDR_0_4to2(4 downto 2) );

 CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave4_PADDR(7 downto 0);
 CoreAPB3_C0_0_APBmslave4_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave5_PADDR_0_6to0(6 downto 0) <= CoreAPB3_C0_0_APBmslave5_PADDR(6 downto 0);
 CoreAPB3_C0_0_APBmslave5_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave5_PADDR_0_6to0(6 downto 0) );

 CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8(31 downto 8) <= B"000000000000000000000000";
 CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave5_PRDATA(7 downto 0);
 CoreAPB3_C0_0_APBmslave5_PRDATA_0 <= ( CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8(31 downto 8) & CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave5_PWDATA_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave5_PWDATA(7 downto 0);
 CoreAPB3_C0_0_APBmslave5_PWDATA_0 <= ( CoreAPB3_C0_0_APBmslave5_PWDATA_0_7to0(7 downto 0) );

 CoreAPB3_C0_0_APBmslave6_PADDR_0_6to0(6 downto 0) <= CoreAPB3_C0_0_APBmslave6_PADDR(6 downto 0);
 CoreAPB3_C0_0_APBmslave6_PADDR_0 <= ( CoreAPB3_C0_0_APBmslave6_PADDR_0_6to0(6 downto 0) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CoreAPB3_C0_0
CoreAPB3_C0_0 : CoreAPB3_C0
    port map( 
        -- Inputs
        PSEL       => APB3mmaster_PSEL,
        PENABLE    => APB3mmaster_PENABLE,
        PWRITE     => APB3mmaster_PWRITE,
        PREADYS1   => CoreAPB3_C0_0_APBmslave1_PREADY,
        PSLVERRS1  => CoreAPB3_C0_0_APBmslave1_PSLVERR,
        PREADYS2   => CoreAPB3_C0_0_APBmslave2_PREADY,
        PSLVERRS2  => CoreAPB3_C0_0_APBmslave2_PSLVERR,
        PREADYS3   => VCC_net, -- tied to '1' from definition
        PSLVERRS3  => GND_net, -- tied to '0' from definition
        PREADYS5   => CoreAPB3_C0_0_APBmslave5_PREADY,
        PSLVERRS5  => CoreAPB3_C0_0_APBmslave5_PSLVERR,
        PREADYS6   => CoreAPB3_C0_0_APBmslave6_PREADY,
        PSLVERRS6  => CoreAPB3_C0_0_APBmslave6_PSLVERR,
        PREADYS4   => CoreAPB3_C0_0_APBmslave4_PREADY,
        PSLVERRS4  => CoreAPB3_C0_0_APBmslave4_PSLVERR,
        PADDR      => APB3mmaster_PADDR,
        PWDATA     => APB3mmaster_PWDATA,
        PRDATAS1   => CoreAPB3_C0_0_APBmslave1_PRDATA_0,
        PRDATAS2   => CoreAPB3_C0_0_APBmslave2_PRDATA,
        PRDATAS3   => CoreAPB3_C0_0_APBmslave3_PRDATA,
        PRDATAS5   => CoreAPB3_C0_0_APBmslave5_PRDATA_0,
        PRDATAS6   => CoreAPB3_C0_0_APBmslave6_PRDATA,
        PRDATAS4   => CoreAPB3_C0_0_APBmslave4_PRDATA,
        -- Outputs
        PREADY     => APB3mmaster_PREADY_net_0,
        PSLVERR    => APB3mmaster_PSLVERR_net_0,
        PSELS1     => CoreAPB3_C0_0_APBmslave1_PSELx,
        PENABLES_0 => CoreAPB3_C0_0_APBmslave1_PENABLE,
        PWRITES_0  => CoreAPB3_C0_0_APBmslave1_PWRITE,
        PSELS2     => CoreAPB3_C0_0_APBmslave2_PSELx,
        PENABLES_1 => CoreAPB3_C0_0_APBmslave2_PENABLE,
        PWRITES_1  => CoreAPB3_C0_0_APBmslave2_PWRITE,
        PSELS3     => CoreAPB3_C0_0_APBmslave3_PSELx,
        PENABLES_2 => CoreAPB3_C0_0_APBmslave3_PENABLE,
        PWRITES_2  => CoreAPB3_C0_0_APBmslave3_PWRITE,
        PSELS5     => CoreAPB3_C0_0_APBmslave5_PSELx,
        PENABLES_3 => CoreAPB3_C0_0_APBmslave5_PENABLE,
        PWRITES_3  => CoreAPB3_C0_0_APBmslave5_PWRITE,
        PSELS6     => CoreAPB3_C0_0_APBmslave6_PSELx,
        PENABLES   => CoreAPB3_C0_0_APBmslave6_PENABLE,
        PWRITES    => CoreAPB3_C0_0_APBmslave6_PWRITE,
        PSELS4     => CoreAPB3_C0_0_APBmslave4_PSELx,
        PENABLES_4 => CoreAPB3_C0_0_APBmslave4_PENABLE,
        PWRITES_4  => CoreAPB3_C0_0_APBmslave4_PWRITE,
        PRDATA     => APB3mmaster_PRDATA_net_0,
        PADDRS_0   => CoreAPB3_C0_0_APBmslave1_PADDR,
        PWDATAS_0  => CoreAPB3_C0_0_APBmslave1_PWDATA,
        PADDRS_1   => CoreAPB3_C0_0_APBmslave2_PADDR,
        PWDATAS_1  => CoreAPB3_C0_0_APBmslave2_PWDATA,
        PADDRS_2   => CoreAPB3_C0_0_APBmslave3_PADDR,
        PWDATAS_2  => CoreAPB3_C0_0_APBmslave3_PWDATA,
        PADDRS_3   => CoreAPB3_C0_0_APBmslave5_PADDR,
        PWDATAS_3  => CoreAPB3_C0_0_APBmslave5_PWDATA,
        PADDRS     => CoreAPB3_C0_0_APBmslave6_PADDR,
        PWDATAS    => CoreAPB3_C0_0_APBmslave6_PWDATA,
        PADDRS_4   => CoreAPB3_C0_0_APBmslave4_PADDR,
        PWDATAS_4  => CoreAPB3_C0_0_APBmslave4_PWDATA 
        );
-- CoreGPIO_C0_0
CoreGPIO_C0_0 : CoreGPIO_C0
    port map( 
        -- Inputs
        PRESETN  => PRESETN,
        PCLK     => PCLK,
        PSEL     => CoreAPB3_C0_0_APBmslave2_PSELx,
        PENABLE  => CoreAPB3_C0_0_APBmslave2_PENABLE,
        PWRITE   => CoreAPB3_C0_0_APBmslave2_PWRITE,
        PADDR    => CoreAPB3_C0_0_APBmslave2_PADDR_0,
        PWDATA   => CoreAPB3_C0_0_APBmslave2_PWDATA,
        GPIO_IN  => GPIO_IN_net_0,
        -- Outputs
        PREADY   => CoreAPB3_C0_0_APBmslave2_PREADY,
        PSLVERR  => CoreAPB3_C0_0_APBmslave2_PSLVERR,
        PRDATA   => CoreAPB3_C0_0_APBmslave2_PRDATA,
        INT      => OPEN,
        GPIO_OUT => OPEN 
        );
-- COREGPIO_C1_0
COREGPIO_C1_0 : COREGPIO_C1
    port map( 
        -- Inputs
        PRESETN  => PRESETN,
        PCLK     => PCLK,
        PSEL     => CoreAPB3_C0_0_APBmslave4_PSELx,
        PENABLE  => CoreAPB3_C0_0_APBmslave4_PENABLE,
        PWRITE   => CoreAPB3_C0_0_APBmslave4_PWRITE,
        PADDR    => CoreAPB3_C0_0_APBmslave4_PADDR_0,
        PWDATA   => CoreAPB3_C0_0_APBmslave4_PWDATA,
        GPIO_IN  => GPIO_IN_const_net_1,
        -- Outputs
        PREADY   => CoreAPB3_C0_0_APBmslave4_PREADY,
        PSLVERR  => CoreAPB3_C0_0_APBmslave4_PSLVERR,
        PRDATA   => CoreAPB3_C0_0_APBmslave4_PRDATA,
        INT      => OPEN,
        GPIO_OUT => GPIO_OUT_net_0 
        );
-- CoreTimer_C0_0
CoreTimer_C0_0 : CoreTimer_C0
    port map( 
        -- Inputs
        PCLK    => PCLK,
        PRESETn => PRESETN,
        PSEL    => CoreAPB3_C0_0_APBmslave3_PSELx,
        PENABLE => CoreAPB3_C0_0_APBmslave3_PENABLE,
        PWRITE  => CoreAPB3_C0_0_APBmslave3_PWRITE,
        PADDR   => CoreAPB3_C0_0_APBmslave3_PADDR_0,
        PWDATA  => CoreAPB3_C0_0_APBmslave3_PWDATA,
        -- Outputs
        TIMINT  => TIMINT_net_0,
        PRDATA  => CoreAPB3_C0_0_APBmslave3_PRDATA 
        );
-- CoreUARTapb_C0_0
CoreUARTapb_C0_0 : CoreUARTapb_C0
    port map( 
        -- Inputs
        PCLK        => PCLK,
        PRESETN     => PRESETN,
        RX          => RX,
        PSEL        => CoreAPB3_C0_0_APBmslave1_PSELx,
        PENABLE     => CoreAPB3_C0_0_APBmslave1_PENABLE,
        PWRITE      => CoreAPB3_C0_0_APBmslave1_PWRITE,
        PADDR       => CoreAPB3_C0_0_APBmslave1_PADDR_0,
        PWDATA      => CoreAPB3_C0_0_APBmslave1_PWDATA_0,
        -- Outputs
        TXRDY       => OPEN,
        RXRDY       => OPEN,
        PARITY_ERR  => OPEN,
        OVERFLOW    => OPEN,
        TX          => TX_net_0,
        FRAMING_ERR => OPEN,
        PREADY      => CoreAPB3_C0_0_APBmslave1_PREADY,
        PSLVERR     => CoreAPB3_C0_0_APBmslave1_PSLVERR,
        PRDATA      => CoreAPB3_C0_0_APBmslave1_PRDATA 
        );
-- SD_IF_0
SD_IF_0 : SD_IF
    port map( 
        -- Inputs
        PCLK            => PCLK,
        PRESETN         => PRESETN,
        SD_SDI          => SD_SDI,
        APB_bif_PSEL    => CoreAPB3_C0_0_APBmslave5_PSELx,
        APB_bif_PENABLE => CoreAPB3_C0_0_APBmslave5_PENABLE,
        APB_bif_PWRITE  => CoreAPB3_C0_0_APBmslave5_PWRITE,
        APB_bif_PADDR   => CoreAPB3_C0_0_APBmslave5_PADDR_0,
        APB_bif_PWDATA  => CoreAPB3_C0_0_APBmslave5_PWDATA_0,
        -- Outputs
        SD_SCLK         => SD_SCLK_net_0,
        SD_SDO          => SD_SDO_net_0,
        APB_bif_PREADY  => CoreAPB3_C0_0_APBmslave5_PREADY,
        APB_bif_PSLVERR => CoreAPB3_C0_0_APBmslave5_PSLVERR,
        SD_SS           => SD_SS_net_0,
        APB_bif_PRDATA  => CoreAPB3_C0_0_APBmslave5_PRDATA 
        );
-- spi_flash_0
spi_flash_0 : spi_flash
    port map( 
        -- Inputs
        PCLK            => PCLK,
        PRESETN         => PRESETN,
        SPI_FLASH_SDI   => SPI_FLASH_SDI,
        APB_bif_PSEL    => CoreAPB3_C0_0_APBmslave6_PSELx,
        APB_bif_PENABLE => CoreAPB3_C0_0_APBmslave6_PENABLE,
        APB_bif_PWRITE  => CoreAPB3_C0_0_APBmslave6_PWRITE,
        APB_bif_PADDR   => CoreAPB3_C0_0_APBmslave6_PADDR_0,
        APB_bif_PWDATA  => CoreAPB3_C0_0_APBmslave6_PWDATA,
        -- Outputs
        SPI_FLASH_SDO   => SPI_FLASH_SDO_net_0,
        SPI_FLASH_SCLK  => SPI_FLASH_SCLK_net_0,
        SPI_FLASH_SS    => SPI_FLASH_SS_net_0,
        APB_bif_PREADY  => CoreAPB3_C0_0_APBmslave6_PREADY,
        APB_bif_PSLVERR => CoreAPB3_C0_0_APBmslave6_PSLVERR,
        APB_bif_PRDATA  => CoreAPB3_C0_0_APBmslave6_PRDATA 
        );

end RTL;
