----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:30:47 2024
-- Version: v11.9 SP6 11.9.6.7
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
library CORESPI_LIB;
use CORESPI_LIB.all;
----------------------------------------------------------------------
-- CORESPI_C0 entity declaration
----------------------------------------------------------------------
entity CORESPI_C0 is
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
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
end CORESPI_C0;
----------------------------------------------------------------------
-- CORESPI_C0 architecture body
----------------------------------------------------------------------
architecture RTL of CORESPI_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CORESPI   -   Actel:DirectCore:CORESPI:5.2.104
component CORESPI
    generic( 
        APB_DWIDTH        : integer := 32 ;
        CFG_CLK           : integer := 7 ;
        CFG_FIFO_DEPTH    : integer := 32 ;
        CFG_FRAME_SIZE    : integer := 8 ;
        CFG_MODE          : integer := 0 ;
        CFG_MOT_MODE      : integer := 3 ;
        CFG_MOT_SSEL      : integer := 1 ;
        CFG_NSC_OPERATION : integer := 0 ;
        CFG_TI_JMB_FRAMES : integer := 0 ;
        CFG_TI_NSC_CUSTOM : integer := 0 ;
        CFG_TI_NSC_FRC    : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        PADDR      : in  std_logic_vector(6 downto 0);
        PCLK       : in  std_logic;
        PENABLE    : in  std_logic;
        PRESETN    : in  std_logic;
        PSEL       : in  std_logic;
        PWDATA     : in  std_logic_vector(31 downto 0);
        PWRITE     : in  std_logic;
        SPICLKI    : in  std_logic;
        SPISDI     : in  std_logic;
        SPISSI     : in  std_logic;
        -- Outputs
        PRDATA     : out std_logic_vector(31 downto 0);
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
signal APB_bif_PRDATA        : std_logic_vector(31 downto 0);
signal APB_bif_PREADY        : std_logic;
signal APB_bif_PSLVERR       : std_logic;
signal SPIINT_net_0          : std_logic;
signal SPIMODE_net_0         : std_logic;
signal SPIOEN_net_0          : std_logic;
signal SPIRXAVAIL_net_0      : std_logic;
signal SPISCLKO_net_0        : std_logic;
signal SPISDO_net_0          : std_logic;
signal SPISS_net_0           : std_logic_vector(7 downto 0);
signal SPITXRFM_net_0        : std_logic;
signal SPIINT_net_1          : std_logic;
signal SPIRXAVAIL_net_1      : std_logic;
signal SPITXRFM_net_1        : std_logic;
signal SPISCLKO_net_1        : std_logic;
signal SPIOEN_net_1          : std_logic;
signal SPISDO_net_1          : std_logic;
signal SPIMODE_net_1         : std_logic;
signal APB_bif_PREADY_net_0  : std_logic;
signal APB_bif_PSLVERR_net_0 : std_logic;
signal SPISS_net_1           : std_logic_vector(7 downto 0);
signal APB_bif_PRDATA_net_0  : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPIINT_net_1          <= SPIINT_net_0;
 SPIINT                <= SPIINT_net_1;
 SPIRXAVAIL_net_1      <= SPIRXAVAIL_net_0;
 SPIRXAVAIL            <= SPIRXAVAIL_net_1;
 SPITXRFM_net_1        <= SPITXRFM_net_0;
 SPITXRFM              <= SPITXRFM_net_1;
 SPISCLKO_net_1        <= SPISCLKO_net_0;
 SPISCLKO              <= SPISCLKO_net_1;
 SPIOEN_net_1          <= SPIOEN_net_0;
 SPIOEN                <= SPIOEN_net_1;
 SPISDO_net_1          <= SPISDO_net_0;
 SPISDO                <= SPISDO_net_1;
 SPIMODE_net_1         <= SPIMODE_net_0;
 SPIMODE               <= SPIMODE_net_1;
 APB_bif_PREADY_net_0  <= APB_bif_PREADY;
 PREADY                <= APB_bif_PREADY_net_0;
 APB_bif_PSLVERR_net_0 <= APB_bif_PSLVERR;
 PSLVERR               <= APB_bif_PSLVERR_net_0;
 SPISS_net_1           <= SPISS_net_0;
 SPISS(7 downto 0)     <= SPISS_net_1;
 APB_bif_PRDATA_net_0  <= APB_bif_PRDATA;
 PRDATA(31 downto 0)   <= APB_bif_PRDATA_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CORESPI_C0_0   -   Actel:DirectCore:CORESPI:5.2.104
CORESPI_C0_0 : CORESPI
    generic map( 
        APB_DWIDTH        => ( 32 ),
        CFG_CLK           => ( 7 ),
        CFG_FIFO_DEPTH    => ( 32 ),
        CFG_FRAME_SIZE    => ( 8 ),
        CFG_MODE          => ( 0 ),
        CFG_MOT_MODE      => ( 3 ),
        CFG_MOT_SSEL      => ( 1 ),
        CFG_NSC_OPERATION => ( 0 ),
        CFG_TI_JMB_FRAMES => ( 0 ),
        CFG_TI_NSC_CUSTOM => ( 0 ),
        CFG_TI_NSC_FRC    => ( 0 )
        )
    port map( 
        -- Inputs
        PCLK       => PCLK,
        PRESETN    => PRESETN,
        PSEL       => PSEL,
        PENABLE    => PENABLE,
        PWRITE     => PWRITE,
        SPISSI     => SPISSI,
        SPISDI     => SPISDI,
        SPICLKI    => SPICLKI,
        PADDR      => PADDR,
        PWDATA     => PWDATA,
        -- Outputs
        PREADY     => APB_bif_PREADY,
        PSLVERR    => APB_bif_PSLVERR,
        SPIINT     => SPIINT_net_0,
        SPIRXAVAIL => SPIRXAVAIL_net_0,
        SPITXRFM   => SPITXRFM_net_0,
        SPISCLKO   => SPISCLKO_net_0,
        SPIOEN     => SPIOEN_net_0,
        SPISDO     => SPISDO_net_0,
        SPIMODE    => SPIMODE_net_0,
        PRDATA     => APB_bif_PRDATA,
        SPISS      => SPISS_net_0 
        );

end RTL;
