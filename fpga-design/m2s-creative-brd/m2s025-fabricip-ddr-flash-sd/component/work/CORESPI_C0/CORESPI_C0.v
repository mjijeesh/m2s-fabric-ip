//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed May 10 15:20:39 2023
// Version: 2022.1 2022.1.0.10
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of CORESPI_C0 to TCL
# Family: SmartFusion2
# Part Number: M2S025-VF256
# Create and Configure the core component CORESPI_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:CORESPI:5.2.104} -component_name {CORESPI_C0} -params {\
"APB_DWIDTH:32"  \
"CFG_CLK:7"  \
"CFG_FIFO_DEPTH:32"  \
"CFG_FRAME_SIZE:8"  \
"CFG_MODE:0"  \
"CFG_MOT_MODE:3"  \
"CFG_MOT_SSEL:true"  \
"CFG_NSC_OPERATION:0"  \
"CFG_TI_JMB_FRAMES:false"  \
"CFG_TI_NSC_CUSTOM:0"  \
"CFG_TI_NSC_FRC:false"   }
# Exporting Component Description of CORESPI_C0 to TCL done
*/

// CORESPI_C0
module CORESPI_C0(
    // Inputs
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    SPICLKI,
    SPISDI,
    SPISSI,
    // Outputs
    PRDATA,
    PREADY,
    PSLVERR,
    SPIINT,
    SPIMODE,
    SPIOEN,
    SPIRXAVAIL,
    SPISCLKO,
    SPISDO,
    SPISS,
    SPITXRFM
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [6:0]  PADDR;
input         PCLK;
input         PENABLE;
input         PRESETN;
input         PSEL;
input  [31:0] PWDATA;
input         PWRITE;
input         SPICLKI;
input         SPISDI;
input         SPISSI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] PRDATA;
output        PREADY;
output        PSLVERR;
output        SPIINT;
output        SPIMODE;
output        SPIOEN;
output        SPIRXAVAIL;
output        SPISCLKO;
output        SPISDO;
output [7:0]  SPISS;
output        SPITXRFM;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [6:0]  PADDR;
wire          PENABLE;
wire   [31:0] APB_bif_PRDATA;
wire          APB_bif_PREADY;
wire          PSEL;
wire          APB_bif_PSLVERR;
wire   [31:0] PWDATA;
wire          PWRITE;
wire          PCLK;
wire          PRESETN;
wire          SPICLKI;
wire          SPIINT_net_0;
wire          SPIMODE_net_0;
wire          SPIOEN_net_0;
wire          SPIRXAVAIL_net_0;
wire          SPISCLKO_net_0;
wire          SPISDI;
wire          SPISDO_net_0;
wire   [7:0]  SPISS_net_0;
wire          SPISSI;
wire          SPITXRFM_net_0;
wire          SPIINT_net_1;
wire          SPIRXAVAIL_net_1;
wire          SPITXRFM_net_1;
wire   [7:0]  SPISS_net_1;
wire          SPISCLKO_net_1;
wire          SPIOEN_net_1;
wire          SPISDO_net_1;
wire          SPIMODE_net_1;
wire   [31:0] APB_bif_PRDATA_net_0;
wire          APB_bif_PREADY_net_0;
wire          APB_bif_PSLVERR_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SPIINT_net_1          = SPIINT_net_0;
assign SPIINT                = SPIINT_net_1;
assign SPIRXAVAIL_net_1      = SPIRXAVAIL_net_0;
assign SPIRXAVAIL            = SPIRXAVAIL_net_1;
assign SPITXRFM_net_1        = SPITXRFM_net_0;
assign SPITXRFM              = SPITXRFM_net_1;
assign SPISS_net_1           = SPISS_net_0;
assign SPISS[7:0]            = SPISS_net_1;
assign SPISCLKO_net_1        = SPISCLKO_net_0;
assign SPISCLKO              = SPISCLKO_net_1;
assign SPIOEN_net_1          = SPIOEN_net_0;
assign SPIOEN                = SPIOEN_net_1;
assign SPISDO_net_1          = SPISDO_net_0;
assign SPISDO                = SPISDO_net_1;
assign SPIMODE_net_1         = SPIMODE_net_0;
assign SPIMODE               = SPIMODE_net_1;
assign APB_bif_PRDATA_net_0  = APB_bif_PRDATA;
assign PRDATA[31:0]          = APB_bif_PRDATA_net_0;
assign APB_bif_PREADY_net_0  = APB_bif_PREADY;
assign PREADY                = APB_bif_PREADY_net_0;
assign APB_bif_PSLVERR_net_0 = APB_bif_PSLVERR;
assign PSLVERR               = APB_bif_PSLVERR_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORESPI   -   Actel:DirectCore:CORESPI:5.2.104
CORESPI #( 
        .APB_DWIDTH        ( 32 ),
        .CFG_CLK           ( 7 ),
        .CFG_FIFO_DEPTH    ( 32 ),
        .CFG_FRAME_SIZE    ( 8 ),
        .CFG_MODE          ( 0 ),
        .CFG_MOT_MODE      ( 3 ),
        .CFG_MOT_SSEL      ( 1 ),
        .CFG_NSC_OPERATION ( 0 ),
        .CFG_TI_JMB_FRAMES ( 0 ),
        .CFG_TI_NSC_CUSTOM ( 0 ),
        .CFG_TI_NSC_FRC    ( 0 ) )
CORESPI_C0_0(
        // Inputs
        .PCLK       ( PCLK ),
        .PRESETN    ( PRESETN ),
        .PADDR      ( PADDR ),
        .PSEL       ( PSEL ),
        .PENABLE    ( PENABLE ),
        .PWRITE     ( PWRITE ),
        .PWDATA     ( PWDATA ),
        .SPISSI     ( SPISSI ),
        .SPISDI     ( SPISDI ),
        .SPICLKI    ( SPICLKI ),
        // Outputs
        .PRDATA     ( APB_bif_PRDATA ),
        .PREADY     ( APB_bif_PREADY ),
        .PSLVERR    ( APB_bif_PSLVERR ),
        .SPIINT     ( SPIINT_net_0 ),
        .SPIRXAVAIL ( SPIRXAVAIL_net_0 ),
        .SPITXRFM   ( SPITXRFM_net_0 ),
        .SPISS      ( SPISS_net_0 ),
        .SPISCLKO   ( SPISCLKO_net_0 ),
        .SPIOEN     ( SPIOEN_net_0 ),
        .SPISDO     ( SPISDO_net_0 ),
        .SPIMODE    ( SPIMODE_net_0 ) 
        );


endmodule
