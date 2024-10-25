----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:33:20 2024
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
-- ddr_mss entity declaration
----------------------------------------------------------------------
entity ddr_mss is
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
end ddr_mss;
----------------------------------------------------------------------
-- ddr_mss architecture body
----------------------------------------------------------------------
architecture RTL of ddr_mss is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- ddr_mss_sb
component ddr_mss_sb
    -- Port list
    port(
        -- Inputs
        CLK0_PAD              : in    std_logic;
        DEVRST_N              : in    std_logic;
        FAB_RESET_N           : in    std_logic;
        FIC_0_APB_M_PRDATA    : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY    : in    std_logic;
        FIC_0_APB_M_PSLVERR   : in    std_logic;
        MDDR_DQS_TMATCH_0_IN  : in    std_logic;
        MSS_INT_F2M           : in    std_logic_vector(15 downto 0);
        XTL                   : in    std_logic;
        -- Outputs
        DDR_READY             : out   std_logic;
        FAB_CCC_GL2           : out   std_logic;
        FAB_CCC_LOCK          : out   std_logic;
        FIC_0_APB_M_PADDR     : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE   : out   std_logic;
        FIC_0_APB_M_PSEL      : out   std_logic;
        FIC_0_APB_M_PWDATA    : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE    : out   std_logic;
        FIC_0_CLK             : out   std_logic;
        FIC_0_LOCK            : out   std_logic;
        INIT_DONE             : out   std_logic;
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
        MSS_READY             : out   std_logic;
        POWER_ON_RESET_N      : out   std_logic;
        -- Inouts
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        MDDR_DQS_N            : inout std_logic_vector(1 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal FIC_0_AMBA_MASTER_PADDR         : std_logic_vector(31 downto 0);
signal FIC_0_AMBA_MASTER_PENABLE       : std_logic;
signal FIC_0_AMBA_MASTER_PSELx         : std_logic;
signal FIC_0_AMBA_MASTER_PWDATA        : std_logic_vector(31 downto 0);
signal FIC_0_AMBA_MASTER_PWRITE        : std_logic;
signal FIC_0_CLK_net_0                 : std_logic;
signal INIT_DONE_net_0                 : std_logic;
signal MDDR_ADDR_net_0                 : std_logic_vector(15 downto 0);
signal MDDR_BA_net_0                   : std_logic_vector(2 downto 0);
signal MDDR_CAS_N_net_0                : std_logic;
signal MDDR_CKE_net_0                  : std_logic;
signal MDDR_CLK_net_0                  : std_logic;
signal MDDR_CLK_N_net_0                : std_logic;
signal MDDR_CS_N_net_0                 : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_0     : std_logic;
signal MDDR_ODT_net_0                  : std_logic;
signal MDDR_RAS_N_net_0                : std_logic;
signal MDDR_RESET_N_net_0              : std_logic;
signal MDDR_WE_N_net_0                 : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_1     : std_logic;
signal MDDR_CAS_N_net_1                : std_logic;
signal MDDR_CLK_net_1                  : std_logic;
signal MDDR_CLK_N_net_1                : std_logic;
signal MDDR_CKE_net_1                  : std_logic;
signal MDDR_CS_N_net_1                 : std_logic;
signal MDDR_ODT_net_1                  : std_logic;
signal MDDR_RAS_N_net_1                : std_logic;
signal MDDR_RESET_N_net_1              : std_logic;
signal MDDR_WE_N_net_1                 : std_logic;
signal INIT_DONE_net_1                 : std_logic;
signal FIC_0_CLK_net_1                 : std_logic;
signal FIC_0_AMBA_MASTER_PSELx_net_0   : std_logic;
signal FIC_0_AMBA_MASTER_PENABLE_net_0 : std_logic;
signal FIC_0_AMBA_MASTER_PWRITE_net_0  : std_logic;
signal MDDR_ADDR_net_1                 : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                   : std_logic_vector(2 downto 0);
signal FIC_0_AMBA_MASTER_PADDR_net_0   : std_logic_vector(31 downto 0);
signal FIC_0_AMBA_MASTER_PWDATA_net_0  : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                         : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 MDDR_DQS_TMATCH_0_OUT_net_1                       <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT                             <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1                                  <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                                        <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1                                    <= MDDR_CLK_net_0;
 MDDR_CLK                                          <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1                                  <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                                        <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1                                    <= MDDR_CKE_net_0;
 MDDR_CKE                                          <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1                                   <= MDDR_CS_N_net_0;
 MDDR_CS_N                                         <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1                                    <= MDDR_ODT_net_0;
 MDDR_ODT                                          <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1                                  <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                                        <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1                                <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                                      <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1                                   <= MDDR_WE_N_net_0;
 MDDR_WE_N                                         <= MDDR_WE_N_net_1;
 INIT_DONE_net_1                                   <= INIT_DONE_net_0;
 INIT_DONE                                         <= INIT_DONE_net_1;
 FIC_0_CLK_net_1                                   <= FIC_0_CLK_net_0;
 FIC_0_CLK                                         <= FIC_0_CLK_net_1;
 FIC_0_AMBA_MASTER_PSELx_net_0                     <= FIC_0_AMBA_MASTER_PSELx;
 FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL                <= FIC_0_AMBA_MASTER_PSELx_net_0;
 FIC_0_AMBA_MASTER_PENABLE_net_0                   <= FIC_0_AMBA_MASTER_PENABLE;
 FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE             <= FIC_0_AMBA_MASTER_PENABLE_net_0;
 FIC_0_AMBA_MASTER_PWRITE_net_0                    <= FIC_0_AMBA_MASTER_PWRITE;
 FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE              <= FIC_0_AMBA_MASTER_PWRITE_net_0;
 MDDR_ADDR_net_1                                   <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)                            <= MDDR_ADDR_net_1;
 MDDR_BA_net_1                                     <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)                               <= MDDR_BA_net_1;
 FIC_0_AMBA_MASTER_PADDR_net_0                     <= FIC_0_AMBA_MASTER_PADDR;
 FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR(31 downto 0)  <= FIC_0_AMBA_MASTER_PADDR_net_0;
 FIC_0_AMBA_MASTER_PWDATA_net_0                    <= FIC_0_AMBA_MASTER_PWDATA;
 FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA(31 downto 0) <= FIC_0_AMBA_MASTER_PWDATA_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- ddr_mss_sb_0
ddr_mss_sb_0 : ddr_mss_sb
    port map( 
        -- Inputs
        MDDR_DQS_TMATCH_0_IN  => MDDR_DQS_TMATCH_0_IN,
        FAB_RESET_N           => VCC_net,
        CLK0_PAD              => CLK0_PAD,
        XTL                   => XTL,
        DEVRST_N              => DEVRST_N,
        FIC_0_APB_M_PREADY    => FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY,
        FIC_0_APB_M_PSLVERR   => FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR,
        MSS_INT_F2M           => MSS_INT_F2M,
        FIC_0_APB_M_PRDATA    => FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA,
        -- Outputs
        MDDR_DQS_TMATCH_0_OUT => MDDR_DQS_TMATCH_0_OUT_net_0,
        MDDR_CAS_N            => MDDR_CAS_N_net_0,
        MDDR_CLK              => MDDR_CLK_net_0,
        MDDR_CLK_N            => MDDR_CLK_N_net_0,
        MDDR_CKE              => MDDR_CKE_net_0,
        MDDR_CS_N             => MDDR_CS_N_net_0,
        MDDR_ODT              => MDDR_ODT_net_0,
        MDDR_RAS_N            => MDDR_RAS_N_net_0,
        MDDR_RESET_N          => MDDR_RESET_N_net_0,
        MDDR_WE_N             => MDDR_WE_N_net_0,
        POWER_ON_RESET_N      => OPEN,
        INIT_DONE             => INIT_DONE_net_0,
        FIC_0_CLK             => FIC_0_CLK_net_0,
        FIC_0_LOCK            => OPEN,
        DDR_READY             => OPEN,
        FAB_CCC_GL2           => OPEN,
        FAB_CCC_LOCK          => OPEN,
        MSS_READY             => OPEN,
        FIC_0_APB_M_PSEL      => FIC_0_AMBA_MASTER_PSELx,
        FIC_0_APB_M_PENABLE   => FIC_0_AMBA_MASTER_PENABLE,
        FIC_0_APB_M_PWRITE    => FIC_0_AMBA_MASTER_PWRITE,
        MDDR_ADDR             => MDDR_ADDR_net_0,
        MDDR_BA               => MDDR_BA_net_0,
        FIC_0_APB_M_PADDR     => FIC_0_AMBA_MASTER_PADDR,
        FIC_0_APB_M_PWDATA    => FIC_0_AMBA_MASTER_PWDATA,
        -- Inouts
        MDDR_DM_RDQS          => MDDR_DM_RDQS,
        MDDR_DQ               => MDDR_DQ,
        MDDR_DQS              => MDDR_DQS,
        MDDR_DQS_N            => MDDR_DQS_N 
        );

end RTL;
