//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue May 23 14:04:39 2023
// Version: 2022.1 2022.1.0.10
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// ddr_mss
module ddr_mss(
    // Inputs
    CLK0_PAD,
    DEVRST_N,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR,
    MDDR_DQS_TMATCH_0_IN,
    MSS_INT_F2M,
    XTL,
    // Outputs
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA,
    FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE,
    FIC_0_CLK,
    INIT_DONE,
    MDDR_ADDR,
    MDDR_BA,
    MDDR_CAS_N,
    MDDR_CKE,
    MDDR_CLK,
    MDDR_CLK_N,
    MDDR_CS_N,
    MDDR_DQS_TMATCH_0_OUT,
    MDDR_ODT,
    MDDR_RAS_N,
    MDDR_RESET_N,
    MDDR_WE_N,
    // Inouts
    MDDR_DM_RDQS,
    MDDR_DQ,
    MDDR_DQS,
    MDDR_DQS_N
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         CLK0_PAD;
input         DEVRST_N;
input  [31:0] FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA;
input         FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY;
input         FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR;
input         MDDR_DQS_TMATCH_0_IN;
input  [15:0] MSS_INT_F2M;
input         XTL;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR;
output        FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE;
output        FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL;
output [31:0] FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA;
output        FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE;
output        FIC_0_CLK;
output        INIT_DONE;
output [15:0] MDDR_ADDR;
output [2:0]  MDDR_BA;
output        MDDR_CAS_N;
output        MDDR_CKE;
output        MDDR_CLK;
output        MDDR_CLK_N;
output        MDDR_CS_N;
output        MDDR_DQS_TMATCH_0_OUT;
output        MDDR_ODT;
output        MDDR_RAS_N;
output        MDDR_RESET_N;
output        MDDR_WE_N;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [1:0]  MDDR_DM_RDQS;
inout  [15:0] MDDR_DQ;
inout  [1:0]  MDDR_DQS;
inout  [1:0]  MDDR_DQS_N;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CLK0_PAD;
wire          DEVRST_N;
wire   [31:0] FIC_0_AMBA_MASTER_PADDR;
wire          FIC_0_AMBA_MASTER_PENABLE;
wire   [31:0] FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA;
wire          FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY;
wire          FIC_0_AMBA_MASTER_PSELx;
wire          FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR;
wire   [31:0] FIC_0_AMBA_MASTER_PWDATA;
wire          FIC_0_AMBA_MASTER_PWRITE;
wire          FIC_0_CLK_net_0;
wire          INIT_DONE_net_0;
wire   [15:0] MDDR_ADDR_net_0;
wire   [2:0]  MDDR_BA_net_0;
wire          MDDR_CAS_N_net_0;
wire          MDDR_CKE_net_0;
wire          MDDR_CLK_net_0;
wire          MDDR_CLK_N_net_0;
wire          MDDR_CS_N_net_0;
wire   [1:0]  MDDR_DM_RDQS;
wire   [15:0] MDDR_DQ;
wire   [1:0]  MDDR_DQS;
wire   [1:0]  MDDR_DQS_N;
wire          MDDR_DQS_TMATCH_0_IN;
wire          MDDR_DQS_TMATCH_0_OUT_net_0;
wire          MDDR_ODT_net_0;
wire          MDDR_RAS_N_net_0;
wire          MDDR_RESET_N_net_0;
wire          MDDR_WE_N_net_0;
wire   [15:0] MSS_INT_F2M;
wire          XTL;
wire          MDDR_DQS_TMATCH_0_OUT_net_1;
wire          MDDR_CAS_N_net_1;
wire          MDDR_CLK_net_1;
wire          MDDR_CLK_N_net_1;
wire          MDDR_CKE_net_1;
wire          MDDR_CS_N_net_1;
wire          MDDR_ODT_net_1;
wire          MDDR_RAS_N_net_1;
wire          MDDR_RESET_N_net_1;
wire          MDDR_WE_N_net_1;
wire          INIT_DONE_net_1;
wire          FIC_0_CLK_net_1;
wire   [15:0] MDDR_ADDR_net_1;
wire   [2:0]  MDDR_BA_net_1;
wire   [31:0] FIC_0_AMBA_MASTER_PADDR_net_0;
wire          FIC_0_AMBA_MASTER_PSELx_net_0;
wire          FIC_0_AMBA_MASTER_PENABLE_net_0;
wire          FIC_0_AMBA_MASTER_PWRITE_net_0;
wire   [31:0] FIC_0_AMBA_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign MDDR_DQS_TMATCH_0_OUT_net_1                = MDDR_DQS_TMATCH_0_OUT_net_0;
assign MDDR_DQS_TMATCH_0_OUT                      = MDDR_DQS_TMATCH_0_OUT_net_1;
assign MDDR_CAS_N_net_1                           = MDDR_CAS_N_net_0;
assign MDDR_CAS_N                                 = MDDR_CAS_N_net_1;
assign MDDR_CLK_net_1                             = MDDR_CLK_net_0;
assign MDDR_CLK                                   = MDDR_CLK_net_1;
assign MDDR_CLK_N_net_1                           = MDDR_CLK_N_net_0;
assign MDDR_CLK_N                                 = MDDR_CLK_N_net_1;
assign MDDR_CKE_net_1                             = MDDR_CKE_net_0;
assign MDDR_CKE                                   = MDDR_CKE_net_1;
assign MDDR_CS_N_net_1                            = MDDR_CS_N_net_0;
assign MDDR_CS_N                                  = MDDR_CS_N_net_1;
assign MDDR_ODT_net_1                             = MDDR_ODT_net_0;
assign MDDR_ODT                                   = MDDR_ODT_net_1;
assign MDDR_RAS_N_net_1                           = MDDR_RAS_N_net_0;
assign MDDR_RAS_N                                 = MDDR_RAS_N_net_1;
assign MDDR_RESET_N_net_1                         = MDDR_RESET_N_net_0;
assign MDDR_RESET_N                               = MDDR_RESET_N_net_1;
assign MDDR_WE_N_net_1                            = MDDR_WE_N_net_0;
assign MDDR_WE_N                                  = MDDR_WE_N_net_1;
assign INIT_DONE_net_1                            = INIT_DONE_net_0;
assign INIT_DONE                                  = INIT_DONE_net_1;
assign FIC_0_CLK_net_1                            = FIC_0_CLK_net_0;
assign FIC_0_CLK                                  = FIC_0_CLK_net_1;
assign MDDR_ADDR_net_1                            = MDDR_ADDR_net_0;
assign MDDR_ADDR[15:0]                            = MDDR_ADDR_net_1;
assign MDDR_BA_net_1                              = MDDR_BA_net_0;
assign MDDR_BA[2:0]                               = MDDR_BA_net_1;
assign FIC_0_AMBA_MASTER_PADDR_net_0              = FIC_0_AMBA_MASTER_PADDR;
assign FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR[31:0]  = FIC_0_AMBA_MASTER_PADDR_net_0;
assign FIC_0_AMBA_MASTER_PSELx_net_0              = FIC_0_AMBA_MASTER_PSELx;
assign FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL         = FIC_0_AMBA_MASTER_PSELx_net_0;
assign FIC_0_AMBA_MASTER_PENABLE_net_0            = FIC_0_AMBA_MASTER_PENABLE;
assign FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE      = FIC_0_AMBA_MASTER_PENABLE_net_0;
assign FIC_0_AMBA_MASTER_PWRITE_net_0             = FIC_0_AMBA_MASTER_PWRITE;
assign FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE       = FIC_0_AMBA_MASTER_PWRITE_net_0;
assign FIC_0_AMBA_MASTER_PWDATA_net_0             = FIC_0_AMBA_MASTER_PWDATA;
assign FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA[31:0] = FIC_0_AMBA_MASTER_PWDATA_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------ddr_mss_sb
ddr_mss_sb ddr_mss_sb_0(
        // Inputs
        .MDDR_DQS_TMATCH_0_IN  ( MDDR_DQS_TMATCH_0_IN ),
        .FAB_RESET_N           ( VCC_net ),
        .CLK0_PAD              ( CLK0_PAD ),
        .XTL                   ( XTL ),
        .DEVRST_N              ( DEVRST_N ),
        .MSS_INT_F2M           ( MSS_INT_F2M ),
        .FIC_0_APB_M_PRDATA    ( FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA ),
        .FIC_0_APB_M_PREADY    ( FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY ),
        .FIC_0_APB_M_PSLVERR   ( FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR ),
        // Outputs
        .MDDR_DQS_TMATCH_0_OUT ( MDDR_DQS_TMATCH_0_OUT_net_0 ),
        .MDDR_CAS_N            ( MDDR_CAS_N_net_0 ),
        .MDDR_CLK              ( MDDR_CLK_net_0 ),
        .MDDR_CLK_N            ( MDDR_CLK_N_net_0 ),
        .MDDR_CKE              ( MDDR_CKE_net_0 ),
        .MDDR_CS_N             ( MDDR_CS_N_net_0 ),
        .MDDR_ODT              ( MDDR_ODT_net_0 ),
        .MDDR_RAS_N            ( MDDR_RAS_N_net_0 ),
        .MDDR_RESET_N          ( MDDR_RESET_N_net_0 ),
        .MDDR_WE_N             ( MDDR_WE_N_net_0 ),
        .MDDR_ADDR             ( MDDR_ADDR_net_0 ),
        .MDDR_BA               ( MDDR_BA_net_0 ),
        .POWER_ON_RESET_N      (  ),
        .INIT_DONE             ( INIT_DONE_net_0 ),
        .FIC_0_CLK             ( FIC_0_CLK_net_0 ),
        .FIC_0_LOCK            (  ),
        .DDR_READY             (  ),
        .FAB_CCC_GL2           (  ),
        .FAB_CCC_LOCK          (  ),
        .MSS_READY             (  ),
        .FIC_0_APB_M_PADDR     ( FIC_0_AMBA_MASTER_PADDR ),
        .FIC_0_APB_M_PSEL      ( FIC_0_AMBA_MASTER_PSELx ),
        .FIC_0_APB_M_PENABLE   ( FIC_0_AMBA_MASTER_PENABLE ),
        .FIC_0_APB_M_PWRITE    ( FIC_0_AMBA_MASTER_PWRITE ),
        .FIC_0_APB_M_PWDATA    ( FIC_0_AMBA_MASTER_PWDATA ),
        // Inouts
        .MDDR_DM_RDQS          ( MDDR_DM_RDQS ),
        .MDDR_DQ               ( MDDR_DQ ),
        .MDDR_DQS              ( MDDR_DQS ),
        .MDDR_DQS_N            ( MDDR_DQS_N ) 
        );


endmodule
