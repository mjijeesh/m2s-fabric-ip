----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 25 14:33:00 2024
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
-- ddr_mss_sb entity declaration
----------------------------------------------------------------------
entity ddr_mss_sb is
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
end ddr_mss_sb;
----------------------------------------------------------------------
-- ddr_mss_sb architecture body
----------------------------------------------------------------------
architecture RTL of ddr_mss_sb is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- ddr_mss_sb_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.201
component ddr_mss_sb_CCC_0_FCCC
    -- Port list
    port(
        -- Inputs
        CLK0_PAD : in  std_logic;
        -- Outputs
        GL0      : out std_logic;
        GL2      : out std_logic;
        LOCK     : out std_logic
        );
end component;
-- CoreConfigP   -   Actel:DirectCore:CoreConfigP:7.1.100
component CoreConfigP
    generic( 
        DEVICE_090         : integer := 0 ;
        ENABLE_SOFT_RESETS : integer := 1 ;
        FDDR_IN_USE        : integer := 0 ;
        MDDR_IN_USE        : integer := 1 ;
        SDIF0_IN_USE       : integer := 0 ;
        SDIF0_PCIE         : integer := 0 ;
        SDIF1_IN_USE       : integer := 0 ;
        SDIF1_PCIE         : integer := 0 ;
        SDIF2_IN_USE       : integer := 0 ;
        SDIF2_PCIE         : integer := 0 ;
        SDIF3_IN_USE       : integer := 0 ;
        SDIF3_PCIE         : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        FDDR_PRDATA                    : in  std_logic_vector(31 downto 0);
        FDDR_PREADY                    : in  std_logic;
        FDDR_PSLVERR                   : in  std_logic;
        FIC_2_APB_M_PADDR              : in  std_logic_vector(16 downto 2);
        FIC_2_APB_M_PCLK               : in  std_logic;
        FIC_2_APB_M_PENABLE            : in  std_logic;
        FIC_2_APB_M_PRESET_N           : in  std_logic;
        FIC_2_APB_M_PSEL               : in  std_logic;
        FIC_2_APB_M_PWDATA             : in  std_logic_vector(31 downto 0);
        FIC_2_APB_M_PWRITE             : in  std_logic;
        INIT_DONE                      : in  std_logic;
        MDDR_PRDATA                    : in  std_logic_vector(31 downto 0);
        MDDR_PREADY                    : in  std_logic;
        MDDR_PSLVERR                   : in  std_logic;
        SDIF0_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF0_PREADY                   : in  std_logic;
        SDIF0_PSLVERR                  : in  std_logic;
        SDIF1_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF1_PREADY                   : in  std_logic;
        SDIF1_PSLVERR                  : in  std_logic;
        SDIF2_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF2_PREADY                   : in  std_logic;
        SDIF2_PSLVERR                  : in  std_logic;
        SDIF3_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF3_PREADY                   : in  std_logic;
        SDIF3_PSLVERR                  : in  std_logic;
        SDIF_RELEASED                  : in  std_logic;
        -- Outputs
        APB_S_PCLK                     : out std_logic;
        APB_S_PRESET_N                 : out std_logic;
        CONFIG1_DONE                   : out std_logic;
        CONFIG2_DONE                   : out std_logic;
        FDDR_PADDR                     : out std_logic_vector(15 downto 2);
        FDDR_PENABLE                   : out std_logic;
        FDDR_PSEL                      : out std_logic;
        FDDR_PWDATA                    : out std_logic_vector(31 downto 0);
        FDDR_PWRITE                    : out std_logic;
        FIC_2_APB_M_PRDATA             : out std_logic_vector(31 downto 0);
        FIC_2_APB_M_PREADY             : out std_logic;
        FIC_2_APB_M_PSLVERR            : out std_logic;
        MDDR_PADDR                     : out std_logic_vector(15 downto 2);
        MDDR_PENABLE                   : out std_logic;
        MDDR_PSEL                      : out std_logic;
        MDDR_PWDATA                    : out std_logic_vector(31 downto 0);
        MDDR_PWRITE                    : out std_logic;
        R_SDIF0_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF0_PSEL                   : out std_logic;
        R_SDIF0_PWRITE                 : out std_logic;
        R_SDIF1_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF1_PSEL                   : out std_logic;
        R_SDIF1_PWRITE                 : out std_logic;
        R_SDIF2_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF2_PSEL                   : out std_logic;
        R_SDIF2_PWRITE                 : out std_logic;
        R_SDIF3_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF3_PSEL                   : out std_logic;
        R_SDIF3_PWRITE                 : out std_logic;
        SDIF0_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF0_PENABLE                  : out std_logic;
        SDIF0_PSEL                     : out std_logic;
        SDIF0_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF0_PWRITE                   : out std_logic;
        SDIF1_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF1_PENABLE                  : out std_logic;
        SDIF1_PSEL                     : out std_logic;
        SDIF1_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF1_PWRITE                   : out std_logic;
        SDIF2_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF2_PENABLE                  : out std_logic;
        SDIF2_PSEL                     : out std_logic;
        SDIF2_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF2_PWRITE                   : out std_logic;
        SDIF3_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF3_PENABLE                  : out std_logic;
        SDIF3_PSEL                     : out std_logic;
        SDIF3_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF3_PWRITE                   : out std_logic;
        SOFT_EXT_RESET_OUT             : out std_logic;
        SOFT_FDDR_CORE_RESET           : out std_logic;
        SOFT_M3_RESET                  : out std_logic;
        SOFT_MDDR_DDR_AXI_S_CORE_RESET : out std_logic;
        SOFT_RESET_F2M                 : out std_logic;
        SOFT_SDIF0_0_CORE_RESET        : out std_logic;
        SOFT_SDIF0_1_CORE_RESET        : out std_logic;
        SOFT_SDIF0_CORE_RESET          : out std_logic;
        SOFT_SDIF0_PHY_RESET           : out std_logic;
        SOFT_SDIF1_CORE_RESET          : out std_logic;
        SOFT_SDIF1_PHY_RESET           : out std_logic;
        SOFT_SDIF2_CORE_RESET          : out std_logic;
        SOFT_SDIF2_PHY_RESET           : out std_logic;
        SOFT_SDIF3_CORE_RESET          : out std_logic;
        SOFT_SDIF3_PHY_RESET           : out std_logic
        );
end component;
-- CoreResetP   -   Actel:DirectCore:CoreResetP:7.1.100
component CoreResetP
    generic( 
        DDR_WAIT            : integer := 200 ;
        DEVICE_090          : integer := 0 ;
        DEVICE_VOLTAGE      : integer := 2 ;
        ENABLE_SOFT_RESETS  : integer := 1 ;
        EXT_RESET_CFG       : integer := 0 ;
        FDDR_IN_USE         : integer := 0 ;
        MDDR_IN_USE         : integer := 1 ;
        SDIF0_IN_USE        : integer := 0 ;
        SDIF0_PCIE          : integer := 0 ;
        SDIF0_PCIE_HOTRESET : integer := 1 ;
        SDIF0_PCIE_L2P2     : integer := 1 ;
        SDIF1_IN_USE        : integer := 0 ;
        SDIF1_PCIE          : integer := 0 ;
        SDIF1_PCIE_HOTRESET : integer := 1 ;
        SDIF1_PCIE_L2P2     : integer := 1 ;
        SDIF2_IN_USE        : integer := 0 ;
        SDIF2_PCIE          : integer := 0 ;
        SDIF2_PCIE_HOTRESET : integer := 1 ;
        SDIF2_PCIE_L2P2     : integer := 1 ;
        SDIF3_IN_USE        : integer := 0 ;
        SDIF3_PCIE          : integer := 0 ;
        SDIF3_PCIE_HOTRESET : integer := 1 ;
        SDIF3_PCIE_L2P2     : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        CLK_BASE                       : in  std_logic;
        CLK_LTSSM                      : in  std_logic;
        CONFIG1_DONE                   : in  std_logic;
        CONFIG2_DONE                   : in  std_logic;
        FAB_RESET_N                    : in  std_logic;
        FIC_2_APB_M_PRESET_N           : in  std_logic;
        FPLL_LOCK                      : in  std_logic;
        POWER_ON_RESET_N               : in  std_logic;
        RCOSC_25_50MHZ                 : in  std_logic;
        RESET_N_M2F                    : in  std_logic;
        SDIF0_PERST_N                  : in  std_logic;
        SDIF0_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF0_PSEL                     : in  std_logic;
        SDIF0_PWRITE                   : in  std_logic;
        SDIF0_SPLL_LOCK                : in  std_logic;
        SDIF1_PERST_N                  : in  std_logic;
        SDIF1_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF1_PSEL                     : in  std_logic;
        SDIF1_PWRITE                   : in  std_logic;
        SDIF1_SPLL_LOCK                : in  std_logic;
        SDIF2_PERST_N                  : in  std_logic;
        SDIF2_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF2_PSEL                     : in  std_logic;
        SDIF2_PWRITE                   : in  std_logic;
        SDIF2_SPLL_LOCK                : in  std_logic;
        SDIF3_PERST_N                  : in  std_logic;
        SDIF3_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF3_PSEL                     : in  std_logic;
        SDIF3_PWRITE                   : in  std_logic;
        SDIF3_SPLL_LOCK                : in  std_logic;
        SOFT_EXT_RESET_OUT             : in  std_logic;
        SOFT_FDDR_CORE_RESET           : in  std_logic;
        SOFT_M3_RESET                  : in  std_logic;
        SOFT_MDDR_DDR_AXI_S_CORE_RESET : in  std_logic;
        SOFT_RESET_F2M                 : in  std_logic;
        SOFT_SDIF0_0_CORE_RESET        : in  std_logic;
        SOFT_SDIF0_1_CORE_RESET        : in  std_logic;
        SOFT_SDIF0_CORE_RESET          : in  std_logic;
        SOFT_SDIF0_PHY_RESET           : in  std_logic;
        SOFT_SDIF1_CORE_RESET          : in  std_logic;
        SOFT_SDIF1_PHY_RESET           : in  std_logic;
        SOFT_SDIF2_CORE_RESET          : in  std_logic;
        SOFT_SDIF2_PHY_RESET           : in  std_logic;
        SOFT_SDIF3_CORE_RESET          : in  std_logic;
        SOFT_SDIF3_PHY_RESET           : in  std_logic;
        -- Outputs
        DDR_READY                      : out std_logic;
        EXT_RESET_OUT                  : out std_logic;
        FDDR_CORE_RESET_N              : out std_logic;
        INIT_DONE                      : out std_logic;
        M3_RESET_N                     : out std_logic;
        MDDR_DDR_AXI_S_CORE_RESET_N    : out std_logic;
        MSS_HPMS_READY                 : out std_logic;
        RESET_N_F2M                    : out std_logic;
        SDIF0_0_CORE_RESET_N           : out std_logic;
        SDIF0_1_CORE_RESET_N           : out std_logic;
        SDIF0_CORE_RESET_N             : out std_logic;
        SDIF0_PHY_RESET_N              : out std_logic;
        SDIF1_CORE_RESET_N             : out std_logic;
        SDIF1_PHY_RESET_N              : out std_logic;
        SDIF2_CORE_RESET_N             : out std_logic;
        SDIF2_PHY_RESET_N              : out std_logic;
        SDIF3_CORE_RESET_N             : out std_logic;
        SDIF3_PHY_RESET_N              : out std_logic;
        SDIF_READY                     : out std_logic;
        SDIF_RELEASED                  : out std_logic
        );
end component;
-- ddr_mss_sb_MSS
component ddr_mss_sb_MSS
    -- Port list
    port(
        -- Inputs
        FIC_0_APB_M_PRDATA     : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY     : in    std_logic;
        FIC_0_APB_M_PSLVERR    : in    std_logic;
        FIC_2_APB_M_PRDATA     : in    std_logic_vector(31 downto 0);
        FIC_2_APB_M_PREADY     : in    std_logic;
        FIC_2_APB_M_PSLVERR    : in    std_logic;
        M3_RESET_N             : in    std_logic;
        MCCC_CLK_BASE          : in    std_logic;
        MCCC_CLK_BASE_PLL_LOCK : in    std_logic;
        MDDR_APB_S_PADDR       : in    std_logic_vector(10 downto 2);
        MDDR_APB_S_PCLK        : in    std_logic;
        MDDR_APB_S_PENABLE     : in    std_logic;
        MDDR_APB_S_PRESET_N    : in    std_logic;
        MDDR_APB_S_PSEL        : in    std_logic;
        MDDR_APB_S_PWDATA      : in    std_logic_vector(15 downto 0);
        MDDR_APB_S_PWRITE      : in    std_logic;
        MDDR_DQS_TMATCH_0_IN   : in    std_logic;
        MSS_INT_F2M            : in    std_logic_vector(15 downto 0);
        MSS_RESET_N_F2M        : in    std_logic;
        -- Outputs
        FIC_0_APB_M_PADDR      : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE    : out   std_logic;
        FIC_0_APB_M_PSEL       : out   std_logic;
        FIC_0_APB_M_PWDATA     : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE     : out   std_logic;
        FIC_2_APB_M_PADDR      : out   std_logic_vector(15 downto 2);
        FIC_2_APB_M_PCLK       : out   std_logic;
        FIC_2_APB_M_PENABLE    : out   std_logic;
        FIC_2_APB_M_PRESET_N   : out   std_logic;
        FIC_2_APB_M_PSEL       : out   std_logic;
        FIC_2_APB_M_PWDATA     : out   std_logic_vector(31 downto 0);
        FIC_2_APB_M_PWRITE     : out   std_logic;
        MDDR_ADDR              : out   std_logic_vector(15 downto 0);
        MDDR_APB_S_PRDATA      : out   std_logic_vector(15 downto 0);
        MDDR_APB_S_PREADY      : out   std_logic;
        MDDR_APB_S_PSLVERR     : out   std_logic;
        MDDR_BA                : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N             : out   std_logic;
        MDDR_CKE               : out   std_logic;
        MDDR_CLK               : out   std_logic;
        MDDR_CLK_N             : out   std_logic;
        MDDR_CS_N              : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT  : out   std_logic;
        MDDR_ODT               : out   std_logic;
        MDDR_RAS_N             : out   std_logic;
        MDDR_RESET_N           : out   std_logic;
        MDDR_WE_N              : out   std_logic;
        MSS_RESET_N_M2F        : out   std_logic;
        -- Inouts
        MDDR_DM_RDQS           : inout std_logic_vector(1 downto 0);
        MDDR_DQ                : inout std_logic_vector(15 downto 0);
        MDDR_DQS               : inout std_logic_vector(1 downto 0);
        MDDR_DQS_N             : inout std_logic_vector(1 downto 0)
        );
end component;
-- ddr_mss_sb_FABOSC_0_OSC   -   Actel:SgCore:OSC:2.0.101
component ddr_mss_sb_FABOSC_0_OSC
    -- Port list
    port(
        -- Inputs
        XTL                : in  std_logic;
        -- Outputs
        RCOSC_1MHZ_CCC     : out std_logic;
        RCOSC_1MHZ_O2F     : out std_logic;
        RCOSC_25_50MHZ_CCC : out std_logic;
        RCOSC_25_50MHZ_O2F : out std_logic;
        XTLOSC_CCC         : out std_logic;
        XTLOSC_O2F         : out std_logic
        );
end component;
-- SYSRESET
component SYSRESET
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in  std_logic;
        -- Outputs
        POWER_ON_RESET_N : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CORECONFIGP_0_APB_S_PCLK                      : std_logic;
signal CORECONFIGP_0_APB_S_PRESET_N                  : std_logic;
signal CORECONFIGP_0_CONFIG1_DONE                    : std_logic;
signal CORECONFIGP_0_CONFIG2_DONE                    : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PENABLE          : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PREADY           : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PSELx            : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PSLVERR          : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PWRITE           : std_logic;
signal CORECONFIGP_0_SOFT_EXT_RESET_OUT              : std_logic;
signal CORECONFIGP_0_SOFT_M3_RESET                   : std_logic;
signal CORECONFIGP_0_SOFT_MDDR_DDR_AXI_S_CORE_RESET  : std_logic;
signal CORECONFIGP_0_SOFT_RESET_F2M                  : std_logic;
signal CORERESETP_0_M3_RESET_N                       : std_logic;
signal CORERESETP_0_RESET_N_F2M                      : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PCLK         : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N     : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA  : std_logic_vector(31 downto 0);
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY  : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx   : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR : std_logic;
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA  : std_logic_vector(31 downto 0);
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE  : std_logic;
signal ddr_mss_sb_MSS_TMP_0_MSS_RESET_N_M2F          : std_logic;
signal DDR_READY_net_0                               : std_logic;
signal FAB_CCC_GL2_net_0                             : std_logic;
signal FABOSC_0_RCOSC_25_50MHZ_O2F                   : std_logic;
signal FIC_0_APB_MASTER_2_PADDR                      : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_2_PENABLE                    : std_logic;
signal FIC_0_APB_MASTER_2_PSELx                      : std_logic;
signal FIC_0_APB_MASTER_2_PWDATA                     : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_2_PWRITE                     : std_logic;
signal FIC_0_CLK_net_0                               : std_logic;
signal FIC_0_LOCK_net_0                              : std_logic;
signal INIT_DONE_net_0                               : std_logic;
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
signal MSS_READY_net_0                               : std_logic;
signal POWER_ON_RESET_N_net_0                        : std_logic;
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
signal MDDR_ADDR_net_1                               : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                                 : std_logic_vector(2 downto 0);
signal POWER_ON_RESET_N_net_1                        : std_logic;
signal INIT_DONE_net_1                               : std_logic;
signal FIC_0_CLK_net_1                               : std_logic;
signal FIC_0_LOCK_net_1                              : std_logic;
signal DDR_READY_net_1                               : std_logic;
signal FAB_CCC_GL2_net_1                             : std_logic;
signal FIC_0_LOCK_net_2                              : std_logic;
signal MSS_READY_net_1                               : std_logic;
signal FIC_0_APB_MASTER_2_PADDR_net_0                : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_2_PSELx_net_0                : std_logic;
signal FIC_0_APB_MASTER_2_PENABLE_net_0              : std_logic;
signal FIC_0_APB_MASTER_2_PWRITE_net_0               : std_logic;
signal FIC_0_APB_MASTER_2_PWDATA_net_0               : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                                       : std_logic;
signal PADDR_const_net_0                             : std_logic_vector(7 downto 2);
signal PWDATA_const_net_0                            : std_logic_vector(7 downto 0);
signal FDDR_PRDATA_const_net_0                       : std_logic_vector(31 downto 0);
signal VCC_net                                       : std_logic;
signal SDIF0_PRDATA_const_net_0                      : std_logic_vector(31 downto 0);
signal SDIF1_PRDATA_const_net_0                      : std_logic_vector(31 downto 0);
signal SDIF2_PRDATA_const_net_0                      : std_logic_vector(31 downto 0);
signal SDIF3_PRDATA_const_net_0                      : std_logic_vector(31 downto 0);
signal SDIF0_PRDATA_const_net_1                      : std_logic_vector(31 downto 0);
signal SDIF1_PRDATA_const_net_1                      : std_logic_vector(31 downto 0);
signal SDIF2_PRDATA_const_net_1                      : std_logic_vector(31 downto 0);
signal SDIF3_PRDATA_const_net_1                      : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2    : std_logic_vector(10 downto 2);
signal CORECONFIGP_0_MDDR_APBmslave_PADDR_0          : std_logic_vector(10 downto 2);
signal CORECONFIGP_0_MDDR_APBmslave_PADDR            : std_logic_vector(15 downto 2);

signal CORECONFIGP_0_MDDR_APBmslave_PRDATA           : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16  : std_logic_vector(31 downto 16);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0   : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0         : std_logic_vector(31 downto 0);

signal CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0   : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PWDATA_0         : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PWDATA           : std_logic_vector(31 downto 0);

signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16: std_logic_vector(16 to 16);
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2: std_logic_vector(15 downto 2);
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0 : std_logic_vector(16 downto 2);
signal ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR   : std_logic_vector(15 downto 2);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net                  <= '0';
 PADDR_const_net_0        <= B"000000";
 PWDATA_const_net_0       <= B"00000000";
 FDDR_PRDATA_const_net_0  <= B"00000000000000000000000000000000";
 VCC_net                  <= '1';
 SDIF0_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF1_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF2_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF3_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF0_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF1_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF2_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF3_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 MDDR_DQS_TMATCH_0_OUT_net_1      <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT            <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1                 <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                       <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1                   <= MDDR_CLK_net_0;
 MDDR_CLK                         <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1                 <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                       <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1                   <= MDDR_CKE_net_0;
 MDDR_CKE                         <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1                  <= MDDR_CS_N_net_0;
 MDDR_CS_N                        <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1                   <= MDDR_ODT_net_0;
 MDDR_ODT                         <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1                 <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                       <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1               <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                     <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1                  <= MDDR_WE_N_net_0;
 MDDR_WE_N                        <= MDDR_WE_N_net_1;
 MDDR_ADDR_net_1                  <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)           <= MDDR_ADDR_net_1;
 MDDR_BA_net_1                    <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)              <= MDDR_BA_net_1;
 POWER_ON_RESET_N_net_1           <= POWER_ON_RESET_N_net_0;
 POWER_ON_RESET_N                 <= POWER_ON_RESET_N_net_1;
 INIT_DONE_net_1                  <= INIT_DONE_net_0;
 INIT_DONE                        <= INIT_DONE_net_1;
 FIC_0_CLK_net_1                  <= FIC_0_CLK_net_0;
 FIC_0_CLK                        <= FIC_0_CLK_net_1;
 FIC_0_LOCK_net_1                 <= FIC_0_LOCK_net_0;
 FIC_0_LOCK                       <= FIC_0_LOCK_net_1;
 DDR_READY_net_1                  <= DDR_READY_net_0;
 DDR_READY                        <= DDR_READY_net_1;
 FAB_CCC_GL2_net_1                <= FAB_CCC_GL2_net_0;
 FAB_CCC_GL2                      <= FAB_CCC_GL2_net_1;
 FIC_0_LOCK_net_2                 <= FIC_0_LOCK_net_0;
 FAB_CCC_LOCK                     <= FIC_0_LOCK_net_2;
 MSS_READY_net_1                  <= MSS_READY_net_0;
 MSS_READY                        <= MSS_READY_net_1;
 FIC_0_APB_MASTER_2_PADDR_net_0   <= FIC_0_APB_MASTER_2_PADDR;
 FIC_0_APB_M_PADDR(31 downto 0)   <= FIC_0_APB_MASTER_2_PADDR_net_0;
 FIC_0_APB_MASTER_2_PSELx_net_0   <= FIC_0_APB_MASTER_2_PSELx;
 FIC_0_APB_M_PSEL                 <= FIC_0_APB_MASTER_2_PSELx_net_0;
 FIC_0_APB_MASTER_2_PENABLE_net_0 <= FIC_0_APB_MASTER_2_PENABLE;
 FIC_0_APB_M_PENABLE              <= FIC_0_APB_MASTER_2_PENABLE_net_0;
 FIC_0_APB_MASTER_2_PWRITE_net_0  <= FIC_0_APB_MASTER_2_PWRITE;
 FIC_0_APB_M_PWRITE               <= FIC_0_APB_MASTER_2_PWRITE_net_0;
 FIC_0_APB_MASTER_2_PWDATA_net_0  <= FIC_0_APB_MASTER_2_PWDATA;
 FIC_0_APB_M_PWDATA(31 downto 0)  <= FIC_0_APB_MASTER_2_PWDATA_net_0;
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2(10 downto 2) <= CORECONFIGP_0_MDDR_APBmslave_PADDR(10 downto 2);
 CORECONFIGP_0_MDDR_APBmslave_PADDR_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2(10 downto 2) );

 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16(31 downto 16) <= B"0000000000000000";
 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0(15 downto 0) <= CORECONFIGP_0_MDDR_APBmslave_PRDATA(15 downto 0);
 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16(31 downto 16) & CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0(15 downto 0) );

 CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0(15 downto 0) <= CORECONFIGP_0_MDDR_APBmslave_PWDATA(15 downto 0);
 CORECONFIGP_0_MDDR_APBmslave_PWDATA_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0(15 downto 0) );

 ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16(16) <= '0';
 ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2(15 downto 2) <= ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR(15 downto 2);
 ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0 <= ( ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16(16) & ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2(15 downto 2) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CCC_0   -   Actel:SgCore:FCCC:2.0.201
CCC_0 : ddr_mss_sb_CCC_0_FCCC
    port map( 
        -- Inputs
        CLK0_PAD => CLK0_PAD,
        -- Outputs
        GL0      => FIC_0_CLK_net_0,
        GL2      => FAB_CCC_GL2_net_0,
        LOCK     => FIC_0_LOCK_net_0 
        );
-- CORECONFIGP_0   -   Actel:DirectCore:CoreConfigP:7.1.100
CORECONFIGP_0 : CoreConfigP
    generic map( 
        DEVICE_090         => ( 0 ),
        ENABLE_SOFT_RESETS => ( 1 ),
        FDDR_IN_USE        => ( 0 ),
        MDDR_IN_USE        => ( 1 ),
        SDIF0_IN_USE       => ( 0 ),
        SDIF0_PCIE         => ( 0 ),
        SDIF1_IN_USE       => ( 0 ),
        SDIF1_PCIE         => ( 0 ),
        SDIF2_IN_USE       => ( 0 ),
        SDIF2_PCIE         => ( 0 ),
        SDIF3_IN_USE       => ( 0 ),
        SDIF3_PCIE         => ( 0 )
        )
    port map( 
        -- Inputs
        FIC_2_APB_M_PRESET_N           => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        FIC_2_APB_M_PCLK               => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PCLK,
        SDIF_RELEASED                  => GND_net, -- tied to '0' from definition
        INIT_DONE                      => INIT_DONE_net_0,
        FIC_2_APB_M_PSEL               => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx,
        FIC_2_APB_M_PENABLE            => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE,
        FIC_2_APB_M_PWRITE             => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE,
        FIC_2_APB_M_PADDR              => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0,
        FIC_2_APB_M_PWDATA             => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA,
        MDDR_PRDATA                    => CORECONFIGP_0_MDDR_APBmslave_PRDATA_0,
        MDDR_PREADY                    => CORECONFIGP_0_MDDR_APBmslave_PREADY,
        MDDR_PSLVERR                   => CORECONFIGP_0_MDDR_APBmslave_PSLVERR,
        FDDR_PRDATA                    => FDDR_PRDATA_const_net_0, -- tied to X"0" from definition
        FDDR_PREADY                    => VCC_net, -- tied to '1' from definition
        FDDR_PSLVERR                   => GND_net, -- tied to '0' from definition
        SDIF0_PRDATA                   => SDIF0_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF0_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF0_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF1_PRDATA                   => SDIF1_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF1_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF1_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF2_PRDATA                   => SDIF2_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF2_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF2_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF3_PRDATA                   => SDIF3_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF3_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF3_PSLVERR                  => GND_net, -- tied to '0' from definition
        -- Outputs
        APB_S_PCLK                     => CORECONFIGP_0_APB_S_PCLK,
        APB_S_PRESET_N                 => CORECONFIGP_0_APB_S_PRESET_N,
        CONFIG1_DONE                   => CORECONFIGP_0_CONFIG1_DONE,
        CONFIG2_DONE                   => CORECONFIGP_0_CONFIG2_DONE,
        FIC_2_APB_M_PRDATA             => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA,
        FIC_2_APB_M_PREADY             => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY,
        FIC_2_APB_M_PSLVERR            => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR,
        MDDR_PSEL                      => CORECONFIGP_0_MDDR_APBmslave_PSELx,
        MDDR_PENABLE                   => CORECONFIGP_0_MDDR_APBmslave_PENABLE,
        MDDR_PWRITE                    => CORECONFIGP_0_MDDR_APBmslave_PWRITE,
        MDDR_PADDR                     => CORECONFIGP_0_MDDR_APBmslave_PADDR,
        MDDR_PWDATA                    => CORECONFIGP_0_MDDR_APBmslave_PWDATA,
        FDDR_PSEL                      => OPEN,
        FDDR_PENABLE                   => OPEN,
        FDDR_PWRITE                    => OPEN,
        FDDR_PADDR                     => OPEN,
        FDDR_PWDATA                    => OPEN,
        SDIF0_PSEL                     => OPEN,
        SDIF0_PENABLE                  => OPEN,
        SDIF0_PWRITE                   => OPEN,
        SDIF0_PADDR                    => OPEN,
        SDIF0_PWDATA                   => OPEN,
        SDIF1_PSEL                     => OPEN,
        SDIF1_PENABLE                  => OPEN,
        SDIF1_PWRITE                   => OPEN,
        SDIF1_PADDR                    => OPEN,
        SDIF1_PWDATA                   => OPEN,
        SDIF2_PSEL                     => OPEN,
        SDIF2_PENABLE                  => OPEN,
        SDIF2_PWRITE                   => OPEN,
        SDIF2_PADDR                    => OPEN,
        SDIF2_PWDATA                   => OPEN,
        SDIF3_PSEL                     => OPEN,
        SDIF3_PENABLE                  => OPEN,
        SDIF3_PWRITE                   => OPEN,
        SDIF3_PADDR                    => OPEN,
        SDIF3_PWDATA                   => OPEN,
        SOFT_EXT_RESET_OUT             => CORECONFIGP_0_SOFT_EXT_RESET_OUT,
        SOFT_RESET_F2M                 => CORECONFIGP_0_SOFT_RESET_F2M,
        SOFT_M3_RESET                  => CORECONFIGP_0_SOFT_M3_RESET,
        SOFT_MDDR_DDR_AXI_S_CORE_RESET => CORECONFIGP_0_SOFT_MDDR_DDR_AXI_S_CORE_RESET,
        SOFT_FDDR_CORE_RESET           => OPEN,
        SOFT_SDIF0_PHY_RESET           => OPEN,
        SOFT_SDIF0_CORE_RESET          => OPEN,
        SOFT_SDIF0_0_CORE_RESET        => OPEN,
        SOFT_SDIF0_1_CORE_RESET        => OPEN,
        SOFT_SDIF1_PHY_RESET           => OPEN,
        SOFT_SDIF1_CORE_RESET          => OPEN,
        SOFT_SDIF2_PHY_RESET           => OPEN,
        SOFT_SDIF2_CORE_RESET          => OPEN,
        SOFT_SDIF3_PHY_RESET           => OPEN,
        SOFT_SDIF3_CORE_RESET          => OPEN,
        R_SDIF0_PSEL                   => OPEN,
        R_SDIF0_PWRITE                 => OPEN,
        R_SDIF0_PRDATA                 => OPEN,
        R_SDIF1_PSEL                   => OPEN,
        R_SDIF1_PWRITE                 => OPEN,
        R_SDIF1_PRDATA                 => OPEN,
        R_SDIF2_PSEL                   => OPEN,
        R_SDIF2_PWRITE                 => OPEN,
        R_SDIF2_PRDATA                 => OPEN,
        R_SDIF3_PSEL                   => OPEN,
        R_SDIF3_PWRITE                 => OPEN,
        R_SDIF3_PRDATA                 => OPEN 
        );
-- CORERESETP_0   -   Actel:DirectCore:CoreResetP:7.1.100
CORERESETP_0 : CoreResetP
    generic map( 
        DDR_WAIT            => ( 200 ),
        DEVICE_090          => ( 0 ),
        DEVICE_VOLTAGE      => ( 2 ),
        ENABLE_SOFT_RESETS  => ( 1 ),
        EXT_RESET_CFG       => ( 0 ),
        FDDR_IN_USE         => ( 0 ),
        MDDR_IN_USE         => ( 1 ),
        SDIF0_IN_USE        => ( 0 ),
        SDIF0_PCIE          => ( 0 ),
        SDIF0_PCIE_HOTRESET => ( 1 ),
        SDIF0_PCIE_L2P2     => ( 1 ),
        SDIF1_IN_USE        => ( 0 ),
        SDIF1_PCIE          => ( 0 ),
        SDIF1_PCIE_HOTRESET => ( 1 ),
        SDIF1_PCIE_L2P2     => ( 1 ),
        SDIF2_IN_USE        => ( 0 ),
        SDIF2_PCIE          => ( 0 ),
        SDIF2_PCIE_HOTRESET => ( 1 ),
        SDIF2_PCIE_L2P2     => ( 1 ),
        SDIF3_IN_USE        => ( 0 ),
        SDIF3_PCIE          => ( 0 ),
        SDIF3_PCIE_HOTRESET => ( 1 ),
        SDIF3_PCIE_L2P2     => ( 1 )
        )
    port map( 
        -- Inputs
        RESET_N_M2F                    => ddr_mss_sb_MSS_TMP_0_MSS_RESET_N_M2F,
        FIC_2_APB_M_PRESET_N           => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        POWER_ON_RESET_N               => POWER_ON_RESET_N_net_0,
        FAB_RESET_N                    => FAB_RESET_N,
        RCOSC_25_50MHZ                 => FABOSC_0_RCOSC_25_50MHZ_O2F,
        CLK_BASE                       => FIC_0_CLK_net_0,
        CLK_LTSSM                      => GND_net, -- tied to '0' from definition
        FPLL_LOCK                      => VCC_net, -- tied to '1' from definition
        SDIF0_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF1_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF2_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF3_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        CONFIG1_DONE                   => CORECONFIGP_0_CONFIG1_DONE,
        CONFIG2_DONE                   => CORECONFIGP_0_CONFIG2_DONE,
        SDIF0_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF1_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF2_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF3_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF0_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF0_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF0_PRDATA                   => SDIF0_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF1_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF1_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF1_PRDATA                   => SDIF1_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF2_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF2_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF2_PRDATA                   => SDIF2_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF3_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF3_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF3_PRDATA                   => SDIF3_PRDATA_const_net_1, -- tied to X"0" from definition
        SOFT_EXT_RESET_OUT             => CORECONFIGP_0_SOFT_EXT_RESET_OUT,
        SOFT_RESET_F2M                 => CORECONFIGP_0_SOFT_RESET_F2M,
        SOFT_M3_RESET                  => CORECONFIGP_0_SOFT_M3_RESET,
        SOFT_MDDR_DDR_AXI_S_CORE_RESET => CORECONFIGP_0_SOFT_MDDR_DDR_AXI_S_CORE_RESET,
        SOFT_FDDR_CORE_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_0_CORE_RESET        => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_1_CORE_RESET        => GND_net, -- tied to '0' from definition
        SOFT_SDIF1_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF1_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF2_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF2_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF3_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF3_CORE_RESET          => GND_net, -- tied to '0' from definition
        -- Outputs
        MSS_HPMS_READY                 => MSS_READY_net_0,
        DDR_READY                      => DDR_READY_net_0,
        SDIF_READY                     => OPEN,
        RESET_N_F2M                    => CORERESETP_0_RESET_N_F2M,
        M3_RESET_N                     => CORERESETP_0_M3_RESET_N,
        EXT_RESET_OUT                  => OPEN,
        MDDR_DDR_AXI_S_CORE_RESET_N    => OPEN,
        FDDR_CORE_RESET_N              => OPEN,
        SDIF0_CORE_RESET_N             => OPEN,
        SDIF0_0_CORE_RESET_N           => OPEN,
        SDIF0_1_CORE_RESET_N           => OPEN,
        SDIF0_PHY_RESET_N              => OPEN,
        SDIF1_CORE_RESET_N             => OPEN,
        SDIF1_PHY_RESET_N              => OPEN,
        SDIF2_CORE_RESET_N             => OPEN,
        SDIF2_PHY_RESET_N              => OPEN,
        SDIF3_CORE_RESET_N             => OPEN,
        SDIF3_PHY_RESET_N              => OPEN,
        SDIF_RELEASED                  => OPEN,
        INIT_DONE                      => INIT_DONE_net_0 
        );
-- ddr_mss_sb_MSS_0
ddr_mss_sb_MSS_0 : ddr_mss_sb_MSS
    port map( 
        -- Inputs
        MCCC_CLK_BASE          => FIC_0_CLK_net_0,
        MDDR_DQS_TMATCH_0_IN   => MDDR_DQS_TMATCH_0_IN,
        MCCC_CLK_BASE_PLL_LOCK => FIC_0_LOCK_net_0,
        MSS_RESET_N_F2M        => CORERESETP_0_RESET_N_F2M,
        FIC_0_APB_M_PREADY     => FIC_0_APB_M_PREADY,
        FIC_0_APB_M_PSLVERR    => FIC_0_APB_M_PSLVERR,
        M3_RESET_N             => CORERESETP_0_M3_RESET_N,
        MDDR_APB_S_PRESET_N    => CORECONFIGP_0_APB_S_PRESET_N,
        MDDR_APB_S_PCLK        => CORECONFIGP_0_APB_S_PCLK,
        FIC_2_APB_M_PREADY     => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY,
        FIC_2_APB_M_PSLVERR    => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR,
        MDDR_APB_S_PWRITE      => CORECONFIGP_0_MDDR_APBmslave_PWRITE,
        MDDR_APB_S_PENABLE     => CORECONFIGP_0_MDDR_APBmslave_PENABLE,
        MDDR_APB_S_PSEL        => CORECONFIGP_0_MDDR_APBmslave_PSELx,
        FIC_0_APB_M_PRDATA     => FIC_0_APB_M_PRDATA,
        FIC_2_APB_M_PRDATA     => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA,
        MDDR_APB_S_PWDATA      => CORECONFIGP_0_MDDR_APBmslave_PWDATA_0,
        MDDR_APB_S_PADDR       => CORECONFIGP_0_MDDR_APBmslave_PADDR_0,
        MSS_INT_F2M            => MSS_INT_F2M,
        -- Outputs
        MDDR_DQS_TMATCH_0_OUT  => MDDR_DQS_TMATCH_0_OUT_net_0,
        MDDR_CAS_N             => MDDR_CAS_N_net_0,
        MDDR_CLK               => MDDR_CLK_net_0,
        MDDR_CLK_N             => MDDR_CLK_N_net_0,
        MDDR_CKE               => MDDR_CKE_net_0,
        MDDR_CS_N              => MDDR_CS_N_net_0,
        MDDR_ODT               => MDDR_ODT_net_0,
        MDDR_RAS_N             => MDDR_RAS_N_net_0,
        MDDR_RESET_N           => MDDR_RESET_N_net_0,
        MDDR_WE_N              => MDDR_WE_N_net_0,
        MSS_RESET_N_M2F        => ddr_mss_sb_MSS_TMP_0_MSS_RESET_N_M2F,
        FIC_0_APB_M_PSEL       => FIC_0_APB_MASTER_2_PSELx,
        FIC_0_APB_M_PWRITE     => FIC_0_APB_MASTER_2_PWRITE,
        FIC_0_APB_M_PENABLE    => FIC_0_APB_MASTER_2_PENABLE,
        FIC_2_APB_M_PRESET_N   => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        FIC_2_APB_M_PCLK       => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_M_PCLK,
        FIC_2_APB_M_PWRITE     => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE,
        FIC_2_APB_M_PENABLE    => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE,
        FIC_2_APB_M_PSEL       => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx,
        MDDR_APB_S_PREADY      => CORECONFIGP_0_MDDR_APBmslave_PREADY,
        MDDR_APB_S_PSLVERR     => CORECONFIGP_0_MDDR_APBmslave_PSLVERR,
        MDDR_ADDR              => MDDR_ADDR_net_0,
        MDDR_BA                => MDDR_BA_net_0,
        FIC_0_APB_M_PADDR      => FIC_0_APB_MASTER_2_PADDR,
        FIC_0_APB_M_PWDATA     => FIC_0_APB_MASTER_2_PWDATA,
        FIC_2_APB_M_PADDR      => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR,
        FIC_2_APB_M_PWDATA     => ddr_mss_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA,
        MDDR_APB_S_PRDATA      => CORECONFIGP_0_MDDR_APBmslave_PRDATA,
        -- Inouts
        MDDR_DM_RDQS           => MDDR_DM_RDQS,
        MDDR_DQ                => MDDR_DQ,
        MDDR_DQS               => MDDR_DQS,
        MDDR_DQS_N             => MDDR_DQS_N 
        );
-- FABOSC_0   -   Actel:SgCore:OSC:2.0.101
FABOSC_0 : ddr_mss_sb_FABOSC_0_OSC
    port map( 
        -- Inputs
        XTL                => XTL,
        -- Outputs
        RCOSC_25_50MHZ_CCC => OPEN,
        RCOSC_25_50MHZ_O2F => FABOSC_0_RCOSC_25_50MHZ_O2F,
        RCOSC_1MHZ_CCC     => OPEN,
        RCOSC_1MHZ_O2F     => OPEN,
        XTLOSC_CCC         => OPEN,
        XTLOSC_O2F         => OPEN 
        );
-- SYSRESET_POR
SYSRESET_POR : SYSRESET
    port map( 
        -- Inputs
        DEVRST_N         => DEVRST_N,
        -- Outputs
        POWER_ON_RESET_N => POWER_ON_RESET_N_net_0 
        );

end RTL;
