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
//   File: MIV_RV32IMC_opsrv_pkg.sv
//
//   Purpose: OPSRV shared package
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none



package MIV_RV32IMC_opsrv_cfg_pkg;

//------------------
// Global definitions
//------------------

//  localparam l_opsrv_cfg_axi_mstr_present                  = 1;
//  localparam l_opsrv_cfg_apb_mstr_register_io              = 1;
  //localparam l_opsrv_cfg_ahb_mstr_present                  = 0;
  localparam l_opsrv_cfg_udma_present                      = 0;
  localparam l_opsrv_cfg_udma_ctrl_addr_width              = 32;   
  localparam l_opsrv_cfg_opsrv_cfg_addr_width              = 12;   
//  localparam l_opsrv_cfg_lmem0_present                     = 1;
  localparam l_opsrv_cfg_lmem0_addr_width                  = 32;
  localparam l_opsrv_cfg_lmem0_udma_present                = 0;
  //localparam l_opsrv_cfg_lmem0_dap_present                 = 0;
  localparam l_opsrv_cfg_lmem0_cpu_i_present               = 1;
  localparam l_opsrv_cfg_lmem0_cpu_d_present               = 1;
  localparam l_opsrv_cfg_lmem0_use_ram_parity_bits         = 0;
  localparam l_opsrv_cfg_lmem1_present                     = 0;
  localparam l_opsrv_cfg_lmem1_addr_width                  = 32;   
  localparam l_opsrv_cfg_lmem1_udma_present                = 0;
  localparam l_opsrv_cfg_lmem1_dap_present                 = 0;
  localparam l_opsrv_cfg_lmem1_cpu_i_present               = 1;
  localparam l_opsrv_cfg_lmem1_cpu_d_present               = 1;
  localparam l_opsrv_cfg_lmem1_use_ram_parity_bits         = 0;
  //localparam l_opsrv_cfg_lmem_dap_present                  = 0;
 // localparam l_opsrv_cfg_submicron_debug                   = 1;
  localparam l_opsrv_cfg_use_bus_parity                    = 1;
  localparam l_opsrv_cfg_lmem_ram_sb_in_width              = 4;
  localparam l_opsrv_cfg_lmem_ram_sb_out_width             = 4;
  

  //localparam logic[31:0] l_axi_mstr_start_addr             = 32'h6000_0000;
  //localparam logic[31:0] l_axi_mstr_end_addr               = 32'h6000_FFFF;
  //localparam logic[31:0] l_apb_mstr_start_addr             = 32'h7000_0000;
  //localparam logic[31:0] l_apb_mstr_end_addr               = 32'h7000_FFFF;
  //localparam logic[31:0] l_ahb_mstr_start_addr             = 32'h6000_0000;
  //localparam logic[31:0] l_ahb_mstr_end_addr               = 32'h6000_FFFF;
  //localparam logic[31:0] l_udma_ctrl_start_addr            = 32'h0000_0000;
  //localparam logic[31:0] l_udma_ctrl_end_addr              = 32'h0000_0FFF;
  //localparam logic[31:0] l_opsrv_cfg_start_addr            = 32'h0000_1000;
  //localparam logic[31:0] l_opsrv_cfg_end_addr              = 32'h0000_1FFF;
  //localparam logic[31:0] l_lmem0_start_addr                = 32'h8000_0000;
  //localparam logic[31:0] l_lmem0_end_addr                  = 32'h8000_0FFF;
  //localparam logic[31:0] l_lmem1_start_addr                = 32'h8001_0000;
  //localparam logic[31:0] l_lmem1_end_addr                  = 32'h8001_0FFF;
  //localparam logic[31:0] l_lmem_dap_udma_ctrl_start_addr   = 32'h0000_0000;
  //localparam logic[31:0] l_lmem_dap_udma_ctrl_end_addr     = 32'h0000_0FFF;
  //localparam logic[31:0] l_lmem_dap_lmem0_start_addr       = 32'h8000_0000;
  //localparam logic[31:0] l_lmem_dap_lmem0_end_addr         = 32'h8000_0FFF;
  //localparam logic[31:0] l_lmem_dap_lmem1_start_addr       = 32'h8001_0000;
  //localparam logic[31:0] l_lmem_dap_lmem1_end_addr         = 32'h8001_0FFF; 
  
//  localparam             l_opsrv_cfg_lmem_byte_shim        = 0;
  localparam logic       l_cfg_fence_all_src               = 1'b0;
  localparam logic       l_opsrv_cfg_raw_hzd_en            = 1'b1;  
  localparam logic       l_opsrv_cfg_war_hzd_en            = 1'b1;   
  localparam logic [3:0] l_opsrv_cfg_ar_cache              = 4'b0011; // Normal Non-cacheable Bufferable     
  localparam logic [3:0] l_opsrv_cfg_aw_cache              = 4'b0011; // Normal Non-cacheable Bufferable              
  localparam logic [1:0] l_opsrv_axi_rd_cfg_min_size       = 2'd2;  
  localparam logic [1:0] l_opsrv_axi_wr_cfg_min_size       = 2'd2;         
  
  localparam logic [31:0] l_mtimecmp_addr_base            = 32'h0200_4000;
  localparam logic [31:0] l_mtime_prescaler_addr          = 32'h0200_5000;
  localparam logic [31:0] l_mtime_addr_base               = 32'h0200_BFF8;  
                            

 
endpackage


`default_nettype wire
