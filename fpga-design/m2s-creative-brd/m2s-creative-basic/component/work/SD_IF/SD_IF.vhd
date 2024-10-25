----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:31:01 2024
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
-- SD_IF entity declaration
----------------------------------------------------------------------
entity SD_IF is
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
end SD_IF;
----------------------------------------------------------------------
-- SD_IF architecture body
----------------------------------------------------------------------
architecture RTL of SD_IF is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CORESPI_C1
component CORESPI_C1
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(7 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(7 downto 0);
        PREADY     : out std_logic;
        PSLVERR    : out std_logic;
        SPIINT     : out std_logic;
        SPIMODE    : out std_logic;
        SPIOEN     : out std_logic;
        SPIRXAVAIL : out std_logic;
        SPISCLKO   : out std_logic;
        SPISDO     : out std_logic;
        SPISS      : out std_logic_vector(7 downto 0);
        SPITXRFM   : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB_bif_PRDATA_net_0  : std_logic_vector(7 downto 0);
signal APB_bif_PREADY_net_0  : std_logic;
signal APB_bif_PSLVERR_net_0 : std_logic;
signal SD_SCLK_net_0         : std_logic;
signal SD_SDO_net_0          : std_logic;
signal SD_SS_net_0           : std_logic_vector(0 to 0);
signal SD_SCLK_net_1         : std_logic;
signal SD_SDO_net_1          : std_logic;
signal APB_bif_PREADY_net_1  : std_logic;
signal APB_bif_PSLVERR_net_1 : std_logic;
signal SD_SS_net_1           : std_logic;
signal APB_bif_PRDATA_net_1  : std_logic_vector(7 downto 0);
signal SPISS_slice_0         : std_logic_vector(7 downto 1);
signal SPISS_net_0           : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net               : std_logic;
signal GND_net               : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
 GND_net <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SD_SCLK_net_1              <= SD_SCLK_net_0;
 SD_SCLK                    <= SD_SCLK_net_1;
 SD_SDO_net_1               <= SD_SDO_net_0;
 SD_SDO                     <= SD_SDO_net_1;
 APB_bif_PREADY_net_1       <= APB_bif_PREADY_net_0;
 APB_bif_PREADY             <= APB_bif_PREADY_net_1;
 APB_bif_PSLVERR_net_1      <= APB_bif_PSLVERR_net_0;
 APB_bif_PSLVERR            <= APB_bif_PSLVERR_net_1;
 SD_SS_net_1                <= SD_SS_net_0(0);
 SD_SS                      <= SD_SS_net_1;
 APB_bif_PRDATA_net_1       <= APB_bif_PRDATA_net_0;
 APB_bif_PRDATA(7 downto 0) <= APB_bif_PRDATA_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 SD_SS_net_0(0) <= SPISS_net_0(0);
 SPISS_slice_0  <= SPISS_net_0(7 downto 1);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CORESPI_C1_0
CORESPI_C1_0 : CORESPI_C1
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        SPISSI     => VCC_net,
        SPISDI     => SD_SDI,
        SPICLKI    => GND_net,
        PSEL       => APB_bif_PSEL,
        PENABLE    => APB_bif_PENABLE,
        PWRITE     => APB_bif_PWRITE,
        PADDR      => APB_bif_PADDR,
        PWDATA     => APB_bif_PWDATA,
        -- Outputs
        SPIINT     => OPEN,
        SPIRXAVAIL => OPEN,
        SPITXRFM   => OPEN,
        SPISCLKO   => SD_SCLK_net_0,
        SPIOEN     => OPEN,
        SPISDO     => SD_SDO_net_0,
        SPIMODE    => OPEN,
        PREADY     => APB_bif_PREADY_net_0,
        PSLVERR    => APB_bif_PSLVERR_net_0,
        SPISS      => SPISS_net_0,
        PRDATA     => APB_bif_PRDATA_net_0 
        );

end RTL;
