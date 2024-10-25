----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:59:00 2024
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
-- m2s_sys_top entity declaration
----------------------------------------------------------------------
entity m2s_sys_top is
    -- Port list
    port(
        -- Inputs
        CLK0_PAD              : in    std_logic;
        DEVRST_N              : in    std_logic;
        GPIO_0_SW2            : in    std_logic;
        GPIO_1_SW3            : in    std_logic;
        MDDR_DQS_TMATCH_0_IN  : in    std_logic;
        SD_SDI                : in    std_logic;
        SPI_FLASH_SDI         : in    std_logic;
        UART_RXD              : in    std_logic;
        XTL                   : in    std_logic;
        -- Outputs
        GPIO_0_LED0           : out   std_logic;
        GPIO_1_LED1           : out   std_logic;
        GPIO_2_SD_CS          : out   std_logic;
        MDDR_ADDR             : out   std_logic_vector(15 downto 0);
        MDDR_BA               : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N            : out   std_logic;
        MDDR_CKE              : out   std_logic;
        MDDR_CLK              : out   std_logic;
        MDDR_CLK_N            : out   std_logic;
        MDDR_CS_N             : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT : out   std_logic;
        MDDR_ODT              : out   std_logic;
        MDDR_RAS_N            : out   std_logic;
        MDDR_RESET_N          : out   std_logic;
        MDDR_WE_N             : out   std_logic;
        SD_SCLK               : out   std_logic;
        SD_SDO                : out   std_logic;
        SPI_FLASH_SCLK        : out   std_logic;
        SPI_FLASH_SDO         : out   std_logic;
        SPI_FLASH_SS          : out   std_logic;
        UART_TXD              : out   std_logic;
        -- Inouts
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        MDDR_DQS_N            : inout std_logic_vector(1 downto 0)
        );
end m2s_sys_top;
----------------------------------------------------------------------
-- m2s_sys_top architecture body
----------------------------------------------------------------------
architecture RTL of m2s_sys_top is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- ddr_mss
component ddr_mss
    -- Port list
    port(
        -- Inputs
        CLK0_PAD                              : in    std_logic;
        DEVRST_N                              : in    std_logic;
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA  : in    std_logic_vector(31 downto 0);
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY  : in    std_logic;
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR : in    std_logic;
        MDDR_DQS_TMATCH_0_IN                  : in    std_logic;
        MSS_INT_F2M                           : in    std_logic_vector(15 downto 0);
        XTL                                   : in    std_logic;
        -- Outputs
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR   : out   std_logic_vector(31 downto 0);
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE : out   std_logic;
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL    : out   std_logic;
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA  : out   std_logic_vector(31 downto 0);
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE  : out   std_logic;
        FIC_0_CLK                             : out   std_logic;
        INIT_DONE                             : out   std_logic;
        MDDR_ADDR                             : out   std_logic_vector(15 downto 0);
        MDDR_BA                               : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N                            : out   std_logic;
        MDDR_CKE                              : out   std_logic;
        MDDR_CLK                              : out   std_logic;
        MDDR_CLK_N                            : out   std_logic;
        MDDR_CS_N                             : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT                 : out   std_logic;
        MDDR_ODT                              : out   std_logic;
        MDDR_RAS_N                            : out   std_logic;
        MDDR_RESET_N                          : out   std_logic;
        MDDR_WE_N                             : out   std_logic;
        -- Inouts
        MDDR_DM_RDQS                          : inout std_logic_vector(1 downto 0);
        MDDR_DQ                               : inout std_logic_vector(15 downto 0);
        MDDR_DQS                              : inout std_logic_vector(1 downto 0);
        MDDR_DQS_N                            : inout std_logic_vector(1 downto 0)
        );
end component;
-- User_Interfaces
component User_Interfaces
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
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal GPIO_0_LED0_net_0                             : std_logic_vector(0 to 0);
signal GPIO_1_LED1_net_0                             : std_logic_vector(1 to 1);
signal GPIO_2_SD_CS_net_0                            : std_logic_vector(2 to 2);
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR   : std_logic_vector(31 downto 0);
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE : std_logic;
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA  : std_logic_vector(31 downto 0);
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY  : std_logic;
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx   : std_logic;
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR : std_logic;
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA  : std_logic_vector(31 downto 0);
signal m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE  : std_logic;
signal m2s_creative_demo_0_FIC_0_CLK                 : std_logic;
signal m2s_creative_demo_0_INIT_DONE                 : std_logic;
signal MDDR_ADDR_net_0                               : std_logic_vector(15 downto 0);
signal MDDR_BA_net_0                                 : std_logic_vector(2 downto 0);
signal MDDR_CAS_N_net_0                              : std_logic;
signal MDDR_CKE_net_0                                : std_logic;
signal MDDR_CLK_net_0                                : std_logic;
signal MDDR_CLK_N_net_0                              : std_logic;
signal MDDR_CS_N_net_0                               : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_0                   : std_logic;
signal MDDR_ODT_net_0                                : std_logic;
signal MDDR_RAS_N_net_0                              : std_logic;
signal MDDR_RESET_N_net_0                            : std_logic;
signal MDDR_WE_N_net_0                               : std_logic;
signal SD_SCLK_net_0                                 : std_logic;
signal SD_SDO_net_0                                  : std_logic;
signal SPI_FLASH_SCLK_net_0                          : std_logic;
signal SPI_FLASH_SDO_net_0                           : std_logic;
signal SPI_FLASH_SS_net_0                            : std_logic;
signal UART_TXD_net_0                                : std_logic;
signal User_Interfaces_0_TIMINT                      : std_logic;
signal GPIO_0_LED0_net_1                             : std_logic;
signal GPIO_1_LED1_net_1                             : std_logic;
signal GPIO_2_SD_CS_net_1                            : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_1                   : std_logic;
signal MDDR_CAS_N_net_1                              : std_logic;
signal MDDR_CLK_net_1                                : std_logic;
signal MDDR_CLK_N_net_1                              : std_logic;
signal MDDR_CKE_net_1                                : std_logic;
signal MDDR_CS_N_net_1                               : std_logic;
signal MDDR_ODT_net_1                                : std_logic;
signal MDDR_RAS_N_net_1                              : std_logic;
signal MDDR_RESET_N_net_1                            : std_logic;
signal MDDR_WE_N_net_1                               : std_logic;
signal UART_TXD_net_1                                : std_logic;
signal SPI_FLASH_SDO_net_1                           : std_logic;
signal SPI_FLASH_SS_net_1                            : std_logic;
signal SD_SCLK_net_1                                 : std_logic;
signal SD_SDO_net_1                                  : std_logic;
signal SPI_FLASH_SCLK_net_1                          : std_logic;
signal MDDR_ADDR_net_1                               : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                                 : std_logic_vector(2 downto 0);
signal GPIO_OUT_slice_0                              : std_logic_vector(3 to 3);
signal GPIO_OUT_slice_1                              : std_logic_vector(4 to 4);
signal GPIO_OUT_slice_2                              : std_logic_vector(5 to 5);
signal GPIO_OUT_slice_3                              : std_logic_vector(6 to 6);
signal GPIO_OUT_slice_4                              : std_logic_vector(7 to 7);
signal MSS_INT_F2M_net_0                             : std_logic_vector(15 downto 0);
signal GPIO_OUT_net_0                                : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal MSS_INT_F2M_const_net_0                       : std_logic_vector(15 downto 2);
signal GND_net                                       : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 MSS_INT_F2M_const_net_0 <= B"00000000000000";
 GND_net                 <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 GPIO_0_LED0_net_1           <= GPIO_0_LED0_net_0(0);
 GPIO_0_LED0                 <= GPIO_0_LED0_net_1;
 GPIO_1_LED1_net_1           <= GPIO_1_LED1_net_0(1);
 GPIO_1_LED1                 <= GPIO_1_LED1_net_1;
 GPIO_2_SD_CS_net_1          <= GPIO_2_SD_CS_net_0(2);
 GPIO_2_SD_CS                <= GPIO_2_SD_CS_net_1;
 MDDR_DQS_TMATCH_0_OUT_net_1 <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT       <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1            <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                  <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1              <= MDDR_CLK_net_0;
 MDDR_CLK                    <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1            <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                  <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1              <= MDDR_CKE_net_0;
 MDDR_CKE                    <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1             <= MDDR_CS_N_net_0;
 MDDR_CS_N                   <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1              <= MDDR_ODT_net_0;
 MDDR_ODT                    <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1            <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                  <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1          <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1             <= MDDR_WE_N_net_0;
 MDDR_WE_N                   <= MDDR_WE_N_net_1;
 UART_TXD_net_1              <= UART_TXD_net_0;
 UART_TXD                    <= UART_TXD_net_1;
 SPI_FLASH_SDO_net_1         <= SPI_FLASH_SDO_net_0;
 SPI_FLASH_SDO               <= SPI_FLASH_SDO_net_1;
 SPI_FLASH_SS_net_1          <= SPI_FLASH_SS_net_0;
 SPI_FLASH_SS                <= SPI_FLASH_SS_net_1;
 SD_SCLK_net_1               <= SD_SCLK_net_0;
 SD_SCLK                     <= SD_SCLK_net_1;
 SD_SDO_net_1                <= SD_SDO_net_0;
 SD_SDO                      <= SD_SDO_net_1;
 SPI_FLASH_SCLK_net_1        <= SPI_FLASH_SCLK_net_0;
 SPI_FLASH_SCLK              <= SPI_FLASH_SCLK_net_1;
 MDDR_ADDR_net_1             <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)      <= MDDR_ADDR_net_1;
 MDDR_BA_net_1               <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)         <= MDDR_BA_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 GPIO_0_LED0_net_0(0)  <= GPIO_OUT_net_0(0);
 GPIO_1_LED1_net_0(1)  <= GPIO_OUT_net_0(1);
 GPIO_2_SD_CS_net_0(2) <= GPIO_OUT_net_0(2);
 GPIO_OUT_slice_0(3)   <= GPIO_OUT_net_0(3);
 GPIO_OUT_slice_1(4)   <= GPIO_OUT_net_0(4);
 GPIO_OUT_slice_2(5)   <= GPIO_OUT_net_0(5);
 GPIO_OUT_slice_3(6)   <= GPIO_OUT_net_0(6);
 GPIO_OUT_slice_4(7)   <= GPIO_OUT_net_0(7);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 MSS_INT_F2M_net_0 <= ( B"00000000000000" & '0' & User_Interfaces_0_TIMINT );
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- m2s_creative_demo_0
m2s_creative_demo_0 : ddr_mss
    port map( 
        -- Inputs
        MDDR_DQS_TMATCH_0_IN                  => MDDR_DQS_TMATCH_0_IN,
        CLK0_PAD                              => CLK0_PAD,
        DEVRST_N                              => DEVRST_N,
        XTL                                   => XTL,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR,
        MSS_INT_F2M                           => MSS_INT_F2M_net_0,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA,
        -- Outputs
        MDDR_DQS_TMATCH_0_OUT                 => MDDR_DQS_TMATCH_0_OUT_net_0,
        MDDR_CAS_N                            => MDDR_CAS_N_net_0,
        MDDR_CLK                              => MDDR_CLK_net_0,
        MDDR_CLK_N                            => MDDR_CLK_N_net_0,
        MDDR_CKE                              => MDDR_CKE_net_0,
        MDDR_CS_N                             => MDDR_CS_N_net_0,
        MDDR_ODT                              => MDDR_ODT_net_0,
        MDDR_RAS_N                            => MDDR_RAS_N_net_0,
        MDDR_RESET_N                          => MDDR_RESET_N_net_0,
        MDDR_WE_N                             => MDDR_WE_N_net_0,
        INIT_DONE                             => m2s_creative_demo_0_INIT_DONE,
        FIC_0_CLK                             => m2s_creative_demo_0_FIC_0_CLK,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL    => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE,
        MDDR_ADDR                             => MDDR_ADDR_net_0,
        MDDR_BA                               => MDDR_BA_net_0,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR   => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR,
        FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA,
        -- Inouts
        MDDR_DM_RDQS                          => MDDR_DM_RDQS,
        MDDR_DQ                               => MDDR_DQ,
        MDDR_DQS                              => MDDR_DQS,
        MDDR_DQS_N                            => MDDR_DQS_N 
        );
-- User_Interfaces_0
User_Interfaces_0 : User_Interfaces
    port map( 
        -- Inputs
        PCLK                => m2s_creative_demo_0_FIC_0_CLK,
        PRESETN             => m2s_creative_demo_0_INIT_DONE,
        RX                  => UART_RXD,
        SPI_FLASH_SDI       => SPI_FLASH_SDI,
        SD_SDI              => SD_SDI,
        APB3mmaster_PSEL    => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx,
        APB3mmaster_PENABLE => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE,
        APB3mmaster_PWRITE  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE,
        GPIO_1_IN           => GPIO_1_SW3,
        GPIO_0_IN           => GPIO_0_SW2,
        APB3mmaster_PADDR   => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR,
        APB3mmaster_PWDATA  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA,
        -- Outputs
        TX                  => UART_TXD_net_0,
        TIMINT              => User_Interfaces_0_TIMINT,
        SPI_FLASH_SDO       => SPI_FLASH_SDO_net_0,
        SPI_FLASH_SS        => SPI_FLASH_SS_net_0,
        SD_SS               => OPEN,
        SD_SCLK             => SD_SCLK_net_0,
        SD_SDO              => SD_SDO_net_0,
        SPI_FLASH_SCLK      => SPI_FLASH_SCLK_net_0,
        APB3mmaster_PREADY  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY,
        APB3mmaster_PSLVERR => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR,
        GPIO_OUT            => GPIO_OUT_net_0,
        APB3mmaster_PRDATA  => m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA 
        );

end RTL;
