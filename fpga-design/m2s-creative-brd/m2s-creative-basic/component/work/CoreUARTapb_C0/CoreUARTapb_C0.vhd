----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:28:04 2024
-- Version: v11.9 SP6 11.9.6.7
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
library COREUARTAPB_LIB;
use COREUARTAPB_LIB.all;
use COREUARTAPB_LIB.CoreUARTapb_C0_CoreUARTapb_C0_0_components.all;
----------------------------------------------------------------------
-- CoreUARTapb_C0 entity declaration
----------------------------------------------------------------------
entity CoreUARTapb_C0 is
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
end CoreUARTapb_C0;
----------------------------------------------------------------------
-- CoreUARTapb_C0 architecture body
----------------------------------------------------------------------
architecture RTL of CoreUARTapb_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CoreUARTapb_C0_CoreUARTapb_C0_0_CoreUARTapb   -   Actel:DirectCore:CoreUARTapb:5.7.100
component CoreUARTapb_C0_CoreUARTapb_C0_0_CoreUARTapb
    generic( 
        BAUD_VAL_FRCTN    : integer := 0 ;
        BAUD_VAL_FRCTN_EN : integer := 0 ;
        BAUD_VALUE        : integer := 1 ;
        FAMILY            : integer := 19 ;
        FIXEDMODE         : integer := 0 ;
        PRG_BIT8          : integer := 0 ;
        PRG_PARITY        : integer := 0 ;
        RX_FIFO           : integer := 0 ;
        RX_LEGACY_MODE    : integer := 0 ;
        TX_FIFO           : integer := 0 
        );
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB_bif_PRDATA        : std_logic_vector(7 downto 0);
signal APB_bif_PREADY        : std_logic;
signal APB_bif_PSLVERR       : std_logic;
signal FRAMING_ERR_net_0     : std_logic;
signal OVERFLOW_net_0        : std_logic;
signal PARITY_ERR_net_0      : std_logic;
signal RXRDY_net_0           : std_logic;
signal TX_net_0              : std_logic;
signal TXRDY_net_0           : std_logic;
signal TXRDY_net_1           : std_logic;
signal RXRDY_net_1           : std_logic;
signal PARITY_ERR_net_1      : std_logic;
signal OVERFLOW_net_1        : std_logic;
signal TX_net_1              : std_logic;
signal FRAMING_ERR_net_1     : std_logic;
signal APB_bif_PREADY_net_0  : std_logic;
signal APB_bif_PSLVERR_net_0 : std_logic;
signal APB_bif_PRDATA_net_0  : std_logic_vector(7 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 TXRDY_net_1           <= TXRDY_net_0;
 TXRDY                 <= TXRDY_net_1;
 RXRDY_net_1           <= RXRDY_net_0;
 RXRDY                 <= RXRDY_net_1;
 PARITY_ERR_net_1      <= PARITY_ERR_net_0;
 PARITY_ERR            <= PARITY_ERR_net_1;
 OVERFLOW_net_1        <= OVERFLOW_net_0;
 OVERFLOW              <= OVERFLOW_net_1;
 TX_net_1              <= TX_net_0;
 TX                    <= TX_net_1;
 FRAMING_ERR_net_1     <= FRAMING_ERR_net_0;
 FRAMING_ERR           <= FRAMING_ERR_net_1;
 APB_bif_PREADY_net_0  <= APB_bif_PREADY;
 PREADY                <= APB_bif_PREADY_net_0;
 APB_bif_PSLVERR_net_0 <= APB_bif_PSLVERR;
 PSLVERR               <= APB_bif_PSLVERR_net_0;
 APB_bif_PRDATA_net_0  <= APB_bif_PRDATA;
 PRDATA(7 downto 0)    <= APB_bif_PRDATA_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CoreUARTapb_C0_0   -   Actel:DirectCore:CoreUARTapb:5.7.100
CoreUARTapb_C0_0 : CoreUARTapb_C0_CoreUARTapb_C0_0_CoreUARTapb
    generic map( 
        BAUD_VAL_FRCTN    => ( 0 ),
        BAUD_VAL_FRCTN_EN => ( 0 ),
        BAUD_VALUE        => ( 1 ),
        FAMILY            => ( 19 ),
        FIXEDMODE         => ( 0 ),
        PRG_BIT8          => ( 0 ),
        PRG_PARITY        => ( 0 ),
        RX_FIFO           => ( 0 ),
        RX_LEGACY_MODE    => ( 0 ),
        TX_FIFO           => ( 0 )
        )
    port map( 
        -- Inputs
        PCLK        => PCLK,
        PRESETN     => PRESETN,
        PSEL        => PSEL,
        PENABLE     => PENABLE,
        PWRITE      => PWRITE,
        RX          => RX,
        PADDR       => PADDR,
        PWDATA      => PWDATA,
        -- Outputs
        TXRDY       => TXRDY_net_0,
        RXRDY       => RXRDY_net_0,
        PARITY_ERR  => PARITY_ERR_net_0,
        OVERFLOW    => OVERFLOW_net_0,
        TX          => TX_net_0,
        PREADY      => APB_bif_PREADY,
        PSLVERR     => APB_bif_PSLVERR,
        FRAMING_ERR => FRAMING_ERR_net_0,
        PRDATA      => APB_bif_PRDATA 
        );

end RTL;
