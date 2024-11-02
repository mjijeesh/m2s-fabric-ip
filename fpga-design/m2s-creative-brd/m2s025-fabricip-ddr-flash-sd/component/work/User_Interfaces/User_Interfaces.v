//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Oct  4 17:23:06 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// User_Interfaces
module User_Interfaces(
    // Inputs
    APB3mmaster_PADDR,
    APB3mmaster_PENABLE,
    APB3mmaster_PSEL,
    APB3mmaster_PWDATA,
    APB3mmaster_PWRITE,
    GPIO_IN_8,
    GPIO_IN_9,
    PCLK,
    PRESETN,
    RX,
    SD_SDI,
    SPI_FLASH_SDI,
    // Outputs
    APB3mmaster_PRDATA,
    APB3mmaster_PREADY,
    APB3mmaster_PSLVERR,
    GPIO_OUT,
    SD_SCLK,
    SD_SDO,
    SD_SS,
    SPI_FLASH_SCLK,
    SPI_FLASH_SDO,
    SPI_FLASH_SS,
    TIMINT,
    TX
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB3mmaster_PADDR;
input         APB3mmaster_PENABLE;
input         APB3mmaster_PSEL;
input  [31:0] APB3mmaster_PWDATA;
input         APB3mmaster_PWRITE;
input         GPIO_IN_8;
input         GPIO_IN_9;
input         PCLK;
input         PRESETN;
input         RX;
input         SD_SDI;
input         SPI_FLASH_SDI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB3mmaster_PRDATA;
output        APB3mmaster_PREADY;
output        APB3mmaster_PSLVERR;
output [7:0]  GPIO_OUT;
output        SD_SCLK;
output        SD_SDO;
output        SD_SS;
output        SPI_FLASH_SCLK;
output        SPI_FLASH_SDO;
output        SPI_FLASH_SS;
output        TIMINT;
output        TX;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB3mmaster_PADDR;
wire          APB3mmaster_PENABLE;
wire   [31:0] APB3mmaster_PRDATA_net_0;
wire          APB3mmaster_PREADY_net_0;
wire          APB3mmaster_PSEL;
wire          APB3mmaster_PSLVERR_net_0;
wire   [31:0] APB3mmaster_PWDATA;
wire          APB3mmaster_PWRITE;
wire          CoreAPB3_C0_0_APBmslave1_PENABLE;
wire          CoreAPB3_C0_0_APBmslave1_PREADY;
wire          CoreAPB3_C0_0_APBmslave1_PSELx;
wire          CoreAPB3_C0_0_APBmslave1_PSLVERR;
wire          CoreAPB3_C0_0_APBmslave1_PWRITE;
wire   [31:0] CoreAPB3_C0_0_APBmslave2_PRDATA;
wire          CoreAPB3_C0_0_APBmslave2_PREADY;
wire          CoreAPB3_C0_0_APBmslave2_PSELx;
wire          CoreAPB3_C0_0_APBmslave2_PSLVERR;
wire   [31:0] CoreAPB3_C0_0_APBmslave3_PRDATA;
wire          CoreAPB3_C0_0_APBmslave3_PSELx;
wire          CoreAPB3_C0_0_APBmslave5_PREADY;
wire          CoreAPB3_C0_0_APBmslave5_PSELx;
wire          CoreAPB3_C0_0_APBmslave5_PSLVERR;
wire   [31:0] CoreAPB3_C0_0_APBmslave6_PRDATA;
wire          CoreAPB3_C0_0_APBmslave6_PREADY;
wire          CoreAPB3_C0_0_APBmslave6_PSELx;
wire          CoreAPB3_C0_0_APBmslave6_PSLVERR;
wire          GPIO_IN_8;
wire          GPIO_IN_9;
wire   [9:0]  GPIO_OUT_0;
wire   [7:0]  GPIO_OUT_1;
wire          PCLK;
wire          PRESETN;
wire          RX;
wire          SD_SCLK_net_0;
wire          SD_SDI;
wire          SD_SDO_net_0;
wire          SD_SS_net_0;
wire          SPI_FLASH_SCLK_net_0;
wire          SPI_FLASH_SDI;
wire          SPI_FLASH_SDO_net_0;
wire          SPI_FLASH_SS_net_0;
wire          TIMINT_net_0;
wire          TX_net_0;
wire          APB3mmaster_PREADY_net_1;
wire          APB3mmaster_PSLVERR_net_1;
wire          TX_net_1;
wire          TIMINT_net_1;
wire   [31:0] APB3mmaster_PRDATA_net_1;
wire   [7:0]  GPIO_OUT_1_net_0;
wire          SPI_FLASH_SDO_net_1;
wire          SPI_FLASH_SS_net_1;
wire          SD_SS_net_1;
wire          SD_SCLK_net_1;
wire          SD_SDO_net_1;
wire          SPI_FLASH_SCLK_net_1;
wire   [9:8]  GPIO_OUT_slice_0;
wire   [9:0]  GPIO_IN_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]  GPIO_IN_const_net_0;
wire          VCC_net;
wire          GND_net;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] CoreAPB3_C0_0_APBmslave1_PADDR;
wire   [4:0]  CoreAPB3_C0_0_APBmslave1_PADDR_0;
wire   [4:0]  CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PADDR_1;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PADDR_1_7to0;
wire   [4:2]  CoreAPB3_C0_0_APBmslave1_PADDR_2;
wire   [4:2]  CoreAPB3_C0_0_APBmslave1_PADDR_2_4to2;
wire   [6:0]  CoreAPB3_C0_0_APBmslave1_PADDR_3;
wire   [6:0]  CoreAPB3_C0_0_APBmslave1_PADDR_3_6to0;
wire   [6:0]  CoreAPB3_C0_0_APBmslave1_PADDR_4;
wire   [6:0]  CoreAPB3_C0_0_APBmslave1_PADDR_4_6to0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PRDATA;
wire   [31:0] CoreAPB3_C0_0_APBmslave1_PRDATA_0;
wire   [31:8] CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0;
wire   [31:0] CoreAPB3_C0_0_APBmslave1_PWDATA;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PWDATA_0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PWDATA_1;
wire   [7:0]  CoreAPB3_C0_0_APBmslave1_PWDATA_1_7to0;
wire   [7:0]  CoreAPB3_C0_0_APBmslave5_PRDATA;
wire   [31:0] CoreAPB3_C0_0_APBmslave5_PRDATA_0;
wire   [31:8] CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8;
wire   [7:0]  CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GPIO_IN_const_net_0 = 8'h00;
assign VCC_net             = 1'b1;
assign GND_net             = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB3mmaster_PREADY_net_1  = APB3mmaster_PREADY_net_0;
assign APB3mmaster_PREADY        = APB3mmaster_PREADY_net_1;
assign APB3mmaster_PSLVERR_net_1 = APB3mmaster_PSLVERR_net_0;
assign APB3mmaster_PSLVERR       = APB3mmaster_PSLVERR_net_1;
assign TX_net_1                  = TX_net_0;
assign TX                        = TX_net_1;
assign TIMINT_net_1              = TIMINT_net_0;
assign TIMINT                    = TIMINT_net_1;
assign APB3mmaster_PRDATA_net_1  = APB3mmaster_PRDATA_net_0;
assign APB3mmaster_PRDATA[31:0]  = APB3mmaster_PRDATA_net_1;
assign GPIO_OUT_1_net_0          = GPIO_OUT_1;
assign GPIO_OUT[7:0]             = GPIO_OUT_1_net_0;
assign SPI_FLASH_SDO_net_1       = SPI_FLASH_SDO_net_0;
assign SPI_FLASH_SDO             = SPI_FLASH_SDO_net_1;
assign SPI_FLASH_SS_net_1        = SPI_FLASH_SS_net_0;
assign SPI_FLASH_SS              = SPI_FLASH_SS_net_1;
assign SD_SS_net_1               = SD_SS_net_0;
assign SD_SS                     = SD_SS_net_1;
assign SD_SCLK_net_1             = SD_SCLK_net_0;
assign SD_SCLK                   = SD_SCLK_net_1;
assign SD_SDO_net_1              = SD_SDO_net_0;
assign SD_SDO                    = SD_SDO_net_1;
assign SPI_FLASH_SCLK_net_1      = SPI_FLASH_SCLK_net_0;
assign SPI_FLASH_SCLK            = SPI_FLASH_SCLK_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign GPIO_OUT_1       = GPIO_OUT_0[7:0];
assign GPIO_OUT_slice_0 = GPIO_OUT_0[9:8];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign GPIO_IN_net_0 = { GPIO_IN_9 , GPIO_IN_8 , 8'h00 };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign CoreAPB3_C0_0_APBmslave1_PADDR_0 = { CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0 };
assign CoreAPB3_C0_0_APBmslave1_PADDR_0_4to0 = CoreAPB3_C0_0_APBmslave1_PADDR[4:0];
assign CoreAPB3_C0_0_APBmslave1_PADDR_1 = { CoreAPB3_C0_0_APBmslave1_PADDR_1_7to0 };
assign CoreAPB3_C0_0_APBmslave1_PADDR_1_7to0 = CoreAPB3_C0_0_APBmslave1_PADDR[7:0];
assign CoreAPB3_C0_0_APBmslave1_PADDR_2 = { CoreAPB3_C0_0_APBmslave1_PADDR_2_4to2 };
assign CoreAPB3_C0_0_APBmslave1_PADDR_2_4to2 = CoreAPB3_C0_0_APBmslave1_PADDR[4:2];
assign CoreAPB3_C0_0_APBmslave1_PADDR_3 = { CoreAPB3_C0_0_APBmslave1_PADDR_3_6to0 };
assign CoreAPB3_C0_0_APBmslave1_PADDR_3_6to0 = CoreAPB3_C0_0_APBmslave1_PADDR[6:0];
assign CoreAPB3_C0_0_APBmslave1_PADDR_4 = { CoreAPB3_C0_0_APBmslave1_PADDR_4_6to0 };
assign CoreAPB3_C0_0_APBmslave1_PADDR_4_6to0 = CoreAPB3_C0_0_APBmslave1_PADDR[6:0];

assign CoreAPB3_C0_0_APBmslave1_PRDATA_0 = { CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8, CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0 };
assign CoreAPB3_C0_0_APBmslave1_PRDATA_0_31to8 = 24'h0;
assign CoreAPB3_C0_0_APBmslave1_PRDATA_0_7to0 = CoreAPB3_C0_0_APBmslave1_PRDATA[7:0];

assign CoreAPB3_C0_0_APBmslave1_PWDATA_0 = { CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0 };
assign CoreAPB3_C0_0_APBmslave1_PWDATA_0_7to0 = CoreAPB3_C0_0_APBmslave1_PWDATA[7:0];
assign CoreAPB3_C0_0_APBmslave1_PWDATA_1 = { CoreAPB3_C0_0_APBmslave1_PWDATA_1_7to0 };
assign CoreAPB3_C0_0_APBmslave1_PWDATA_1_7to0 = CoreAPB3_C0_0_APBmslave1_PWDATA[7:0];

assign CoreAPB3_C0_0_APBmslave5_PRDATA_0 = { CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8, CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0 };
assign CoreAPB3_C0_0_APBmslave5_PRDATA_0_31to8 = 24'h0;
assign CoreAPB3_C0_0_APBmslave5_PRDATA_0_7to0 = CoreAPB3_C0_0_APBmslave5_PRDATA[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAPB3_C0
CoreAPB3_C0 CoreAPB3_C0_0(
        // Inputs
        .PSEL      ( APB3mmaster_PSEL ),
        .PENABLE   ( APB3mmaster_PENABLE ),
        .PWRITE    ( APB3mmaster_PWRITE ),
        .PREADYS1  ( CoreAPB3_C0_0_APBmslave1_PREADY ),
        .PSLVERRS1 ( CoreAPB3_C0_0_APBmslave1_PSLVERR ),
        .PREADYS2  ( CoreAPB3_C0_0_APBmslave2_PREADY ),
        .PSLVERRS2 ( CoreAPB3_C0_0_APBmslave2_PSLVERR ),
        .PREADYS3  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS3 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS5  ( CoreAPB3_C0_0_APBmslave5_PREADY ),
        .PSLVERRS5 ( CoreAPB3_C0_0_APBmslave5_PSLVERR ),
        .PREADYS6  ( CoreAPB3_C0_0_APBmslave6_PREADY ),
        .PSLVERRS6 ( CoreAPB3_C0_0_APBmslave6_PSLVERR ),
        .PADDR     ( APB3mmaster_PADDR ),
        .PWDATA    ( APB3mmaster_PWDATA ),
        .PRDATAS1  ( CoreAPB3_C0_0_APBmslave1_PRDATA_0 ),
        .PRDATAS2  ( CoreAPB3_C0_0_APBmslave2_PRDATA ),
        .PRDATAS3  ( CoreAPB3_C0_0_APBmslave3_PRDATA ),
        .PRDATAS5  ( CoreAPB3_C0_0_APBmslave5_PRDATA_0 ),
        .PRDATAS6  ( CoreAPB3_C0_0_APBmslave6_PRDATA ),
        // Outputs
        .PREADY    ( APB3mmaster_PREADY_net_0 ),
        .PSLVERR   ( APB3mmaster_PSLVERR_net_0 ),
        .PSELS1    ( CoreAPB3_C0_0_APBmslave1_PSELx ),
        .PENABLES  ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .PWRITES   ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .PSELS2    ( CoreAPB3_C0_0_APBmslave2_PSELx ),
        .PSELS3    ( CoreAPB3_C0_0_APBmslave3_PSELx ),
        .PSELS5    ( CoreAPB3_C0_0_APBmslave5_PSELx ),
        .PSELS6    ( CoreAPB3_C0_0_APBmslave6_PSELx ),
        .PRDATA    ( APB3mmaster_PRDATA_net_0 ),
        .PADDRS    ( CoreAPB3_C0_0_APBmslave1_PADDR ),
        .PWDATAS   ( CoreAPB3_C0_0_APBmslave1_PWDATA ) 
        );

//--------CoreGPIO_C0
CoreGPIO_C0 CoreGPIO_C0_0(
        // Inputs
        .PRESETN  ( PRESETN ),
        .PCLK     ( PCLK ),
        .PSEL     ( CoreAPB3_C0_0_APBmslave2_PSELx ),
        .PENABLE  ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .PWRITE   ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .GPIO_IN  ( GPIO_IN_net_0 ),
        .PADDR    ( CoreAPB3_C0_0_APBmslave1_PADDR_1 ),
        .PWDATA   ( CoreAPB3_C0_0_APBmslave1_PWDATA ),
        // Outputs
        .PREADY   ( CoreAPB3_C0_0_APBmslave2_PREADY ),
        .PSLVERR  ( CoreAPB3_C0_0_APBmslave2_PSLVERR ),
        .INT      (  ),
        .GPIO_OUT ( GPIO_OUT_0 ),
        .PRDATA   ( CoreAPB3_C0_0_APBmslave2_PRDATA ) 
        );

//--------CoreTimer_C0
CoreTimer_C0 CoreTimer_C0_0(
        // Inputs
        .PCLK    ( PCLK ),
        .PRESETn ( PRESETN ),
        .PSEL    ( CoreAPB3_C0_0_APBmslave3_PSELx ),
        .PENABLE ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .PWRITE  ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .PADDR   ( CoreAPB3_C0_0_APBmslave1_PADDR_2 ),
        .PWDATA  ( CoreAPB3_C0_0_APBmslave1_PWDATA ),
        // Outputs
        .TIMINT  ( TIMINT_net_0 ),
        .PRDATA  ( CoreAPB3_C0_0_APBmslave3_PRDATA ) 
        );

//--------CoreUARTapb_C0
CoreUARTapb_C0 CoreUARTapb_C0_0(
        // Inputs
        .PCLK        ( PCLK ),
        .PRESETN     ( PRESETN ),
        .RX          ( RX ),
        .PSEL        ( CoreAPB3_C0_0_APBmslave1_PSELx ),
        .PENABLE     ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .PWRITE      ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .PADDR       ( CoreAPB3_C0_0_APBmslave1_PADDR_0 ),
        .PWDATA      ( CoreAPB3_C0_0_APBmslave1_PWDATA_0 ),
        // Outputs
        .TXRDY       (  ),
        .RXRDY       (  ),
        .PARITY_ERR  (  ),
        .OVERFLOW    (  ),
        .TX          ( TX_net_0 ),
        .FRAMING_ERR (  ),
        .PREADY      ( CoreAPB3_C0_0_APBmslave1_PREADY ),
        .PSLVERR     ( CoreAPB3_C0_0_APBmslave1_PSLVERR ),
        .PRDATA      ( CoreAPB3_C0_0_APBmslave1_PRDATA ) 
        );

//--------SD_IF
SD_IF SD_IF_0(
        // Inputs
        .PCLK            ( PCLK ),
        .PRESETN         ( PRESETN ),
        .SD_SDI          ( SD_SDI ),
        .APB_bif_PADDR   ( CoreAPB3_C0_0_APBmslave1_PADDR_3 ),
        .APB_bif_PSEL    ( CoreAPB3_C0_0_APBmslave5_PSELx ),
        .APB_bif_PENABLE ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .APB_bif_PWRITE  ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .APB_bif_PWDATA  ( CoreAPB3_C0_0_APBmslave1_PWDATA_1 ),
        // Outputs
        .SD_SCLK         ( SD_SCLK_net_0 ),
        .SD_SDO          ( SD_SDO_net_0 ),
        .APB_bif_PRDATA  ( CoreAPB3_C0_0_APBmslave5_PRDATA ),
        .APB_bif_PREADY  ( CoreAPB3_C0_0_APBmslave5_PREADY ),
        .APB_bif_PSLVERR ( CoreAPB3_C0_0_APBmslave5_PSLVERR ),
        .SD_SS           ( SD_SS_net_0 ) 
        );

//--------spi_flash
spi_flash spi_flash_0(
        // Inputs
        .PCLK            ( PCLK ),
        .PRESETN         ( PRESETN ),
        .SPI_FLASH_SDI   ( SPI_FLASH_SDI ),
        .APB_bif_PADDR   ( CoreAPB3_C0_0_APBmslave1_PADDR_4 ),
        .APB_bif_PSEL    ( CoreAPB3_C0_0_APBmslave6_PSELx ),
        .APB_bif_PENABLE ( CoreAPB3_C0_0_APBmslave1_PENABLE ),
        .APB_bif_PWRITE  ( CoreAPB3_C0_0_APBmslave1_PWRITE ),
        .APB_bif_PWDATA  ( CoreAPB3_C0_0_APBmslave1_PWDATA ),
        // Outputs
        .SPI_FLASH_SDO   ( SPI_FLASH_SDO_net_0 ),
        .SPI_FLASH_SCLK  ( SPI_FLASH_SCLK_net_0 ),
        .SPI_FLASH_SS    ( SPI_FLASH_SS_net_0 ),
        .APB_bif_PRDATA  ( CoreAPB3_C0_0_APBmslave6_PRDATA ),
        .APB_bif_PREADY  ( CoreAPB3_C0_0_APBmslave6_PREADY ),
        .APB_bif_PSLVERR ( CoreAPB3_C0_0_APBmslave6_PSLVERR ) 
        );


endmodule
