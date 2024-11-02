////////////////////////////////////////////////////////////////////////////////
//                              Microsemi Corp.                               //
//                                                                            //
//                               Copyright 2018                               //
//                            All Rights Reserved                             //
//                         CONFIDENTIAL & PROPRIETARY                         //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File: lw10_62_60_opsrv_debug_pkg.sv
//
//   Purpose: OPSRV Debug shared package
//
//   Author:
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

package MIV_RV32IMC_opsrv_debug_pkg;

//------------------------------------------------------------------------------
// Global definitions
//------------------------------------------------------------------------------
   
   localparam        ABSTRACT_ERR_BUSY                = 1'd1;
   localparam        ABSTRACT_ERR_CMD                 = 2'd2;
   localparam        ABSTRACT_ERR_EXCEPTION           = 3'd3;
   localparam        ABSTRACT_ERR_NOHALT              = 3'd4;
   localparam        ADDR_WIDTH                       = 32;
   localparam        DATA_WIDTH                       = 32;
   localparam        IR_REG_WIDTH                     = 5;
   localparam        DR_REG_WIDTH                     = 32;
   localparam        ACTIVE_HIGH_RESET                = 1;


//------------------------------------------------------------------------------
// Debug Registers Addresses
//------------------------------------------------------------------------------
   localparam [6:0] ABS_DATA_0_ADDR                  = 'h04; //
   localparam [6:0] ABS_DATA_1_ADDR                  = 'h05; //
   localparam [6:0] ABS_DATA_2_ADDR                  = 'h06; //
   localparam [6:0] ABS_DATA_3_ADDR                  = 'h07; //
   localparam [6:0] ABS_DATA_4_ADDR                  = 'h08; //
   localparam [6:0] ABS_DATA_5_ADDR                  = 'h09; //
   localparam [6:0] ABS_DATA_6_ADDR                  = 'h0a; //
   localparam [6:0] ABS_DATA_7_ADDR                  = 'h0b; //
   localparam [6:0] ABS_DATA_8_ADDR                  = 'h0c; //
   localparam [6:0] ABS_DATA_9_ADDR                  = 'h0d; //
   localparam [6:0] ABS_DATA_10_ADDR                 = 'h0e; //
   localparam [6:0] ABS_DATA_11_ADDR                 = 'h0f; //
   localparam [6:0] DMCONTROL_ADDR                   = 'h10; //
   localparam [6:0] DMSTATUS_ADDR                    = 'h11; //
   localparam [6:0] HART_INFO_ADDR                   = 'h12; //
   localparam [6:0] HALT_SUM_0_ADDR                  = 'h40;
   localparam [6:0] HALT_SUM_1_ADDR                  = 'h13; //
   localparam [6:0] HART_ARRAY_WINDOW_SEL_ADDR       = 'h14; // Hart Array Window Select.
   localparam [6:0] HART_ARRAY_WINDOW_ADDR           = 'h15; // HArt Array Window.
   localparam [6:0] ABST_CONTROL_AND_STATUS_ADDR     = 'h16; // Abstract Control and Status.
   localparam [6:0] ABST_COMMAND_ADDR                = 'h17; // Abstract Command.
   localparam [6:0] ABST_COMMAND_AUTOEXEC_ADDR       = 'h18; // Abstract Command Autoexec.
   localparam [6:0] CONF_STR_PTR_0_ADDR              = 'h19; // Config String Pointer Address 0.
   localparam [6:0] CONF_STR_PTR_1_ADDR              = 'h1a; // Config String Pointer Address 1.
   localparam [6:0] CONF_STR_PTR_2_ADDR              = 'h1b; // Config String Pointer Address 2.
   localparam [6:0] CONF_STR_PTR_3_ADDR              = 'h1c; // Config String Pointer Address 3.
   localparam [6:0] PROG_BUFF_0_ADDR                 = 'h20; // Program Buffer 0.
   localparam [6:0] PROG_BUFF_1_ADDR                 = 'h21; // Program Buffer 1.
   localparam [6:0] PROG_BUFF_2_ADDR                 = 'h22; // Program Buffer 2.
   localparam [6:0] PROG_BUFF_3_ADDR                 = 'h23; // Program Buffer 3.
   localparam [6:0] PROG_BUFF_4_ADDR                 = 'h24; // Program Buffer 4.
   localparam [6:0] PROG_BUFF_5_ADDR                 = 'h25; // Program Buffer 5.
   localparam [6:0] PROG_BUFF_6_ADDR                 = 'h26; // Program Buffer 6.
   localparam [6:0] PROG_BUFF_7_ADDR                 = 'h27; // Program Buffer 7.
   localparam [6:0] PROG_BUFF_8_ADDR                 = 'h28; // Program Buffer 8.
   localparam [6:0] PROG_BUFF_9_ADDR                 = 'h29; // Program Buffer 9.
   localparam [6:0] PROG_BUFF_10_ADDR                = 'h2a; // Program Buffer 10.
   localparam [6:0] PROG_BUFF_11_ADDR                = 'h2b; // Program Buffer 11.
   localparam [6:0] PROG_BUFF_12_ADDR                = 'h2c; // Program Buffer 12.
   localparam [6:0] PROG_BUFF_13_ADDR                = 'h2d; // Program Buffer 13.
   localparam [6:0] PROG_BUFF_14_ADDR                = 'h2e; // Program Buffer 14.
   localparam [6:0] PROG_BUFF_15_ADDR                = 'h2f; // Program Buffer 15.
   localparam [6:0] AUTH_DATA_ADDR                   = 'h30; // Authentication Data.
   localparam [6:0] SBA_CONTROL_AND_STATUS_ADDR      = 'h38; // System Bus Access Control and Status.
   localparam [6:0] SYS_BUS_ADDR_0_ADDR              = 'h39; // System Bus Address 31:0.
   localparam [6:0] SYS_BUS_ADDR_1_ADDR              = 'h3a; // System Bus Address 63:32.
   localparam [6:0] SYS_BUS_ADDR_2_ADDR              = 'h3b; // System Bus Address 95:64.
   localparam [6:0] SYS_BUS_DATA_0_ADDR              = 'h3c; // System Bus Data 31:0.
   localparam [6:0] SYS_BUS_DATA_1_ADDR              = 'h3d; // System Bus Data 63:32.
   localparam [6:0] SYS_BUS_DATA_2_ADDR              = 'h3e; // System Bus Data 96:64.
   localparam [6:0] SYS_BUS_DATA_3_ADDR              = 'h3f; // System Bus Data 127:96. 8 bit

   // Machine Information Registers (read-only)
   localparam [11:0] CSR_ADDR_MVENDORID               = 'hF11;
   localparam [11:0] CSR_ADDR_MARCHID                 = 'hF12;
   localparam [11:0] CSR_ADDR_MIMPID                  = 'hF13;
   localparam [11:0] CSR_ADDR_MHARTID                 = 'hF14;
   localparam [11:0] CSR_ADDR_MISA                    = 'h301;
   localparam [11:0] DBGCSR_ADDR_DPC                  = 'h7b0;

   // ABSTRACTCS
   localparam        ABSTRACTCS_RESERVEDD             = 1'd0;
   localparam        ABSTRACTCS_PROGBUFSIZE           = 5'd0;
   localparam        ABSTRACTCS_RESERVEDC             = 1'd0;
   localparam        ABSTRACTCS_RESERVEDB             = 1'd0;
   localparam        ABSTRACTCS_RESERVEDA             = 1'd0;
   localparam        ABSTRACTCS_DATACOUNT             = 4'd1;
   
   // DMCONTROL   
   localparam        DMCONTROL_HARTRESET              = 1'd0;
   localparam        DMCONTROL_RESERVEDB              = 1'd0;
   localparam        DMCONTROL_HASEL                  = 1'd0;
   localparam        DMCONTROL_HARTSELLO              = 10'd0;
   localparam        DMCONTROL_HARTSELHI              = 10'd0;
   localparam        DMCONTROL_RESERVEDA              = 4'd0;
   
   // DMSTATUS 
   localparam        DMSTATUS_RESERVEDC               = 1'd0;
   localparam        DMSTATUS_IMPEBREAK               = 1'd0;
   localparam        DMSTATUS_RESERVEDB               = 1'd0;
   localparam        DMSTATUS_ALLUNAVAIL              = 1'd0;
   localparam        DMSTATUS_ANYUNAVAIL              = 1'd0;
   localparam        DMSTATUS_ALLANYUNAVAIL           = 1'd0;
   localparam        DMSTATUS_ALLANYNONEXIST          = 1'b0;
   localparam        DMSTATUS_AUTHENTICATED           = 1'd1;
   localparam        DMSTATUS_AUTHBUSY                = 1'd0;
   localparam        DMSTATUS_HASRESETHALTREQ         = 1'd0;//disabled
   localparam        DMSTATUS_CONFSTRPTRVALID         = 1'd0;
   localparam        DMSTATUS_VERSION                 = 2'd2;

   // SBA
   localparam        SBCS_VER                         = 3'b1; // post 2018 spec implemented
   localparam        SBCS_SIZE                        = 7'd32; //tied to 32
   localparam        SBCS_ACCESSES                    = 5'h7; // 32/16/8 bit bus accesses supported
   localparam        TIMEOUT_VAL                      = 4'h8; // 8 bit base counter used, increments prescale counter on overflow. 
                                                              //   Timeout occurs when prescale counter reaches or exceeds TIMOUT_VAL
  
   
   // DMI
   localparam        DBG_DMI_OP_WIDTH                 = 6'd2;
   localparam        DBG_DMI_DATA_WIDTH               = 6'd32;
   localparam        DBG_DMI_ADDR_WIDTH               = 6'd7;
   
   
   // DTMS
   localparam        DTMCS_RESERVEDB_HI               = 5'd31;
   localparam        DTMCS_RESERVEDB_LO               = 5'd18;
   localparam        DTMCS_DMIHARDRESET               = 5'd17;
   localparam        DTMCS_DMIRESET                   = 5'd16;
   localparam        DTMCS_RESERVEDA                  = 5'd15;
   localparam        DTMCS_IDLE_HI                    = 5'd14;
   localparam        DTMCS_IDLE_LO                    = 5'd12;
   localparam        DTMCS_DMISTAT_HI                 = 5'd11;
   localparam        DTMCS_DMISTAT_LO                 = 5'd10;
   localparam        DTMCS_ABITS_HI                   = 5'd9;
   localparam        DTMCS_ABITS_LO                   = 5'd4;
   localparam        DTMCS_VERSION_HI                 = 5'd3;
   localparam        DTMCS_VERSION_LO                 = 5'd0;
   
   // DMI
   localparam        DMI_OP_LO          = 5'd0;
   localparam        DMI_OP_HI          = DMI_OP_LO + DBG_DMI_OP_WIDTH - 1;
   localparam        DMI_DATA_LO        = DMI_OP_HI + 1;
   localparam        DMI_DATA_HI        = DMI_DATA_LO + DBG_DMI_DATA_WIDTH - 1;
   localparam        DMI_ADDR_LO        = DMI_DATA_HI + 1;
   localparam        DMI_ADDR_HI        = DMI_ADDR_LO + DBG_DMI_ADDR_WIDTH - 1;
   


   // JTAG TAP

//------------------------------------------------------------------------------
// Constants
//------------------------------------------------------------------------------
   // State Machine encoding
   localparam        TEST_LOGIC_RESET                 = 4'b0000;
   localparam        RUN_TEST_IDLE                    = 4'b0001;
   localparam        SELECT_DR                        = 4'b0010;
   localparam        CAPTURE_DR                       = 4'b0011;
   localparam        SHIFT_DR                         = 4'b0100;
   localparam        EXIT1_DR                         = 4'b0101;
   localparam        PAUSE_DR                         = 4'b0110;
   localparam        EXIT2_DR                         = 4'b0111;
   localparam        UPDATE_DR                        = 4'b1000;
   localparam        SELECT_IR                        = 4'b1001;
   localparam        CAPTURE_IR                       = 4'b1010;
   localparam        SHIFT_IR                         = 4'b1011;
   localparam        EXIT1_IR                         = 4'b1100;
   localparam        PAUSE_IR                         = 4'b1101;
   localparam        EXIT2_IR                         = 4'b1110;
   localparam        UPDATE_IR                        = 4'b1111;
   
   // Supported instructions
   localparam [IR_REG_WIDTH-1:0] BYPASS_INSTR         = 5'h00;
   localparam [IR_REG_WIDTH-1:0] ID_CODE_INSTR        = 5'h01;
   localparam [IR_REG_WIDTH-1:0] DTM_CS_INSTR         = 5'h10;
   localparam [IR_REG_WIDTH-1:0] DMI_ACCESS_INSTR     = 5'h11;
   
   // TAP ID code
   localparam [DR_REG_WIDTH-1:0] ID_CODE = 'h1E50105F; // Ver[31:28] 0x1, Part No.[27:12] E501, ManufID[11:1] 0x02F (Actel), Hardwired[0] = 1'b1 
   
   // SBA
   localparam        BYTE_ACCESS                      = 3'b000;
   localparam        HWORD_ACCESS                     = 3'b001;
   localparam        WORD_ACCESS                      = 3'b010;
   localparam        DWORD_ACCESS                     = 3'b011;
   localparam        QWORD_ACCESS                     = 3'b100;
   
   //3 (64-bit) and 4 (128-bit) unsupported.
   
endpackage

`default_nettype wire