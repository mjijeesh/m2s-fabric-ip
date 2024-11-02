//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Oct  4 17:23:29 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// m2s_creative_ddr_top
module m2s_creative_ddr_top(
    // Inputs
    CLK0_PAD,
    DEVRST_N,
    GPIO_5_TP_IRQ,
    GPIO_9_SW3,
    MDDR_DQS_TMATCH_0_IN,
    SD_SDI,
    SPI_FLASH_SDI,
    UART_RXD,
    XTL,
    // Outputs
    GPIO_0_LED0,
    GPIO_1_LED1,
    GPIO_2_SD_CS,
    GPIO_3_TP_CS,
    GPIO_4_LCD_CS,
    GPIO_5_LCD_BL,
    GPIO_6_LCD_DC,
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
    SD_SCLK,
    SD_SDO,
    SD_SS,
    SPI_FLASH_SCLK,
    SPI_FLASH_SDO,
    SPI_FLASH_SS,
    UART_TXD,
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
input         GPIO_5_TP_IRQ;
input         GPIO_9_SW3;
input         MDDR_DQS_TMATCH_0_IN;
input         SD_SDI;
input         SPI_FLASH_SDI;
input         UART_RXD;
input         XTL;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        GPIO_0_LED0;
output        GPIO_1_LED1;
output        GPIO_2_SD_CS;
output        GPIO_3_TP_CS;
output        GPIO_4_LCD_CS;
output        GPIO_5_LCD_BL;
output        GPIO_6_LCD_DC;
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
output        SD_SCLK;
output        SD_SDO;
output        SD_SS;
output        SPI_FLASH_SCLK;
output        SPI_FLASH_SDO;
output        SPI_FLASH_SS;
output        UART_TXD;
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
wire   [0:0]  GPIO_0_LED0_net_0;
wire   [1:1]  GPIO_1_LED1_net_0;
wire   [2:2]  GPIO_2_SD_CS_net_0;
wire   [3:3]  GPIO_3_TP_CS_net_0;
wire   [4:4]  GPIO_4_LCD_CS_net_0;
wire   [5:5]  GPIO_5_LCD_BL_net_0;
wire          GPIO_5_TP_IRQ;
wire   [6:6]  GPIO_6_LCD_DC_net_0;
wire          GPIO_9_SW3;
wire   [31:0] m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR;
wire          m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE;
wire   [31:0] m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA;
wire          m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY;
wire          m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx;
wire          m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR;
wire   [31:0] m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA;
wire          m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE;
wire          m2s_creative_demo_0_FIC_0_CLK;
wire          m2s_creative_demo_0_INIT_DONE;
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
wire          SD_SCLK_net_0;
wire          SD_SDI;
wire          SD_SDO_net_0;
wire          SD_SS_net_0;
wire          SPI_FLASH_SCLK_net_0;
wire          SPI_FLASH_SDI;
wire          SPI_FLASH_SDO_net_0;
wire          SPI_FLASH_SS_net_0;
wire          UART_RXD;
wire          UART_TXD_net_0;
wire          User_Interfaces_0_TIMINT;
wire          XTL;
wire          GPIO_0_LED0_net_1;
wire          GPIO_1_LED1_net_1;
wire          GPIO_2_SD_CS_net_1;
wire          GPIO_3_TP_CS_net_1;
wire          GPIO_4_LCD_CS_net_1;
wire          GPIO_5_LCD_BL_net_1;
wire          GPIO_6_LCD_DC_net_1;
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
wire          UART_TXD_net_1;
wire   [15:0] MDDR_ADDR_net_1;
wire   [2:0]  MDDR_BA_net_1;
wire          SPI_FLASH_SDO_net_1;
wire          SPI_FLASH_SS_net_1;
wire          SD_SS_net_1;
wire          SD_SCLK_net_1;
wire          SD_SDO_net_1;
wire          SPI_FLASH_SCLK_net_1;
wire   [7:7]  GPIO_OUT_slice_0;
wire   [15:0] MSS_INT_F2M_net_0;
wire   [7:0]  GPIO_OUT_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [15:2] MSS_INT_F2M_const_net_0;
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_const_net_0 = 14'h0000;
assign GND_net                 = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign GPIO_0_LED0_net_1           = GPIO_0_LED0_net_0[0];
assign GPIO_0_LED0                 = GPIO_0_LED0_net_1;
assign GPIO_1_LED1_net_1           = GPIO_1_LED1_net_0[1];
assign GPIO_1_LED1                 = GPIO_1_LED1_net_1;
assign GPIO_2_SD_CS_net_1          = GPIO_2_SD_CS_net_0[2];
assign GPIO_2_SD_CS                = GPIO_2_SD_CS_net_1;
assign GPIO_3_TP_CS_net_1          = GPIO_3_TP_CS_net_0[3];
assign GPIO_3_TP_CS                = GPIO_3_TP_CS_net_1;
assign GPIO_4_LCD_CS_net_1         = GPIO_4_LCD_CS_net_0[4];
assign GPIO_4_LCD_CS               = GPIO_4_LCD_CS_net_1;
assign GPIO_5_LCD_BL_net_1         = GPIO_5_LCD_BL_net_0[5];
assign GPIO_5_LCD_BL               = GPIO_5_LCD_BL_net_1;
assign GPIO_6_LCD_DC_net_1         = GPIO_6_LCD_DC_net_0[6];
assign GPIO_6_LCD_DC               = GPIO_6_LCD_DC_net_1;
assign MDDR_DQS_TMATCH_0_OUT_net_1 = MDDR_DQS_TMATCH_0_OUT_net_0;
assign MDDR_DQS_TMATCH_0_OUT       = MDDR_DQS_TMATCH_0_OUT_net_1;
assign MDDR_CAS_N_net_1            = MDDR_CAS_N_net_0;
assign MDDR_CAS_N                  = MDDR_CAS_N_net_1;
assign MDDR_CLK_net_1              = MDDR_CLK_net_0;
assign MDDR_CLK                    = MDDR_CLK_net_1;
assign MDDR_CLK_N_net_1            = MDDR_CLK_N_net_0;
assign MDDR_CLK_N                  = MDDR_CLK_N_net_1;
assign MDDR_CKE_net_1              = MDDR_CKE_net_0;
assign MDDR_CKE                    = MDDR_CKE_net_1;
assign MDDR_CS_N_net_1             = MDDR_CS_N_net_0;
assign MDDR_CS_N                   = MDDR_CS_N_net_1;
assign MDDR_ODT_net_1              = MDDR_ODT_net_0;
assign MDDR_ODT                    = MDDR_ODT_net_1;
assign MDDR_RAS_N_net_1            = MDDR_RAS_N_net_0;
assign MDDR_RAS_N                  = MDDR_RAS_N_net_1;
assign MDDR_RESET_N_net_1          = MDDR_RESET_N_net_0;
assign MDDR_RESET_N                = MDDR_RESET_N_net_1;
assign MDDR_WE_N_net_1             = MDDR_WE_N_net_0;
assign MDDR_WE_N                   = MDDR_WE_N_net_1;
assign UART_TXD_net_1              = UART_TXD_net_0;
assign UART_TXD                    = UART_TXD_net_1;
assign MDDR_ADDR_net_1             = MDDR_ADDR_net_0;
assign MDDR_ADDR[15:0]             = MDDR_ADDR_net_1;
assign MDDR_BA_net_1               = MDDR_BA_net_0;
assign MDDR_BA[2:0]                = MDDR_BA_net_1;
assign SPI_FLASH_SDO_net_1         = SPI_FLASH_SDO_net_0;
assign SPI_FLASH_SDO               = SPI_FLASH_SDO_net_1;
assign SPI_FLASH_SS_net_1          = SPI_FLASH_SS_net_0;
assign SPI_FLASH_SS                = SPI_FLASH_SS_net_1;
assign SD_SS_net_1                 = SD_SS_net_0;
assign SD_SS                       = SD_SS_net_1;
assign SD_SCLK_net_1               = SD_SCLK_net_0;
assign SD_SCLK                     = SD_SCLK_net_1;
assign SD_SDO_net_1                = SD_SDO_net_0;
assign SD_SDO                      = SD_SDO_net_1;
assign SPI_FLASH_SCLK_net_1        = SPI_FLASH_SCLK_net_0;
assign SPI_FLASH_SCLK              = SPI_FLASH_SCLK_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign GPIO_0_LED0_net_0[0]   = GPIO_OUT_net_0[0:0];
assign GPIO_1_LED1_net_0[1]   = GPIO_OUT_net_0[1:1];
assign GPIO_2_SD_CS_net_0[2]  = GPIO_OUT_net_0[2:2];
assign GPIO_3_TP_CS_net_0[3]  = GPIO_OUT_net_0[3:3];
assign GPIO_4_LCD_CS_net_0[4] = GPIO_OUT_net_0[4:4];
assign GPIO_5_LCD_BL_net_0[5] = GPIO_OUT_net_0[5:5];
assign GPIO_6_LCD_DC_net_0[6] = GPIO_OUT_net_0[6:6];
assign GPIO_OUT_slice_0[7]    = GPIO_OUT_net_0[7:7];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { 14'h0000 , 1'b0 , User_Interfaces_0_TIMINT };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------ddr_mss
ddr_mss m2s_creative_demo_0(
        // Inputs
        .MDDR_DQS_TMATCH_0_IN                  ( MDDR_DQS_TMATCH_0_IN ),
        .CLK0_PAD                              ( CLK0_PAD ),
        .DEVRST_N                              ( DEVRST_N ),
        .XTL                                   ( XTL ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PREADY  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PSLVERR ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR ),
        .MSS_INT_F2M                           ( MSS_INT_F2M_net_0 ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PRDATA  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA ),
        // Outputs
        .MDDR_DQS_TMATCH_0_OUT                 ( MDDR_DQS_TMATCH_0_OUT_net_0 ),
        .MDDR_CAS_N                            ( MDDR_CAS_N_net_0 ),
        .MDDR_CLK                              ( MDDR_CLK_net_0 ),
        .MDDR_CLK_N                            ( MDDR_CLK_N_net_0 ),
        .MDDR_CKE                              ( MDDR_CKE_net_0 ),
        .MDDR_CS_N                             ( MDDR_CS_N_net_0 ),
        .MDDR_ODT                              ( MDDR_ODT_net_0 ),
        .MDDR_RAS_N                            ( MDDR_RAS_N_net_0 ),
        .MDDR_RESET_N                          ( MDDR_RESET_N_net_0 ),
        .MDDR_WE_N                             ( MDDR_WE_N_net_0 ),
        .INIT_DONE                             ( m2s_creative_demo_0_INIT_DONE ),
        .FIC_0_CLK                             ( m2s_creative_demo_0_FIC_0_CLK ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PSEL    ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PENABLE ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PWRITE  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE ),
        .MDDR_ADDR                             ( MDDR_ADDR_net_0 ),
        .MDDR_BA                               ( MDDR_BA_net_0 ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PADDR   ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR ),
        .FIC_0_AMBA_MASTER_FIC_0_APB_M_PWDATA  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA ),
        // Inouts
        .MDDR_DM_RDQS                          ( MDDR_DM_RDQS ),
        .MDDR_DQ                               ( MDDR_DQ ),
        .MDDR_DQS                              ( MDDR_DQS ),
        .MDDR_DQS_N                            ( MDDR_DQS_N ) 
        );

//--------User_Interfaces
User_Interfaces User_Interfaces_0(
        // Inputs
        .APB3mmaster_PSEL    ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSELx ),
        .APB3mmaster_PENABLE ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PENABLE ),
        .APB3mmaster_PWRITE  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWRITE ),
        .PCLK                ( m2s_creative_demo_0_FIC_0_CLK ),
        .PRESETN             ( m2s_creative_demo_0_INIT_DONE ),
        .RX                  ( UART_RXD ),
        .GPIO_IN_9           ( GPIO_9_SW3 ),
        .GPIO_IN_8           ( GPIO_5_TP_IRQ ),
        .APB3mmaster_PADDR   ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PADDR ),
        .APB3mmaster_PWDATA  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PWDATA ),
        .SPI_FLASH_SDI       ( SPI_FLASH_SDI ),
        .SD_SDI              ( SD_SDI ),
        // Outputs
        .APB3mmaster_PREADY  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PREADY ),
        .APB3mmaster_PSLVERR ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PSLVERR ),
        .TX                  ( UART_TXD_net_0 ),
        .TIMINT              ( User_Interfaces_0_TIMINT ),
        .APB3mmaster_PRDATA  ( m2s_creative_demo_0_FIC_0_AMBA_MASTER_PRDATA ),
        .GPIO_OUT            ( GPIO_OUT_net_0 ),
        .SPI_FLASH_SDO       ( SPI_FLASH_SDO_net_0 ),
        .SPI_FLASH_SS        ( SPI_FLASH_SS_net_0 ),
        .SD_SS               ( SD_SS_net_0 ),
        .SD_SCLK             ( SD_SCLK_net_0 ),
        .SD_SDO              ( SD_SDO_net_0 ),
        .SPI_FLASH_SCLK      ( SPI_FLASH_SCLK_net_0 ) 
        );


endmodule
