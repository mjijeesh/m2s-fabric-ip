//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Oct  4 17:22:49 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// spi_flash
module spi_flash(
    // Inputs
    APB_bif_PADDR,
    APB_bif_PENABLE,
    APB_bif_PSEL,
    APB_bif_PWDATA,
    APB_bif_PWRITE,
    PCLK,
    PRESETN,
    SPI_FLASH_SDI,
    // Outputs
    APB_bif_PRDATA,
    APB_bif_PREADY,
    APB_bif_PSLVERR,
    SPI_FLASH_SCLK,
    SPI_FLASH_SDO,
    SPI_FLASH_SS
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [6:0]  APB_bif_PADDR;
input         APB_bif_PENABLE;
input         APB_bif_PSEL;
input  [31:0] APB_bif_PWDATA;
input         APB_bif_PWRITE;
input         PCLK;
input         PRESETN;
input         SPI_FLASH_SDI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_bif_PRDATA;
output        APB_bif_PREADY;
output        APB_bif_PSLVERR;
output        SPI_FLASH_SCLK;
output        SPI_FLASH_SDO;
output        SPI_FLASH_SS;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [6:0]  APB_bif_PADDR;
wire          APB_bif_PENABLE;
wire   [31:0] APB_bif_PRDATA_net_0;
wire          APB_bif_PREADY_net_0;
wire          APB_bif_PSEL;
wire          APB_bif_PSLVERR_net_0;
wire   [31:0] APB_bif_PWDATA;
wire          APB_bif_PWRITE;
wire          PCLK;
wire          PRESETN;
wire          SPI_FLASH_SCLK_net_0;
wire          SPI_FLASH_SDI;
wire          SPI_FLASH_SDO_net_0;
wire   [0:0]  SPI_FLASH_SS_net_0;
wire          SPI_FLASH_SDO_net_1;
wire          SPI_FLASH_SCLK_net_1;
wire          SPI_FLASH_SS_net_1;
wire   [31:0] APB_bif_PRDATA_net_1;
wire          APB_bif_PREADY_net_1;
wire          APB_bif_PSLVERR_net_1;
wire   [7:0]  SPISS_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SPI_FLASH_SDO_net_1   = SPI_FLASH_SDO_net_0;
assign SPI_FLASH_SDO         = SPI_FLASH_SDO_net_1;
assign SPI_FLASH_SCLK_net_1  = SPI_FLASH_SCLK_net_0;
assign SPI_FLASH_SCLK        = SPI_FLASH_SCLK_net_1;
assign SPI_FLASH_SS_net_1    = SPI_FLASH_SS_net_0[0];
assign SPI_FLASH_SS          = SPI_FLASH_SS_net_1;
assign APB_bif_PRDATA_net_1  = APB_bif_PRDATA_net_0;
assign APB_bif_PRDATA[31:0]  = APB_bif_PRDATA_net_1;
assign APB_bif_PREADY_net_1  = APB_bif_PREADY_net_0;
assign APB_bif_PREADY        = APB_bif_PREADY_net_1;
assign APB_bif_PSLVERR_net_1 = APB_bif_PSLVERR_net_0;
assign APB_bif_PSLVERR       = APB_bif_PSLVERR_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign SPI_FLASH_SS_net_0[0] = SPISS_net_0[0:0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORESPI_C0
CORESPI_C0 CORESPI_C0_0(
        // Inputs
        .PCLK       ( PCLK ),
        .PRESETN    ( PRESETN ),
        .SPISSI     ( VCC_net ),
        .SPISDI     ( SPI_FLASH_SDI ),
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
        .SPISCLKO   ( SPI_FLASH_SCLK_net_0 ),
        .SPIOEN     (  ),
        .SPISDO     ( SPI_FLASH_SDO_net_0 ),
        .SPIMODE    (  ),
        .PREADY     ( APB_bif_PREADY_net_0 ),
        .PSLVERR    ( APB_bif_PSLVERR_net_0 ),
        .SPISS      ( SPISS_net_0 ),
        .PRDATA     ( APB_bif_PRDATA_net_0 ) 
        );


endmodule
