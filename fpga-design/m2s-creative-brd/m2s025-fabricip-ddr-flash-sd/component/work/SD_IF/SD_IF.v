//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Oct  4 17:12:10 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// SD_IF
module SD_IF(
    // Inputs
    APB_bif_PADDR,
    APB_bif_PENABLE,
    APB_bif_PSEL,
    APB_bif_PWDATA,
    APB_bif_PWRITE,
    PCLK,
    PRESETN,
    SD_SDI,
    // Outputs
    APB_bif_PRDATA,
    APB_bif_PREADY,
    APB_bif_PSLVERR,
    SD_SCLK,
    SD_SDO,
    SD_SS
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [6:0] APB_bif_PADDR;
input        APB_bif_PENABLE;
input        APB_bif_PSEL;
input  [7:0] APB_bif_PWDATA;
input        APB_bif_PWRITE;
input        PCLK;
input        PRESETN;
input        SD_SDI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0] APB_bif_PRDATA;
output       APB_bif_PREADY;
output       APB_bif_PSLVERR;
output       SD_SCLK;
output       SD_SDO;
output       SD_SS;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [6:0] APB_bif_PADDR;
wire         APB_bif_PENABLE;
wire   [7:0] APB_bif_PRDATA_net_0;
wire         APB_bif_PREADY_net_0;
wire         APB_bif_PSEL;
wire         APB_bif_PSLVERR_net_0;
wire   [7:0] APB_bif_PWDATA;
wire         APB_bif_PWRITE;
wire         PCLK;
wire         PRESETN;
wire         SD_SCLK_net_0;
wire         SD_SDI;
wire         SD_SDO_net_0;
wire   [0:0] SD_SS_net_0;
wire         SD_SCLK_net_1;
wire         SD_SDO_net_1;
wire   [7:0] APB_bif_PRDATA_net_1;
wire         APB_bif_PREADY_net_1;
wire         APB_bif_PSLVERR_net_1;
wire         SD_SS_net_1;
wire   [7:1] SPISS_slice_0;
wire   [7:0] SPISS_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         VCC_net;
wire         GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SD_SCLK_net_1         = SD_SCLK_net_0;
assign SD_SCLK               = SD_SCLK_net_1;
assign SD_SDO_net_1          = SD_SDO_net_0;
assign SD_SDO                = SD_SDO_net_1;
assign APB_bif_PRDATA_net_1  = APB_bif_PRDATA_net_0;
assign APB_bif_PRDATA[7:0]   = APB_bif_PRDATA_net_1;
assign APB_bif_PREADY_net_1  = APB_bif_PREADY_net_0;
assign APB_bif_PREADY        = APB_bif_PREADY_net_1;
assign APB_bif_PSLVERR_net_1 = APB_bif_PSLVERR_net_0;
assign APB_bif_PSLVERR       = APB_bif_PSLVERR_net_1;
assign SD_SS_net_1           = SD_SS_net_0[0];
assign SD_SS                 = SD_SS_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign SD_SS_net_0[0] = SPISS_net_0[0:0];
assign SPISS_slice_0  = SPISS_net_0[7:1];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORESPI_C1
CORESPI_C1 CORESPI_C1_0(
        // Inputs
        .PCLK       ( PCLK ),
        .PRESETN    ( PRESETN ),
        .SPISSI     ( VCC_net ),
        .SPISDI     ( SD_SDI ),
        .SPICLKI    ( GND_net ),
        .PSEL       ( APB_bif_PSEL ),
        .PENABLE    ( APB_bif_PENABLE ),
        .PWRITE     ( APB_bif_PWRITE ),
        .PADDR      ( APB_bif_PADDR ),
        .PWDATA     ( APB_bif_PWDATA ),
        // Outputs
        .SPIINT     (  ),
        .SPIRXAVAIL (  ),
        .SPITXRFM   (  ),
        .SPISCLKO   ( SD_SCLK_net_0 ),
        .SPIOEN     (  ),
        .SPISDO     ( SD_SDO_net_0 ),
        .SPIMODE    (  ),
        .PREADY     ( APB_bif_PREADY_net_0 ),
        .PSLVERR    ( APB_bif_PSLVERR_net_0 ),
        .SPISS      ( SPISS_net_0 ),
        .PRDATA     ( APB_bif_PRDATA_net_0 ) 
        );


endmodule
