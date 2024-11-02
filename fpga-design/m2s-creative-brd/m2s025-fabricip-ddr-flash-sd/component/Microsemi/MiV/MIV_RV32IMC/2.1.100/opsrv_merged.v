// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv.sv
//
//   Purpose:
//    opsrv top-level
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv
//********************************************************************************
// Parameter description

   #(   
    parameter CPU_ADDR_WIDTH                  = 32,
    parameter AXI_MSTR_ADDR_WIDTH             = 32,
    parameter APB_MSTR_ADDR_WIDTH             = 16,
    parameter APB_MSTR_REGISTER_IO            = 1,
    parameter AHB_MSTR_ADDR_WIDTH             = 16,
    parameter UDMA_PRESENT                    = 0,
    parameter UDMA_CTRL_ADDR_WIDTH            = 12,    
    parameter OPSRV_CFG_ADDR_WIDTH            = 12,    
    parameter LMEM0_ADDR_WIDTH                = 16,
    parameter LMEM0_UDMA_PRESENT              = 0,
    parameter LMEM0_CPU_I_PRESENT             = 1,
    parameter LMEM0_CPU_D_PRESENT             = 1,
    parameter LMEM0_USE_RAM_PARITY_BITS       = 0, 
    parameter LMEM_DAP_ADDR_WIDTH             = 17,
    parameter USE_BUS_PARITY                  = 0,
	//
    parameter l_axi_mstr_start_addr           = 32'h6000_0000,
    parameter l_axi_mstr_end_addr             = 32'h6000_FFFF,
    parameter l_apb_mstr_start_addr           = 32'h7000_0000,
    parameter l_apb_mstr_end_addr             = 32'h7000_FFFF,
    parameter l_ahb_mstr_start_addr           = 32'h6000_0000,
    parameter l_ahb_mstr_end_addr             = 32'h6000_FFFF,
    parameter l_udma_ctrl_start_addr          = 32'h0000_0000,
    parameter l_udma_ctrl_end_addr            = 32'h0000_0FFF,
    parameter l_opsrv_cfg_start_addr          = 32'h0000_1000,
    parameter l_opsrv_cfg_end_addr            = 32'h0000_1FFF,
    parameter l_lmem0_start_addr              = 32'h8000_0000,
    parameter l_lmem0_end_addr                = 32'h8000_0FFF,
    parameter l_lmem1_start_addr              = 32'h8001_0000,
    parameter l_lmem1_end_addr                = 32'h8001_0FFF,
    parameter l_lmem_dap_udma_ctrl_start_addr = 32'h0000_0000,
    parameter l_lmem_dap_udma_ctrl_end_addr   = 32'h0000_0FFF,
    parameter l_lmem_dap_lmem0_start_addr     = 32'h8000_0000,
    parameter l_lmem_dap_lmem0_end_addr       = 32'h8000_0FFF,
    parameter l_lmem_dap_lmem1_start_addr     = 32'h8001_0000,
    parameter l_lmem_dap_lmem1_end_addr       = 32'h8001_0FFF,
	parameter l_opsrv_cfg_lmem_dap_present    = 0,
	parameter l_opsrv_cfg_lmem0_dap_present   = 0,
    parameter l_opsrv_cfg_lmem0_present       = 1,
    parameter l_opsrv_cfg_axi_mstr_present    = 1,
    parameter l_opsrv_cfg_ahb_mstr_present    = 0,
	parameter l_opsrv_cfg_apb_mstr_present    = 0,
    parameter l_opsrv_cfg_submicron_debug     = 1,
	parameter l_submicron_cfg_hw_debug        = 1,
    //
	parameter l_submicron_cfg_hw_multiply_divide = 0,
	parameter l_submicron_cfg_hw_compressed      = 0,
	parameter l_submicron_reset_vector           = 32'h6000_0000,
	parameter l_submicron_static_mtvec_base      = 32'h6000_0034,
    parameter l_submicron_cfg_static_mtvec_base  = 0,
    parameter l_submicron_cfg_static_mtvec_mode  = 0,
    parameter l_submicron_static_mtvec_mode      = 0,
	parameter l_submicron_num_sys_ext_irqs       = 7,
	parameter l_submicron_cfg_hw_macc_multiplier = 0,
	parameter l_submicron_cfg_time_count_width   = 64,	
    parameter RAM_SB_IN_WIDTH                    = l_opsrv_cfg_lmem_ram_sb_in_width,
    parameter RAM_SB_OUT_WIDTH                   = l_opsrv_cfg_lmem_ram_sb_out_width,
    parameter l_submicron_cfg_lsu_fwd            = 1'b0,
    parameter l_submicron_cfg_csr_fwd            = 1'b1,
    parameter l_submicron_cfg_exu_fwd            = 1'b1,
	parameter l_submicron_cfg_gpr_type           = 0,
	parameter ECC_ENABLE                         = 0,
    parameter INTERNAL_MTIME                     = 0,
    parameter INTERNAL_MTIME_IRQ                 = 0,
    parameter MTIME_PRESCALER           = 16'h63
   )

//********************************************************************************
// Port description

  (    
    
    input wire logic                              clk,
    input wire logic                              resetn,
    
    // CPU controls
    input wire  logic [63:0]                      mtime_count,   
    input  wire logic [31:0]                      hart_id, 
    input wire  logic                             sys_parity_disable, 
    input wire  logic                             m_timer_irq,
    input wire  logic                             m_external_irq,
    input wire  logic [5:0]                       m_sys_ext_irq,
    output      logic                             debug_sys_reset, 
	output      logic [63:0]                      mtime_count_out,
    output      logic                             lmem0_uncorrectable_ecc_error,
    output      logic                             lmem1_uncorrectable_ecc_error,
    output      logic                             gpr_uncorrectable_ecc_error,
                               
    
    input wire  logic                             jtag_trst,
    input wire  logic                             jtag_tck,
    input wire  logic                             jtag_tdi,
    input wire  logic                             jtag_tms,
    output      logic                             jtag_tdo,
    output      logic                             jtag_tdo_dr,
      
    // APB Master interface
    output      logic [APB_MSTR_ADDR_WIDTH-1:0]   apb_mstr_paddr, 
    output      logic                             apb_mstr_paddr_p,
    output      logic [2:0]                       apb_mstr_pprot,
    output      logic                             apb_mstr_psel,
    output      logic                             apb_mstr_penable, 
    output      logic                             apb_mstr_pwrite, 
    output      logic [31:0]                      apb_mstr_pwdata,
    output      logic [3:0]                       apb_mstr_pwdata_p,
    output      logic [3:0]                       apb_mstr_pstrb, 
    input wire  logic                             apb_mstr_pready, 
    input wire  logic [31:0]                      apb_mstr_prdata,
    input wire  logic [3:0]                       apb_mstr_prdata_p, 
    input wire  logic                             apb_mstr_pslverr,
    
    // APB Slave interface (LMEM direct access port)
    input wire logic                              lmem0_cpu_access_disable,  
    input wire logic                              lmem0_dma_access_disable, 
    input wire logic                              lmem0_dap_access_disable, 
    input wire logic                              lmem1_cpu_access_disable,  
    input wire logic                              lmem1_dma_access_disable, 
    input wire logic                              lmem1_dap_access_disable,
    input wire  logic [LMEM_DAP_ADDR_WIDTH-1:0]   lmem_dap_apb_slv_paddr, 
    input wire  logic                             lmem_dap_apb_slv_paddr_p,
    input wire  logic [2:0]                       lmem_dap_apb_slv_pprot,
    input wire  logic                             lmem_dap_apb_slv_psel,
    input wire  logic                             lmem_dap_apb_slv_penable, 
    input wire  logic                             lmem_dap_apb_slv_pwrite, 
    input wire  logic [31:0]                      lmem_dap_apb_slv_pwdata,
    input wire  logic [3:0]                       lmem_dap_apb_slv_pwdata_p, 
    output      logic                             lmem_dap_apb_slv_pready, 
    output      logic [31:0]                      lmem_dap_apb_slv_prdata,
    output      logic [3:0]                       lmem_dap_apb_slv_prdata_p, 
    output      logic                             lmem_dap_apb_slv_pslverr,
    output      logic                             lmem_dap_udma_ctrl_irq,
    
    // LMEM Sideband signals
    output      logic [RAM_SB_OUT_WIDTH-1:0]      lmem0_ram_sb_out,
    input  wire logic [RAM_SB_IN_WIDTH-1:0]       lmem0_ram_sb_in,
    output      logic [RAM_SB_OUT_WIDTH-1:0]      lmem1_ram_sb_out,
    input  wire logic [RAM_SB_IN_WIDTH-1:0]       lmem1_ram_sb_in,
    
    
    // AXI Master interface
    input wire logic                              axi_mstr_aclk_en,
    output logic                                  axi_mstr_arid,
    output logic [AXI_MSTR_ADDR_WIDTH-1:0]        axi_mstr_araddr,
    output logic [3:0]                            axi_mstr_arlen,
    output logic [2:0]                            axi_mstr_arsize,
    output logic [1:0]                            axi_mstr_arburst,
    output logic                                  axi_mstr_arlock,
    output logic [3:0]                            axi_mstr_arcache,
    output logic [2:0]                            axi_mstr_arprot,
    input wire logic                              axi_mstr_arready,
    output logic                                  axi_mstr_arvalid,
    output logic                                  axi_mstr_ar_addr_p,
    input wire logic [1:0]                        axi_mstr_rresp,
    input wire logic [31:0]                       axi_mstr_rdata,
    input wire logic                              axi_mstr_rlast,
    input wire logic                              axi_mstr_rid,
    output logic                                  axi_mstr_rready,
    input wire logic                              axi_mstr_rvalid,
    input wire logic [3:0]                        axi_mstr_r_data_p,
    output logic                                  axi_mstr_awid,
    output logic [AXI_MSTR_ADDR_WIDTH-1:0]        axi_mstr_awaddr,
    output logic [3:0]                            axi_mstr_awlen,
    output logic [2:0]                            axi_mstr_awsize,
    output logic [1:0]                            axi_mstr_awburst,
    output logic                                  axi_mstr_awlock,
    output logic [3:0]                            axi_mstr_awcache,
    output logic [2:0]                            axi_mstr_awprot,
    output logic                                  axi_mstr_aw_addr_p,
    input wire logic                              axi_mstr_awready,
    output logic                                  axi_mstr_awvalid,
    output logic [31:0]                           axi_mstr_wdata,
    output logic [3:0]                            axi_mstr_wstrb,
    output logic                                  axi_mstr_wlast,
    output logic                                  axi_mstr_wid,
    input wire logic                              axi_mstr_wready,
    output logic                                  axi_mstr_wvalid,
    output logic [3:0]                            axi_mstr_w_data_p, 
    input wire logic  [1:0]                       axi_mstr_bresp,
    input wire logic                              axi_mstr_bid,
    output logic                                  axi_mstr_bready,
    input wire logic                              axi_mstr_bvalid,
    
    // AHB Master interface
    output      logic [AHB_MSTR_ADDR_WIDTH-1:0]   ahb_mstr_haddr,     
    output      logic                             ahb_mstr_haddr_p,   
    output      logic [2:0]                       ahb_mstr_hburst,    
    output      logic                             ahb_mstr_hmastlock, 
    output      logic [3:0]                       ahb_mstr_hprot,     
    output      logic [2:0]                       ahb_mstr_hsize,     
    output      logic [1:0]                       ahb_mstr_htrans,    
    output      logic [31:0]                      ahb_mstr_hwdata,    
    output      logic [3:0]                       ahb_mstr_hwdata_p,  
    output      logic                             ahb_mstr_hwrite,    
    input wire  logic [31:0]                      ahb_mstr_hrdata,    
    input wire  logic [3:0]                       ahb_mstr_hrdata_p,  
    input wire  logic                             ahb_mstr_hready,    
    input wire  logic                             ahb_mstr_hresp       
    
    
  );

//********************************************************************************
// Declarations

// localparams                                              
  localparam LMEM0_DEPTH = ((l_lmem0_end_addr - l_lmem0_start_addr) + 4) / 4;
  localparam LMEM1_DEPTH = ((l_lmem1_end_addr - l_lmem1_start_addr) + 4) / 4;                         

// nets

  logic [1:0]                                  axi_rd_cfg_min_size_net; 
  logic [1:0]                                  axi_wr_cfg_min_size_net; 
  logic                                        opsrv_parity_en_net;     
  logic                                        cfg_fence_all_src_net;   
  logic [3:0]                                  cfg_ar_cache_net;        
  logic [3:0]                                  cfg_aw_cache_net;        
  logic                                        cfg_raw_hzd_check_net;
  logic                                        cfg_war_hzd_check_net; 
  logic                                        cpu_i_req_valid_net;                 
  logic                                        cpu_i_req_ready_net;                 
  logic [3:0]                                  cpu_i_req_rd_byte_en_net;            
  logic [l_opsrv_cfg_cpu_addr_width-1:0]       cpu_i_req_addr_net;                  
  logic                                        cpu_i_req_addr_p_net;              
  logic                                        cpu_i_resp_valid_net;              
  logic                                        cpu_i_resp_ready_net;              
  logic                                        cpu_i_resp_error_net;              
  logic [31:0]                                 cpu_i_resp_rd_data_net;            
  logic [3:0]                                  cpu_i_resp_rd_data_p_net;          
  logic                                        cpu_d_req_valid_net;               
  logic                                        cpu_d_req_ready_net;               
  logic [3:0]                                  cpu_d_req_rd_byte_en_net;          
  logic [3:0]                                  cpu_d_req_wr_byte_en_net;          
  logic [l_opsrv_cfg_cpu_addr_width-1:0]       cpu_d_req_addr_net;                  
  logic                                        cpu_d_req_addr_p_net;            
  logic                                        cpu_d_req_fence_net;  
  logic                                        cpu_d_req_read_net;
  logic                                        cpu_d_req_write_net;             
  logic [31:0]                                 cpu_d_req_wr_data_net;           
  logic [3:0]                                  cpu_d_req_wr_data_p_net;         
  logic                                        cpu_d_resp_valid_net;            
  logic                                        cpu_d_resp_ready_net;            
  logic                                        cpu_d_resp_error_net;            
  logic [31:0]                                 cpu_d_resp_rd_data_net;          
  logic [3:0]                                  cpu_d_resp_rd_data_p_net; 
  
  logic                                        cpu_debug_reset_net;
  logic                                        cpu_debug_core_reset_net;
  logic                                        cpu_debug_active_net;
  logic [31:0]                                 cpu_debug_op_wr_data_net;    
  logic [31:0]                                 cpu_debug_csr_op_rd_data_net; 
  logic                                        cpu_debug_csr_op_rd_data_valid_net; 
  logic                                        cpu_debug_csr_op_rd_data_ready_net;    
  logic                                        cpu_debug_csr_op_ready_net;    
  logic                                        cpu_debug_csr_op_valid_net; 
  logic                                        cpu_debug_csr_wr_en_net; 
  logic                                        cpu_debug_csr_rd_en_net; 
  logic [11:0]                                 cpu_debug_csr_op_addr_net;  
  logic [31:0]                                 cpu_debug_gpr_op_rd_data_net; 
  logic                                        cpu_debug_gpr_op_rd_data_valid_net; 
  logic                                        cpu_debug_gpr_op_rd_data_ready_net;  
  logic                                        cpu_debug_gpr_op_valid_net; 
  logic                                        cpu_debug_gpr_op_ready_net;
  logic                                        cpu_debug_gpr_wr_en_net; 
  logic                                        cpu_debug_gpr_rd_en_net; 
  logic [4:0]                                  cpu_debug_gpr_op_addr_net; 
  logic                                        cpu_debug_halt_req_net;   
  logic                                        cpu_debug_halt_ack_net;
  logic                                        cpu_debug_resethalt_req_net;   
  logic                                        cpu_debug_resethalt_ack_net;    
  logic                                        cpu_debug_resume_req_net;   
  logic                                        cpu_debug_resume_ack_net;
  logic                                        cpu_debug_mode_net;
  
  logic [7:0]                                  sys_ext_irq_src_net;
  
  logic                                        debug_trx_os_net;       
  logic                                        debug_sysbus_req_valid_net;                 
  logic                                        debug_sysbus_req_ready_net;                 
  logic [3:0]                                  debug_sysbus_req_rd_byte_en_net;            
  logic [3:0]                                  debug_sysbus_req_wr_byte_en_net;            
  logic [l_opsrv_cfg_cpu_addr_width-1:0]       debug_sysbus_req_addr_net;                  
  logic [31:0]                                 debug_sysbus_req_wr_data_net;               
  logic                                        debug_sysbus_resp_valid_net;                
  logic                                        debug_sysbus_resp_ready_net;                
  logic                                        debug_sysbus_resp_error_net;             
  logic [31:0]                                 debug_sysbus_resp_rd_data_net;    
       
  logic                                        apb_mstr_i_req_valid_net;             
  logic                                        apb_mstr_i_req_ready_net;             
  logic [3:0]                                  apb_mstr_i_req_rd_byte_en_net;        
  logic [APB_MSTR_ADDR_WIDTH-1:0]              apb_mstr_i_req_addr_net;              
  logic                                        apb_mstr_i_req_addr_p_net;            
  logic                                        apb_mstr_i_resp_valid_net;            
  logic                                        apb_mstr_i_resp_ready_net;            
  logic                                        apb_mstr_i_resp_error_net;            
  logic [31:0]                                 apb_mstr_i_resp_rd_data_net;          
  logic [3:0]                                  apb_mstr_i_resp_rd_data_p_net;    
  logic                                        apb_mstr_d_req_valid_net;             
  logic                                        apb_mstr_d_req_ready_net;             
  logic [3:0]                                  apb_mstr_d_req_rd_byte_en_net;        
  logic [3:0]                                  apb_mstr_d_req_wr_byte_en_net; 
 // logic                                        apb_mstr_d_req_read_net; 
 // logic                                        apb_mstr_d_req_write_net;       
  logic [APB_MSTR_ADDR_WIDTH-1:0]              apb_mstr_d_req_addr_net;              
  logic                                        apb_mstr_d_req_addr_p_net;            
  logic [31:0]                                 apb_mstr_d_req_wr_data_net;           
  logic [3:0]                                  apb_mstr_d_req_wr_data_p_net;         
  logic                                        apb_mstr_d_resp_valid_net;            
  logic                                        apb_mstr_d_resp_ready_net;            
  logic                                        apb_mstr_d_resp_error_net;         
  logic [31:0]                                 apb_mstr_d_resp_rd_data_net;          
  logic [3:0]                                  apb_mstr_d_resp_rd_data_p_net;  
  logic                                        apb_mstr_trx_os_d_rd_net;
  logic                                        apb_mstr_trx_os_d_wr_net;    
  logic                                        apb_mstr_psel_int;
  logic                                        apb_mstr_penable_int; 
  logic                                        apb_mstr_pslverr_int;
  logic                                        apb_mstr_pready_int;
  logic [31:0]                                 apb_mstr_prdata_int;
  logic                                        apb_mstr_psel_net;
  logic                                        apb_mstr_penable_net; 
  logic                                        apb_mstr_pready_net;
  logic [31:0]                                 apb_mstr_prdata_net;
  logic                                        apb_mstr_pslverr_net;
  logic                                        apb_mstr_int_sel;
  logic                                        lmem0_i_req_valid_net;                
  logic                                        lmem0_i_req_ready_net;                
  logic [3:0]                                  lmem0_i_req_rd_byte_en_net;           
  logic [l_opsrv_cfg_lmem0_addr_width-1:0]     lmem0_i_req_addr_net;                 
  logic                                        lmem0_i_req_addr_p_net;               
  logic                                        lmem0_i_resp_valid_net;               
  logic                                        lmem0_i_resp_ready_net;               
  logic                                        lmem0_i_resp_error_net;               
  logic [31:0]                                 lmem0_i_resp_rd_data_net;             
  logic [3:0]                                  lmem0_i_resp_rd_data_p_net;           
  logic                                        lmem0_d_req_valid_net;                
  logic                                        lmem0_d_req_ready_net;                
  logic [3:0]                                  lmem0_d_req_rd_byte_en_net;           
  logic [3:0]                                  lmem0_d_req_wr_byte_en_net;  
  logic                                        lmem0_d_req_read_net; 
  logic                                        lmem0_d_req_write_net;         
  logic [l_opsrv_cfg_lmem0_addr_width-1:0]     lmem0_d_req_addr_net;                 
  logic                                        lmem0_d_req_addr_p_net;               
  logic [31:0]                                 lmem0_d_req_wr_data_net;              
  logic [3:0]                                  lmem0_d_req_wr_data_p_net;            
  logic                                        lmem0_d_resp_valid_net;               
  logic                                        lmem0_d_resp_ready_net;               
  logic                                        lmem0_d_resp_error_net;            
  logic [31:0]                                 lmem0_d_resp_rd_data_net;             
  logic [3:0]                                  lmem0_d_resp_rd_data_p_net;   
  logic                                        lmem0_trx_os_d_rd_net;
  logic                                        lmem0_trx_os_d_wr_net;  
  logic                                        lmem0_ecc_err_correctable_net;  
  logic                                        lmem0_ecc_err_uncorrectable_net;            
  logic                                        lmem1_i_req_valid_net;                
  logic                                        lmem1_i_req_ready_net;                
  logic [3:0]                                  lmem1_i_req_rd_byte_en_net;           
  logic [l_opsrv_cfg_lmem1_addr_width-1:0]     lmem1_i_req_addr_net;                         
  logic                                        lmem1_i_req_addr_p_net;               
  logic                                        lmem1_i_resp_valid_net;               
  logic                                        lmem1_i_resp_ready_net;               
  logic                                        lmem1_i_resp_error_net;               
  logic [31:0]                                 lmem1_i_resp_rd_data_net;             
  logic [3:0]                                  lmem1_i_resp_rd_data_p_net;           
  logic                                        lmem1_d_req_valid_net;                
  logic                                        lmem1_d_req_ready_net;                
  logic [3:0]                                  lmem1_d_req_rd_byte_en_net;           
  logic [3:0]                                  lmem1_d_req_wr_byte_en_net;   
  logic                                        lmem1_d_req_read_net; 
  logic                                        lmem1_d_req_write_net;            
  logic [l_opsrv_cfg_lmem1_addr_width-1:0]     lmem1_d_req_addr_net;                 
  logic                                        lmem1_d_req_addr_p_net;               
  logic [31:0]                                 lmem1_d_req_wr_data_net;              
  logic [3:0]                                  lmem1_d_req_wr_data_p_net;            
  logic                                        lmem1_d_resp_valid_net;               
  logic                                        lmem1_d_resp_ready_net;               
  logic                                        lmem1_d_resp_error_net;            
  logic [31:0]                                 lmem1_d_resp_rd_data_net;             
  logic [3:0]                                  lmem1_d_resp_rd_data_p_net;   
  logic                                        lmem1_trx_os_d_rd_net;
  logic                                        lmem1_trx_os_d_wr_net;   
  logic                                        lmem1_ecc_err_correctable_net;  
  logic                                        lmem1_ecc_err_uncorrectable_net;                                
  logic                                        axi_mstr_i_req_valid_net;             
  logic                                        axi_mstr_i_req_ready_net;             
  logic [3:0]                                  axi_mstr_i_req_rd_byte_en_net;        
  logic [AXI_MSTR_ADDR_WIDTH-1:0]              axi_mstr_i_req_addr_net;              
  logic                                        axi_mstr_i_req_addr_p_net;            
  logic                                        axi_mstr_i_resp_valid_net;            
  logic                                        axi_mstr_i_resp_ready_net;            
  logic                                        axi_mstr_i_resp_error_net;            
  logic [31:0]                                 axi_mstr_i_resp_rd_data_net;          
  logic [3:0]                                  axi_mstr_i_resp_rd_data_p_net;        
  logic                                        axi_mstr_d_req_valid_net;             
  logic                                        axi_mstr_d_req_ready_net;             
  logic [3:0]                                  axi_mstr_d_req_rd_byte_en_net;        
  logic [3:0]                                  axi_mstr_d_req_wr_byte_en_net;  
  logic                                        axi_mstr_d_req_read_net; 
  logic                                        axi_mstr_d_req_write_net;          
  logic [AXI_MSTR_ADDR_WIDTH-1:0]              axi_mstr_d_req_addr_net;              
  logic                                        axi_mstr_d_req_addr_p_net;            
  logic [31:0]                                 axi_mstr_d_req_wr_data_net;           
  logic [3:0]                                  axi_mstr_d_req_wr_data_p_net;         
  logic                                        axi_mstr_d_resp_valid_net;            
  logic                                        axi_mstr_d_resp_ready_net;            
  logic                                        axi_mstr_d_resp_rd_error_net;         
  logic [31:0]                                 axi_mstr_d_resp_rd_data_net;          
  logic [3:0]                                  axi_mstr_d_resp_rd_data_p_net; 
  logic                                        axi_mstr_d_wr_resp_err_net;
  logic                                        axi_mstr_trx_os_d_rd_net;
  logic                                        axi_mstr_trx_os_d_wr_net;       
  logic                                        ahb_mstr_i_req_valid_net;             
  logic                                        ahb_mstr_i_req_ready_net;             
  logic [3:0]                                  ahb_mstr_i_req_rd_byte_en_net;        
  logic [AHB_MSTR_ADDR_WIDTH-1:0]              ahb_mstr_i_req_addr_net;              
  logic                                        ahb_mstr_i_req_addr_p_net;            
  logic                                        ahb_mstr_i_resp_valid_net;            
  logic                                        ahb_mstr_i_resp_ready_net;            
  logic                                        ahb_mstr_i_resp_error_net;            
  logic [31:0]                                 ahb_mstr_i_resp_rd_data_net;          
  logic [3:0]                                  ahb_mstr_i_resp_rd_data_p_net;        
  logic                                        ahb_mstr_d_req_valid_net;             
  logic                                        ahb_mstr_d_req_ready_net;             
  logic [3:0]                                  ahb_mstr_d_req_rd_byte_en_net;        
  logic [3:0]                                  ahb_mstr_d_req_wr_byte_en_net;  
  logic                                        ahb_mstr_d_req_read_net; 
  logic                                        ahb_mstr_d_req_write_net;        
  logic [AHB_MSTR_ADDR_WIDTH-1:0]              ahb_mstr_d_req_addr_net;              
  logic                                        ahb_mstr_d_req_addr_p_net;            
  logic [31:0]                                 ahb_mstr_d_req_wr_data_net;           
  logic [3:0]                                  ahb_mstr_d_req_wr_data_p_net;         
  logic                                        ahb_mstr_d_resp_valid_net;            
  logic                                        ahb_mstr_d_resp_ready_net;            
  logic                                        ahb_mstr_d_resp_rd_error_net;         
  logic [31:0]                                 ahb_mstr_d_resp_rd_data_net;          
  logic [3:0]                                  ahb_mstr_d_resp_rd_data_p_net;  
  logic                                        ahb_mstr_trx_os_d_rd_net;
  logic                                        ahb_mstr_trx_os_d_wr_net;        
  logic                                        cpu_udma_ctrl_req_valid_net;            
  logic                                        cpu_udma_ctrl_req_ready_net;            
  logic [3:0]                                  cpu_udma_ctrl_req_rd_byte_en_net;       
  logic [3:0]                                  cpu_udma_ctrl_req_wr_byte_en_net;  
  logic                                        cpu_udma_ctrl_req_read_net; 
  logic                                        cpu_udma_ctrl_req_write_net;       
  logic [l_opsrv_cfg_udma_ctrl_addr_width-1:0] cpu_udma_ctrl_req_addr_net;             
  logic                                        cpu_udma_ctrl_req_addr_p_net;           
  logic [31:0]                                 cpu_udma_ctrl_req_wr_data_net;          
  logic [3:0]                                  cpu_udma_ctrl_req_wr_data_p_net;        
  logic                                        cpu_udma_ctrl_resp_valid_net;           
  logic                                        cpu_udma_ctrl_resp_ready_net;           
  logic                                        cpu_udma_ctrl_resp_error_net;        
  logic [31:0]                                 cpu_udma_ctrl_resp_rd_data_net; 
  logic                                        cpu_udma_ctrl_irq_net;        
  logic [3:0]                                  cpu_udma_ctrl_resp_rd_data_p_net;   
  logic                                        udma_trx_os_d_rd_net;
  logic                                        udma_trx_os_d_wr_net;    
  
  logic                                        lmem0_dap_req_valid_net;              
  logic                                        lmem0_dap_req_ready_net;              
  logic [3:0]                                  lmem0_dap_req_rd_byte_en_net;         
  logic [3:0]                                  lmem0_dap_req_wr_byte_en_net;         
  logic [l_opsrv_cfg_lmem0_addr_width-1:0]     lmem0_dap_req_addr_net;          
  logic                                        lmem0_dap_req_addr_p_net;     
  logic [31:0]                                 lmem0_dap_req_wr_data_net;            
  logic [3:0]                                  lmem0_dap_req_wr_data_p_net;          
  logic                                        lmem0_dap_resp_valid_net;             
  logic                                        lmem0_dap_resp_ready_net;             
  logic                                        lmem0_dap_resp_rd_error_net;          
  logic [31:0]                                 lmem0_dap_resp_rd_data_net;           
  logic [3:0]                                  lmem0_dap_resp_rd_data_p_net;       
  logic                                        lmem1_dap_req_valid_net;              
  logic                                        lmem1_dap_req_ready_net;              
  logic [3:0]                                  lmem1_dap_req_rd_byte_en_net;         
  logic [3:0]                                  lmem1_dap_req_wr_byte_en_net;         
  logic [l_opsrv_cfg_lmem1_addr_width-1:0]     lmem1_dap_req_addr_net;      
  logic                                        lmem1_dap_req_addr_p_net;         
  logic [31:0]                                 lmem1_dap_req_wr_data_net;            
  logic [3:0]                                  lmem1_dap_req_wr_data_p_net;          
  logic                                        lmem1_dap_resp_valid_net;             
  logic                                        lmem1_dap_resp_ready_net;             
  logic                                        lmem1_dap_resp_rd_error_net;          
  logic [31:0]                                 lmem1_dap_resp_rd_data_net;           
  logic [3:0]                                  lmem1_dap_resp_rd_data_p_net;         
  logic                                        lmem_dap_udma_ctrl_req_valid_net;     
  logic                                        lmem_dap_udma_ctrl_req_ready_net;     
  logic [3:0]                                  lmem_dap_udma_ctrl_req_rd_byte_en_net;
  logic [3:0]                                  lmem_dap_udma_ctrl_req_wr_byte_en_net;
  logic [l_opsrv_cfg_udma_ctrl_addr_width-1:0] lmem_dap_udma_ctrl_req_addr_net;      
  logic                                        lmem_dap_udma_ctrl_req_addr_p_net;    
  logic [31:0]                                 lmem_dap_udma_ctrl_req_wr_data_net;   
  logic [3:0]                                  lmem_dap_udma_ctrl_req_wr_data_p_net; 
  logic                                        lmem_dap_udma_ctrl_resp_valid_net;    
  logic                                        lmem_dap_udma_ctrl_resp_ready_net;    
  logic                                        lmem_dap_udma_ctrl_resp_rd_error_net; 
  logic [31:0]                                 lmem_dap_udma_ctrl_resp_rd_data_net;  
  logic [3:0]                                  lmem_dap_udma_ctrl_resp_rd_data_p_net;    
  
  logic                                        udma_lmem0_req_valid_net;       
  logic                                        udma_lmem0_req_ready_net;       
  logic [3:0]                                  udma_lmem0_req_rd_byte_en_net;  
  logic [3:0]                                  udma_lmem0_req_wr_byte_en_net;  
  logic [l_opsrv_cfg_lmem0_addr_width-1:0]     udma_lmem0_req_addr_net;        
  logic                                        udma_lmem0_req_addr_p_net;      
  logic [3:0]                                  udma_lmem0_req_len_net;         
  logic [31:0]                                 udma_lmem0_req_wr_data_net;     
  logic [3:0]                                  udma_lmem0_req_wr_data_p_net;  
  logic                                        udma_lmem0_req_read_net; 
  logic                                        udma_lmem0_req_write_net;   
  logic                                        udma_lmem0_resp_valid_net;      
  logic                                        udma_lmem0_resp_ready_net;      
  logic                                        udma_lmem0_resp_rd_error_net;   
  logic [31:0]                                 udma_lmem0_resp_rd_data_net;    
  logic [3:0]                                  udma_lmem0_resp_rd_data_p_net;  
  
  logic                                        udma_lmem1_req_valid_net;       
  logic                                        udma_lmem1_req_ready_net;       
  logic [3:0]                                  udma_lmem1_req_rd_byte_en_net;  
  logic [3:0]                                  udma_lmem1_req_wr_byte_en_net;  
  logic                                        udma_lmem1_req_read_net; 
  logic                                        udma_lmem1_req_write_net;
  logic [l_opsrv_cfg_lmem1_addr_width-1:0]     udma_lmem1_req_addr_net;        
  logic                                        udma_lmem1_req_addr_p_net;      
  logic [3:0]                                  udma_lmem1_req_len_net;         
  logic [31:0]                                 udma_lmem1_req_wr_data_net;     
  logic [3:0]                                  udma_lmem1_req_wr_data_p_net;   
  logic                                        udma_lmem1_resp_valid_net;       
  logic                                        udma_lmem1_resp_ready_net;      
  logic                                        udma_lmem1_resp_rd_error_net;   
  logic [31:0]                                 udma_lmem1_resp_rd_data_net;    
  logic [3:0]                                  udma_lmem1_resp_rd_data_p_net;  
  
  logic                                        udma_axi_req_valid_net;       
  logic                                        udma_axi_req_ready_net;       
  logic [3:0]                                  udma_axi_req_rd_byte_en_net;  
  logic [3:0]                                  udma_axi_req_wr_byte_en_net;  
  logic                                        udma_axi_req_read_net;
  logic                                        udma_axi_req_write_net;
  logic [AXI_MSTR_ADDR_WIDTH-1:0]              udma_axi_req_addr_net;        
  logic                                        udma_axi_req_addr_p_net;      
  logic [3:0]                                  udma_axi_req_len_net;         
  logic [31:0]                                 udma_axi_req_wr_data_net;     
  logic [3:0]                                  udma_axi_req_wr_data_p_net;   
  logic                                        udma_axi_req_wr_data_last_net;
  logic                                        udma_axi_resp_valid_net;      
  logic                                        udma_axi_resp_last_net;       
  logic                                        udma_axi_resp_ready_net;      
  logic                                        udma_axi_resp_rd_error_net;   
  logic [31:0]                                 udma_axi_resp_rd_data_net;    
  logic [3:0]                                  udma_axi_resp_rd_data_p_net;    
  logic                                        udma_axi_wr_resp_err_net;
  
  logic                                        udma_ahb_req_valid_net;       
  logic                                        udma_ahb_req_ready_net;       
  logic [3:0]                                  udma_ahb_req_rd_byte_en_net;  
  logic [3:0]                                  udma_ahb_req_wr_byte_en_net; 
  logic                                        udma_ahb_req_read_net; 
  logic                                        udma_ahb_req_write_net; 
  logic [AHB_MSTR_ADDR_WIDTH-1:0]              udma_ahb_req_addr_net;        
  logic                                        udma_ahb_req_addr_p_net;      
  logic [3:0]                                  udma_ahb_req_len_net;         
  logic [31:0]                                 udma_ahb_req_wr_data_net;     
  logic [3:0]                                  udma_ahb_req_wr_data_p_net;   
  logic                                        udma_ahb_req_wr_data_last_net;
  logic                                        udma_ahb_resp_valid_net;      
  logic                                        udma_ahb_resp_last_net;       
  logic                                        udma_ahb_resp_ready_net;      
  logic                                        udma_ahb_resp_rd_error_net;   
  logic [31:0]                                 udma_ahb_resp_rd_data_net;    
  logic [3:0]                                  udma_ahb_resp_rd_data_p_net; 
  logic [1:0]                                  opsrv_irq;    
  logic [63:0]                                 mtime_count_sel;
  logic                                        m_timer_irq_sel;
  logic [63:0]                                 mtime_count_int;
  logic                                        m_timer_irq_int;
     
  logic                                        core_soft_reset_net; //net for connecting the core_soft_reset output of the interconnect to the core_soft_reset input to the MIV_RV32IMC_core
  logic                                        core_soft_irq_net;   //net for conecting the core_soft_irq output of the interconnecto to the m_sw_irq input to the ACT_UNIQUE_core
//********************************************************************************
// Main code
//********************************************************************************

// CPU Core and debug
//--------------------------------------------

// submicron core instance

  MIV_RV32IMC_core
  #(    
    .I_ADDR_WIDTH                       (l_opsrv_cfg_cpu_addr_width        ),
    .D_ADDR_WIDTH                       (l_opsrv_cfg_cpu_addr_width        ),
    .I_DATA_BYTES                       (L_XLEN/8                          ),
    .D_DATA_BYTES                       (L_XLEN/8                          ),
	.l_submicron_cfg_hw_debug           (l_submicron_cfg_hw_debug          ),
    .l_submicron_cfg_hw_multiply_divide (l_submicron_cfg_hw_multiply_divide),
    .l_submicron_cfg_hw_compressed      (l_submicron_cfg_hw_compressed     ),
    .l_submicron_reset_vector           (l_submicron_reset_vector          ),
    .l_submicron_static_mtvec_base      (l_submicron_static_mtvec_base     ),
    .l_submicron_cfg_static_mtvec_base  (l_submicron_cfg_static_mtvec_base ),
    .l_submicron_cfg_static_mtvec_mode  (l_submicron_cfg_static_mtvec_mode ),
    .l_submicron_static_mtvec_mode      (l_submicron_static_mtvec_mode     ),
	.l_submicron_num_sys_ext_irqs       (l_submicron_num_sys_ext_irqs      ),
	.l_submicron_cfg_hw_macc_multiplier (l_submicron_cfg_hw_macc_multiplier),
	.l_submicron_cfg_time_count_width   (l_submicron_cfg_time_count_width),
    .l_submicron_cfg_lsu_fwd            (l_submicron_cfg_lsu_fwd),
    .l_submicron_cfg_csr_fwd            (l_submicron_cfg_csr_fwd),
    .l_submicron_cfg_exu_fwd            (l_submicron_cfg_exu_fwd),
	.l_submicron_cfg_gpr_type           (l_submicron_cfg_gpr_type),
	.ECC_ENABLE                         (ECC_ENABLE)
	
  )
  u_core_0
  (
  .clk                                  (clk                            ),
  .resetn                               (resetn                         ),
  .core_soft_reset                      (core_soft_reset_net            ), //core_soft_reset output from interconnect connected to sub_micron core here
  .parity_en                            (opsrv_parity_en_net            ),
  .gpr_uncorrectable_ecc_error          (gpr_uncorrectable_ecc_error    ),
  .time_count                           (mtime_count_sel                 ),
  .hart_id                              (hart_id                        ),
  .ifu_emi_req_valid                    (cpu_i_req_valid_net            ),
  .ifu_emi_req_ready                    (cpu_i_req_ready_net            ),
  .ifu_emi_req_rd_byte_en               (cpu_i_req_rd_byte_en_net       ),
  .ifu_emi_req_addr                     (cpu_i_req_addr_net             ),
  .ifu_emi_req_addr_p                   (cpu_i_req_addr_p_net           ),
  .ifu_emi_resp_valid                   (cpu_i_resp_valid_net           ),
  .ifu_emi_resp_ready                   (cpu_i_resp_ready_net           ),
  .ifu_emi_resp_data                    (cpu_i_resp_rd_data_net         ),
  .ifu_emi_resp_data_p                  (cpu_i_resp_rd_data_p_net       ),
  .ifu_emi_resp_error                   (cpu_i_resp_error_net           ),
  .lsu_emi_req_valid                    (cpu_d_req_valid_net            ),
  .lsu_emi_req_ready                    (cpu_d_req_ready_net            ),
  .lsu_emi_req_rd_byte_en               (cpu_d_req_rd_byte_en_net       ),
  .lsu_emi_req_wr_byte_en               (cpu_d_req_wr_byte_en_net       ),
  .lsu_emi_req_addr                     (cpu_d_req_addr_net             ),
  .lsu_emi_req_addr_p                   (cpu_d_req_addr_p_net           ),
  .lsu_emi_req_fence                    (cpu_d_req_fence_net            ),
  .lsu_emi_req_read                     (cpu_d_req_read_net             ),
  .lsu_emi_req_write                    (cpu_d_req_write_net            ),
  .lsu_emi_req_wr_data                  (cpu_d_req_wr_data_net          ),
  .lsu_emi_req_wr_data_p                (cpu_d_req_wr_data_p_net        ),
  .lsu_emi_resp_valid                   (cpu_d_resp_valid_net           ),
  .lsu_emi_resp_ready                   (cpu_d_resp_ready_net           ),
  .lsu_emi_resp_error                   (cpu_d_resp_error_net           ),
  .lsu_emi_resp_rd_data                 (cpu_d_resp_rd_data_net         ),
  .lsu_emi_resp_rd_data_p               (cpu_d_resp_rd_data_p_net       ),
  .debug_reset                          (cpu_debug_reset_net            ), 
  .debug_core_reset                     (cpu_debug_core_reset_net       ),
  .debug_active                         (cpu_debug_active_net           ),
  
   
  .debug_csr_gpr_req_wr_data            (cpu_debug_op_wr_data_net          ),  
  .debug_csr_req_valid                  (cpu_debug_csr_op_valid_net        ), 
  .debug_csr_req_ready                  (cpu_debug_csr_op_ready_net        ), 
  .debug_csr_req_wr_en                  (cpu_debug_csr_wr_en_net           ),  
  .debug_csr_req_rd_en                  (cpu_debug_csr_rd_en_net           ),  
  .debug_csr_req_addr                   (cpu_debug_csr_op_addr_net         ),
  .debug_csr_resp_rd_data               (cpu_debug_csr_op_rd_data_net      ),
  .debug_csr_resp_valid                 (cpu_debug_csr_op_rd_data_valid_net),
  .debug_csr_resp_ready                 (cpu_debug_csr_op_rd_data_ready_net),
  .debug_gpr_req_valid                  (cpu_debug_gpr_op_valid_net        ), 
  .debug_gpr_req_ready                  (cpu_debug_gpr_op_ready_net        ),   
  .debug_gpr_req_wr_en                  (cpu_debug_gpr_wr_en_net           ),
  .debug_gpr_req_rd_en                  (cpu_debug_gpr_rd_en_net           ), 
  .debug_gpr_req_addr                   (cpu_debug_gpr_op_addr_net         ),    
  .debug_gpr_resp_rd_data               (cpu_debug_gpr_op_rd_data_net      ), 
  .debug_gpr_resp_valid                 (cpu_debug_gpr_op_rd_data_valid_net), 
  .debug_gpr_resp_ready                 (cpu_debug_gpr_op_rd_data_ready_net),   
  
  
  .debug_halt_req                       (cpu_debug_halt_req_net         ),
  .debug_halt_ack                       (cpu_debug_halt_ack_net         ),
  .debug_resethalt_req                  (cpu_debug_resethalt_req_net    ),
  .debug_resethalt_ack                  (cpu_debug_resethalt_ack_net    ),
  .debug_resume_req                     (cpu_debug_resume_req_net       ),
  .debug_resume_ack                     (cpu_debug_resume_ack_net       ),
  .debug_mode                           (cpu_debug_mode_net             ),
  .m_sw_irq                             (core_soft_irq_net              ),
  .m_timer_irq                          (m_timer_irq_sel                ),
  .m_external_irq                       (m_external_irq                 ),
  .sys_ext_irq_src                      (sys_ext_irq_src_net            ),
  .formal_trace_instr                   (                               ), //open      
  .formal_trace_pc                      (                               ), //open      
  .formal_trace_reset_taken             (                               ), //open   
  .formal_trace_instr_retire            (                               )  //open      
  );
  
  assign sys_ext_irq_src_net = {opsrv_irq,m_sys_ext_irq[5:0]}; 
  
 generate if(l_opsrv_cfg_submicron_debug)
 begin : gen_opsrv_debug
 
  MIV_RV32IMC_opsrv_debug #( .l_opsrv_cfg_submicron_debug(l_opsrv_cfg_submicron_debug))

  u_opsrv_debug_unit_0
  (
  .clk                            (clk                               ),
  .resetn                         (resetn                            ),                                                                       
  .jtag_trst                      (jtag_trst                        ),  
  .jtag_tck                       (jtag_tck                          ),  
  .jtag_tdi                       (jtag_tdi                          ),  
  .jtag_tms                       (jtag_tms                          ),  
  .jtag_tdo                       (jtag_tdo                          ),  
  .jtag_tdo_dr                    (jtag_tdo_dr                       ),
  .debug_reset                    (cpu_debug_reset_net               ), 
  .debug_core_reset               (cpu_debug_core_reset_net          ), 
  .debug_sys_reset                (debug_sys_reset                   ),
  .debug_active                   (cpu_debug_active_net              ),
  
  .debug_op_wr_data               (cpu_debug_op_wr_data_net          ),
  
  .debug_csr_valid                (cpu_debug_csr_op_valid_net        ),
  .debug_csr_ready                (cpu_debug_csr_op_ready_net        ),
  .debug_csr_wr_en                (cpu_debug_csr_wr_en_net           ),
  .debug_csr_rd_en                (cpu_debug_csr_rd_en_net           ),
  .debug_csr_addr                 (cpu_debug_csr_op_addr_net         ),
  .debug_csr_rd_data              (cpu_debug_csr_op_rd_data_net      ),
  .debug_csr_rd_data_valid        (cpu_debug_csr_op_rd_data_valid_net),
  .debug_csr_rd_data_ready        (cpu_debug_csr_op_rd_data_ready_net),
  
  .debug_gpr_valid                (cpu_debug_gpr_op_valid_net        ),
  .debug_gpr_ready                (cpu_debug_gpr_op_ready_net        ),
  .debug_gpr_wr_en                (cpu_debug_gpr_wr_en_net           ),
  .debug_gpr_rd_en                (cpu_debug_gpr_rd_en_net           ),
  .debug_gpr_addr                 (cpu_debug_gpr_op_addr_net         ),
  .debug_gpr_rd_data              (cpu_debug_gpr_op_rd_data_net      ),
  .debug_gpr_rd_data_valid        (cpu_debug_gpr_op_rd_data_valid_net),
  .debug_gpr_rd_data_ready        (cpu_debug_gpr_op_rd_data_ready_net),
  
  .debug_halt_req                 (cpu_debug_halt_req_net            ),   
  .debug_halt_ack                 (cpu_debug_halt_ack_net            ),    
  .debug_resethalt_req            (cpu_debug_resethalt_req_net       ),
  //.debug_resethalt_ack            (cpu_debug_resethalt_ack_net       ), 
  .debug_resume_req               (cpu_debug_resume_req_net          ),   
  .debug_resume_ack               (cpu_debug_resume_ack_net          ),   
  .debug_mode                     (cpu_debug_mode_net                ),   
  .debug_trx_os                   (debug_trx_os_net                  ),   
  .debug_sysbus_req_valid         (debug_sysbus_req_valid_net        ),   
  .debug_sysbus_req_ready         (debug_sysbus_req_ready_net        ),   
  .debug_sysbus_req_rd_byte_en    (debug_sysbus_req_rd_byte_en_net   ),   
  .debug_sysbus_req_wr_byte_en    (debug_sysbus_req_wr_byte_en_net   ),   
  .debug_sysbus_req_addr          (debug_sysbus_req_addr_net         ),   
  .debug_sysbus_req_wr_data       (debug_sysbus_req_wr_data_net      ),   
  .debug_sysbus_resp_valid        (debug_sysbus_resp_valid_net       ),   
  .debug_sysbus_resp_ready        (debug_sysbus_resp_ready_net       ),   
  .debug_sysbus_resp_error        (debug_sysbus_resp_error_net       ),   
  .debug_sysbus_resp_rd_data      (debug_sysbus_resp_rd_data_net     )                                                                                                                                          
  );
  
  end
  else begin :ngen_opsrv_debug

    assign jtag_tdo                           = 1'b0;             
    assign jtag_tdo_dr                        = 1'b0;             
    assign cpu_debug_reset_net                = 1'b0;             
    assign cpu_debug_core_reset_net           = 1'b0;             
    assign debug_sys_reset                    = 1'b0;             
    assign cpu_debug_active_net               = 1'b0;             
    assign cpu_debug_op_wr_data_net           = {L_XLEN{1'b0}};
    assign cpu_debug_csr_op_valid_net         = 1'b0;   
    assign cpu_debug_csr_wr_en_net            = 1'b0;             
    assign cpu_debug_csr_rd_en_net            = 1'b0;             
    assign cpu_debug_csr_op_addr_net          = {12{1'b0}}; 
    assign cpu_debug_csr_op_rd_data_ready_net = 1'b0;  
    assign cpu_debug_gpr_op_valid_net         = 1'b0;    
    assign cpu_debug_gpr_wr_en_net            = 1'b0;             
    assign cpu_debug_gpr_rd_en_net            = 1'b0;             
    assign cpu_debug_gpr_op_addr_net          = {5{1'b0}}; 
    assign cpu_debug_gpr_op_rd_data_ready_net = 1'b0;       
    assign cpu_debug_halt_req_net             = 1'b0;     
    assign cpu_debug_resume_req_net           = 1'b0;        
    assign debug_sysbus_req_valid_net         = 1'b0;             
    assign debug_sysbus_req_rd_byte_en_net    = {4{1'b0}};        
    assign debug_sysbus_req_wr_byte_en_net    = {4{1'b0}};        
    assign debug_sysbus_req_addr_net          = 1'b0;             
    assign debug_sysbus_req_wr_data_net       = {L_XLEN{1'b0}};   
    assign debug_sysbus_resp_ready_net        = {L_XLEN{1'b0}};   
    

    
  end
  endgenerate

// OPSRV Interconnect
//--------------------------------------------

  MIV_RV32IMC_opsrv_interconnect
  #(    
    .CPU_ADDR_WIDTH                        (l_opsrv_cfg_cpu_addr_width           ),
    .AXI_MSTR_ADDR_WIDTH                   (AXI_MSTR_ADDR_WIDTH                  ),
    .APB_MSTR_ADDR_WIDTH                   (APB_MSTR_ADDR_WIDTH                  ),
    .AHB_MSTR_ADDR_WIDTH                   (AHB_MSTR_ADDR_WIDTH                  ),
	.ECC_ENABLE                            (ECC_ENABLE                           ),
    .UDMA_CTRL_ADDR_WIDTH                  (l_opsrv_cfg_udma_ctrl_addr_width     ),
    .LMEM0_ADDR_WIDTH                      (l_opsrv_cfg_lmem0_addr_width         ),
    .LMEM1_ADDR_WIDTH                      (l_opsrv_cfg_lmem1_addr_width         ),
    .l_opsrv_cfg_lmem0_present             (l_opsrv_cfg_lmem0_present            ),
    .l_opsrv_cfg_axi_mstr_present          (l_opsrv_cfg_axi_mstr_present         ),
    .l_opsrv_cfg_ahb_mstr_present          (l_opsrv_cfg_ahb_mstr_present         )
  )
  u_opsrv_interconnect_0
  (
    .clk                                   (clk                            ),
    .resetn                                (resetn                         ),
    .axi_rd_cfg_min_size                   (axi_rd_cfg_min_size_net        ),
    .axi_wr_cfg_min_size                   (axi_wr_cfg_min_size_net        ),
    .opsrv_parity_en                       (opsrv_parity_en_net            ),
    .sys_parity_disable                    (sys_parity_disable             ),
    .cfg_fence_all_src                     (cfg_fence_all_src_net          ),
    .cfg_ar_cache                          (cfg_ar_cache_net               ),
    .cfg_aw_cache                          (cfg_aw_cache_net               ),
    .cfg_raw_hzd_check                     (cfg_raw_hzd_check_net          ),
    .cfg_war_hzd_check                     (cfg_war_hzd_check_net          ),
    .lmem0_uncorrectable_ecc_error         (lmem0_uncorrectable_ecc_error  ),
    .lmem1_uncorrectable_ecc_error         (lmem1_uncorrectable_ecc_error  ),
    .opsrv_irq                             (opsrv_irq                      ),
    .cfg_axi_mstr_start_addr               (l_axi_mstr_start_addr          ),
    .cfg_axi_mstr_end_addr                 (l_axi_mstr_end_addr            ),
    .cfg_apb_mstr_start_addr               (l_apb_mstr_start_addr          ),
    .cfg_apb_mstr_end_addr                 (l_apb_mstr_end_addr            ),
    .cfg_ahb_mstr_start_addr               (l_ahb_mstr_start_addr          ),
    .cfg_ahb_mstr_end_addr                 (l_ahb_mstr_end_addr            ),
    .cfg_udma_ctrl_start_addr              (l_udma_ctrl_start_addr         ),
    .cfg_udma_ctrl_end_addr                (l_udma_ctrl_end_addr           ),
    .cfg_opsrv_cfg_start_addr              (l_opsrv_cfg_start_addr         ),
    .cfg_opsrv_cfg_end_addr                (l_opsrv_cfg_end_addr           ),
    .cfg_lmem0_start_addr                  (l_lmem0_start_addr             ),
    .cfg_lmem0_end_addr                    (l_lmem0_end_addr               ),
    .cfg_lmem1_start_addr                  (l_lmem1_start_addr             ),
    .cfg_lmem1_end_addr                    (l_lmem1_end_addr               ), 
    .cpu_i_req_valid                       (cpu_i_req_valid_net            ),
    .cpu_i_req_ready                       (cpu_i_req_ready_net            ),
    .cpu_i_req_rd_byte_en                  (cpu_i_req_rd_byte_en_net       ),
    .cpu_i_req_addr                        (cpu_i_req_addr_net             ),
    .cpu_i_req_addr_p                      (cpu_i_req_addr_p_net           ),
    .cpu_i_resp_valid                      (cpu_i_resp_valid_net           ),
    .cpu_i_resp_ready                      (cpu_i_resp_ready_net           ),
    .cpu_i_resp_error                      (cpu_i_resp_error_net           ),
    .cpu_i_resp_rd_data                    (cpu_i_resp_rd_data_net         ),
    .cpu_i_resp_rd_data_p                  (cpu_i_resp_rd_data_p_net       ),
    .cpu_d_req_valid                       (cpu_d_req_valid_net            ),
    .cpu_d_req_ready                       (cpu_d_req_ready_net            ),
    .cpu_d_req_rd_byte_en                  (cpu_d_req_rd_byte_en_net       ),
    .cpu_d_req_wr_byte_en                  (cpu_d_req_wr_byte_en_net       ),
    .cpu_d_req_addr                        (cpu_d_req_addr_net             ),
    .cpu_d_req_addr_p                      (cpu_d_req_addr_p_net           ),
    .cpu_d_req_fence                       (cpu_d_req_fence_net            ),
    .cpu_d_req_read                        (cpu_d_req_read_net             ),
    .cpu_d_req_write                       (cpu_d_req_write_net            ),
    .cpu_d_req_wr_data                     (cpu_d_req_wr_data_net          ),
    .cpu_d_req_wr_data_p                   (cpu_d_req_wr_data_p_net        ),
    .cpu_d_resp_valid                      (cpu_d_resp_valid_net           ),
    .cpu_d_resp_ready                      (cpu_d_resp_ready_net           ),
    .cpu_d_resp_error                      (cpu_d_resp_error_net           ),
    .cpu_d_resp_rd_data                    (cpu_d_resp_rd_data_net         ),
    .cpu_d_resp_rd_data_p                  (cpu_d_resp_rd_data_p_net       ),
    .debug_mode                            (cpu_debug_mode_net             ),
    .debug_trx_os                          (debug_trx_os_net               ),  
    .debug_sysbus_req_valid                (debug_sysbus_req_valid_net     ),
    .debug_sysbus_req_ready                (debug_sysbus_req_ready_net     ),
    .debug_sysbus_req_rd_byte_en           (debug_sysbus_req_rd_byte_en_net),
    .debug_sysbus_req_wr_byte_en           (debug_sysbus_req_wr_byte_en_net),
    .debug_sysbus_req_addr                 (debug_sysbus_req_addr_net      ),
    .debug_sysbus_req_wr_data              (debug_sysbus_req_wr_data_net   ),
    .debug_sysbus_resp_valid               (debug_sysbus_resp_valid_net    ),
    .debug_sysbus_resp_ready               (debug_sysbus_resp_ready_net    ),
    .debug_sysbus_resp_error               (debug_sysbus_resp_error_net    ),
    .debug_sysbus_resp_rd_data             (debug_sysbus_resp_rd_data_net  ),
    .apb_mstr_i_req_valid                  (apb_mstr_i_req_valid_net       ),
    .apb_mstr_i_req_ready                  (apb_mstr_i_req_ready_net       ),
    .apb_mstr_i_req_rd_byte_en             (apb_mstr_i_req_rd_byte_en_net  ),
    .apb_mstr_i_req_addr                   (apb_mstr_i_req_addr_net        ),
    .apb_mstr_i_req_addr_p                 (apb_mstr_i_req_addr_p_net      ),
    .apb_mstr_i_resp_valid                 (apb_mstr_i_resp_valid_net      ),
    .apb_mstr_i_resp_ready                 (apb_mstr_i_resp_ready_net      ),
    .apb_mstr_i_resp_error                 (apb_mstr_i_resp_error_net      ),
    .apb_mstr_i_resp_rd_data               (apb_mstr_i_resp_rd_data_net    ),
    .apb_mstr_i_resp_rd_data_p             (apb_mstr_i_resp_rd_data_p_net  ),
    .apb_mstr_d_req_valid                  (apb_mstr_d_req_valid_net       ),
    .apb_mstr_d_req_ready                  (apb_mstr_d_req_ready_net       ),
    .apb_mstr_d_req_rd_byte_en             (apb_mstr_d_req_rd_byte_en_net  ),
    .apb_mstr_d_req_wr_byte_en             (apb_mstr_d_req_wr_byte_en_net  ),
    //.apb_mstr_d_req_read                   (apb_mstr_d_req_read_net        ),
    //.apb_mstr_d_req_write                  (apb_mstr_d_req_write_net       ),
    .apb_mstr_d_req_addr                   (apb_mstr_d_req_addr_net        ),
    .apb_mstr_d_req_addr_p                 (apb_mstr_d_req_addr_p_net      ),
    .apb_mstr_d_req_wr_data                (apb_mstr_d_req_wr_data_net     ),
    .apb_mstr_d_req_wr_data_p              (apb_mstr_d_req_wr_data_p_net   ),
    .apb_mstr_d_resp_valid                 (apb_mstr_d_resp_valid_net      ),
    .apb_mstr_d_resp_ready                 (apb_mstr_d_resp_ready_net      ),
    .apb_mstr_d_resp_error                 (apb_mstr_d_resp_error_net      ),
    .apb_mstr_d_resp_rd_data               (apb_mstr_d_resp_rd_data_net    ),
    .apb_mstr_d_resp_rd_data_p             (apb_mstr_d_resp_rd_data_p_net  ),
    .apb_mstr_trx_os_d_rd                  (apb_mstr_trx_os_d_rd_net       ),
    .apb_mstr_trx_os_d_wr                  (apb_mstr_trx_os_d_wr_net       ),
    .lmem0_i_req_valid                     (lmem0_i_req_valid_net          ),
    .lmem0_i_req_ready                     (lmem0_i_req_ready_net          ),
    .lmem0_i_req_rd_byte_en                (lmem0_i_req_rd_byte_en_net     ),
    .lmem0_i_req_addr                      (lmem0_i_req_addr_net           ),
    .lmem0_i_req_addr_p                    (lmem0_i_req_addr_p_net         ),
    .lmem0_i_resp_valid                    (lmem0_i_resp_valid_net         ),
    .lmem0_i_resp_ready                    (lmem0_i_resp_ready_net         ),
    .lmem0_i_resp_error                    (lmem0_i_resp_error_net         ),
    .lmem0_i_resp_rd_data                  (lmem0_i_resp_rd_data_net       ),
    .lmem0_i_resp_rd_data_p                (lmem0_i_resp_rd_data_p_net     ),
    .lmem0_d_req_valid                     (lmem0_d_req_valid_net          ),
    .lmem0_d_req_ready                     (lmem0_d_req_ready_net          ),
    .lmem0_d_req_rd_byte_en                (lmem0_d_req_rd_byte_en_net     ),
    .lmem0_d_req_wr_byte_en                (lmem0_d_req_wr_byte_en_net     ),
    .lmem0_d_req_read                      (lmem0_d_req_read_net           ),
    .lmem0_d_req_write                     (lmem0_d_req_write_net          ),
    .lmem0_d_req_addr                      (lmem0_d_req_addr_net           ),
    .lmem0_d_req_addr_p                    (lmem0_d_req_addr_p_net         ),
    .lmem0_d_req_wr_data                   (lmem0_d_req_wr_data_net        ),
    .lmem0_d_req_wr_data_p                 (lmem0_d_req_wr_data_p_net      ),
    .lmem0_d_resp_valid                    (lmem0_d_resp_valid_net         ),
    .lmem0_d_resp_ready                    (lmem0_d_resp_ready_net         ),
    .lmem0_d_resp_error                    (lmem0_d_resp_error_net         ),
    .lmem0_d_resp_rd_data                  (lmem0_d_resp_rd_data_net       ),
    .lmem0_d_resp_rd_data_p                (lmem0_d_resp_rd_data_p_net     ),     
    .lmem0_trx_os_d_rd                     (lmem0_trx_os_d_rd_net          ),
    .lmem0_trx_os_d_wr                     (lmem0_trx_os_d_wr_net          ), 
    .lmem0_ecc_err_correctable             (lmem0_ecc_err_correctable_net  ),
    .lmem0_ecc_err_uncorrectable           (lmem0_ecc_err_uncorrectable_net),    
    .lmem1_i_req_valid                     (lmem1_i_req_valid_net          ),
    .lmem1_i_req_ready                     (lmem1_i_req_ready_net          ),
    .lmem1_i_req_rd_byte_en                (lmem1_i_req_rd_byte_en_net     ),
    .lmem1_i_req_addr                      (lmem1_i_req_addr_net           ),
    .lmem1_i_req_addr_p                    (lmem1_i_req_addr_p_net         ),
    .lmem1_i_resp_valid                    (lmem1_i_resp_valid_net         ),
    .lmem1_i_resp_ready                    (lmem1_i_resp_ready_net         ),
    .lmem1_i_resp_error                    (lmem1_i_resp_error_net         ),
    .lmem1_i_resp_rd_data                  (lmem1_i_resp_rd_data_net       ),
    .lmem1_i_resp_rd_data_p                (lmem1_i_resp_rd_data_p_net     ),
    .lmem1_d_req_valid                     (lmem1_d_req_valid_net          ),
    .lmem1_d_req_ready                     (lmem1_d_req_ready_net          ),
    .lmem1_d_req_rd_byte_en                (lmem1_d_req_rd_byte_en_net     ),
    .lmem1_d_req_wr_byte_en                (lmem1_d_req_wr_byte_en_net     ),
    .lmem1_d_req_read                      (lmem1_d_req_read_net           ),
    .lmem1_d_req_write                     (lmem1_d_req_write_net          ),
    .lmem1_d_req_addr                      (lmem1_d_req_addr_net           ),
    .lmem1_d_req_addr_p                    (lmem1_d_req_addr_p_net         ),
    .lmem1_d_req_wr_data                   (lmem1_d_req_wr_data_net        ),
    .lmem1_d_req_wr_data_p                 (lmem1_d_req_wr_data_p_net      ),
    .lmem1_d_resp_valid                    (lmem1_d_resp_valid_net         ),
    .lmem1_d_resp_ready                    (lmem1_d_resp_ready_net         ),
    .lmem1_d_resp_error                    (lmem1_d_resp_error_net         ),
    .lmem1_d_resp_rd_data                  (lmem1_d_resp_rd_data_net       ),
    .lmem1_d_resp_rd_data_p                (lmem1_d_resp_rd_data_p_net     ),     
    .lmem1_trx_os_d_rd                     (lmem1_trx_os_d_rd_net          ),
    .lmem1_trx_os_d_wr                     (lmem1_trx_os_d_wr_net          ),  
    .lmem1_ecc_err_correctable             (lmem1_ecc_err_correctable_net  ),
    .lmem1_ecc_err_uncorrectable           (lmem1_ecc_err_uncorrectable_net), 
    .axi_mstr_i_req_valid                  (axi_mstr_i_req_valid_net       ),
    .axi_mstr_i_req_ready                  (axi_mstr_i_req_ready_net       ),
    .axi_mstr_i_req_rd_byte_en             (axi_mstr_i_req_rd_byte_en_net  ),
    .axi_mstr_i_req_addr                   (axi_mstr_i_req_addr_net        ),
    .axi_mstr_i_req_addr_p                 (axi_mstr_i_req_addr_p_net      ),
    .axi_mstr_i_resp_valid                 (axi_mstr_i_resp_valid_net      ),
    .axi_mstr_i_resp_ready                 (axi_mstr_i_resp_ready_net      ),
    .axi_mstr_i_resp_error                 (axi_mstr_i_resp_error_net      ),
    .axi_mstr_i_resp_rd_data               (axi_mstr_i_resp_rd_data_net    ),
    .axi_mstr_i_resp_rd_data_p             (axi_mstr_i_resp_rd_data_p_net  ),
    .axi_mstr_d_req_valid                  (axi_mstr_d_req_valid_net       ),
    .axi_mstr_d_req_ready                  (axi_mstr_d_req_ready_net       ),
    .axi_mstr_d_req_rd_byte_en             (axi_mstr_d_req_rd_byte_en_net  ),
    .axi_mstr_d_req_wr_byte_en             (axi_mstr_d_req_wr_byte_en_net  ),
    .axi_mstr_d_req_read                   (axi_mstr_d_req_read_net        ),
    .axi_mstr_d_req_write                  (axi_mstr_d_req_write_net       ),
    .axi_mstr_d_req_addr                   (axi_mstr_d_req_addr_net        ),
    .axi_mstr_d_req_addr_p                 (axi_mstr_d_req_addr_p_net      ),
    .axi_mstr_d_req_wr_data                (axi_mstr_d_req_wr_data_net     ),
    .axi_mstr_d_req_wr_data_p              (axi_mstr_d_req_wr_data_p_net   ),
    .axi_mstr_d_resp_valid                 (axi_mstr_d_resp_valid_net      ),
    .axi_mstr_d_resp_ready                 (axi_mstr_d_resp_ready_net      ),
    .axi_mstr_d_resp_rd_error              (axi_mstr_d_resp_rd_error_net   ),
    .axi_mstr_d_resp_rd_data               (axi_mstr_d_resp_rd_data_net    ),
    .axi_mstr_d_resp_rd_data_p             (axi_mstr_d_resp_rd_data_p_net  ),
    .axi_mstr_d_wr_resp_err                (axi_mstr_d_wr_resp_err_net     ),
    .axi_mstr_trx_os_d_rd                  (axi_mstr_trx_os_d_rd_net       ),
    .axi_mstr_trx_os_d_wr                  (axi_mstr_trx_os_d_wr_net       ),
    .ahb_mstr_i_req_valid                  (ahb_mstr_i_req_valid_net       ),
    .ahb_mstr_i_req_ready                  (ahb_mstr_i_req_ready_net       ),
    .ahb_mstr_i_req_rd_byte_en             (ahb_mstr_i_req_rd_byte_en_net  ),
    .ahb_mstr_i_req_addr                   (ahb_mstr_i_req_addr_net        ),
    .ahb_mstr_i_req_addr_p                 (ahb_mstr_i_req_addr_p_net      ),
    .ahb_mstr_i_resp_valid                 (ahb_mstr_i_resp_valid_net      ),
    .ahb_mstr_i_resp_ready                 (ahb_mstr_i_resp_ready_net      ),
    .ahb_mstr_i_resp_error                 (ahb_mstr_i_resp_error_net      ),
    .ahb_mstr_i_resp_rd_data               (ahb_mstr_i_resp_rd_data_net    ),
    .ahb_mstr_i_resp_rd_data_p             (ahb_mstr_i_resp_rd_data_p_net  ),
    .ahb_mstr_d_req_valid                  (ahb_mstr_d_req_valid_net       ),
    .ahb_mstr_d_req_ready                  (ahb_mstr_d_req_ready_net       ),
    .ahb_mstr_d_req_rd_byte_en             (ahb_mstr_d_req_rd_byte_en_net  ),
    .ahb_mstr_d_req_wr_byte_en             (ahb_mstr_d_req_wr_byte_en_net  ),
    .ahb_mstr_d_req_read                   (ahb_mstr_d_req_read_net        ),
    .ahb_mstr_d_req_write                  (ahb_mstr_d_req_write_net       ),
    .ahb_mstr_d_req_addr                   (ahb_mstr_d_req_addr_net        ),
    .ahb_mstr_d_req_addr_p                 (ahb_mstr_d_req_addr_p_net      ),
    .ahb_mstr_d_req_wr_data                (ahb_mstr_d_req_wr_data_net     ),
    .ahb_mstr_d_req_wr_data_p              (ahb_mstr_d_req_wr_data_p_net   ),
    .ahb_mstr_d_resp_valid                 (ahb_mstr_d_resp_valid_net      ),
    .ahb_mstr_d_resp_ready                 (ahb_mstr_d_resp_ready_net      ),
    .ahb_mstr_d_resp_rd_error              (ahb_mstr_d_resp_rd_error_net   ),
    .ahb_mstr_d_resp_rd_data               (ahb_mstr_d_resp_rd_data_net    ),
    .ahb_mstr_d_resp_rd_data_p             (ahb_mstr_d_resp_rd_data_p_net  ),    
    .ahb_mstr_trx_os_d_rd                  (ahb_mstr_trx_os_d_rd_net       ),
    .ahb_mstr_trx_os_d_wr                  (ahb_mstr_trx_os_d_wr_net       ),   
    .udma_ctrl_d_req_valid                 (cpu_udma_ctrl_req_valid_net    ),
    .udma_ctrl_d_req_ready                 (cpu_udma_ctrl_req_ready_net    ),
    .udma_ctrl_d_req_rd_byte_en            (cpu_udma_ctrl_req_rd_byte_en_net),
    .udma_ctrl_d_req_wr_byte_en            (cpu_udma_ctrl_req_wr_byte_en_net),
    .udma_ctrl_d_req_read                  (cpu_udma_ctrl_req_read_net      ),
    .udma_ctrl_d_req_write                 (cpu_udma_ctrl_req_write_net     ),
    .udma_ctrl_d_req_addr                  (cpu_udma_ctrl_req_addr_net      ),
    .udma_ctrl_d_req_addr_p                (cpu_udma_ctrl_req_addr_p_net    ),
    .udma_ctrl_d_req_wr_data               (cpu_udma_ctrl_req_wr_data_net   ),
    .udma_ctrl_d_req_wr_data_p             (cpu_udma_ctrl_req_wr_data_p_net ),
    .udma_ctrl_d_resp_valid                (cpu_udma_ctrl_resp_valid_net    ),
    .udma_ctrl_d_resp_ready                (cpu_udma_ctrl_resp_ready_net    ),
    .udma_ctrl_d_resp_error                (cpu_udma_ctrl_resp_error_net    ),
    .udma_ctrl_d_resp_rd_data              (cpu_udma_ctrl_resp_rd_data_net  ),
    .udma_ctrl_d_resp_rd_data_p            (cpu_udma_ctrl_resp_rd_data_p_net),
    .udma_ctrl_irq                         (cpu_udma_ctrl_irq_net           ),
    .udma_trx_os_d_rd                      (udma_trx_os_d_rd_net            ),
    .udma_trx_os_d_wr                      (udma_trx_os_d_wr_net            ),
    
    .core_soft_reset                       (core_soft_reset_net),       //core_soft_reset output from interconnect
    .core_soft_irq                         (core_soft_irq_net),          //core_soft_irq output from interconnect
    
    .gpr_ded_soft_reset                    (gpr_uncorrectable_ecc_error)
  );

// APB Master
//--------------------------------------------
// APB Master always present

  generate
  if(l_opsrv_cfg_apb_mstr_present | INTERNAL_MTIME | INTERNAL_MTIME_IRQ) begin: gen_apb_mstr
    MIV_RV32IMC_opsrv_apb_mstr
    #(    
      .APB_MSTR_ADDR_WIDTH                  (APB_MSTR_ADDR_WIDTH            )
    )
    u_apb_master_0
    (
      .clk                                  (clk                            ),
      .presetn                              (resetn                         ),                                            
      .opsrv_parity_en                      (opsrv_parity_en_net            ),
      .trx_os_d_rd                          (apb_mstr_trx_os_d_rd_net       ),
      .trx_os_d_wr                          (apb_mstr_trx_os_d_wr_net       ),
      .cpu_i_req_valid                      (apb_mstr_i_req_valid_net       ),  
      .cpu_i_req_ready                      (apb_mstr_i_req_ready_net       ),  
      .cpu_i_req_rd_byte_en                 (apb_mstr_i_req_rd_byte_en_net  ),  
      .cpu_i_req_addr                       (apb_mstr_i_req_addr_net        ),  
      .cpu_i_req_addr_p                     (apb_mstr_i_req_addr_p_net      ),  
      .cpu_i_resp_valid                     (apb_mstr_i_resp_valid_net      ),  
      .cpu_i_resp_ready                     (apb_mstr_i_resp_ready_net      ),  
      .cpu_i_resp_error                     (apb_mstr_i_resp_error_net      ),  
      .cpu_i_resp_rd_data                   (apb_mstr_i_resp_rd_data_net    ),  
      .cpu_i_resp_rd_data_p                 (apb_mstr_i_resp_rd_data_p_net  ),
      .cpu_d_req_valid                      (apb_mstr_d_req_valid_net       ),  
      .cpu_d_req_ready                      (apb_mstr_d_req_ready_net       ),  
      .cpu_d_req_rd_byte_en                 (apb_mstr_d_req_rd_byte_en_net  ),  
      .cpu_d_req_wr_byte_en                 (apb_mstr_d_req_wr_byte_en_net  ),  
      .cpu_d_req_addr                       (apb_mstr_d_req_addr_net        ),  
      .cpu_d_req_addr_p                     (apb_mstr_d_req_addr_p_net      ),     
      .cpu_d_req_wr_data                    (apb_mstr_d_req_wr_data_net     ),  
      .cpu_d_req_wr_data_p                  (apb_mstr_d_req_wr_data_p_net   ),  
      .cpu_d_resp_valid                     (apb_mstr_d_resp_valid_net      ),  
      .cpu_d_resp_ready                     (apb_mstr_d_resp_ready_net      ),  
      .cpu_d_resp_error                     (apb_mstr_d_resp_error_net      ),  
      .cpu_d_resp_rd_data                   (apb_mstr_d_resp_rd_data_net    ),
      .cpu_d_resp_rd_data_p                 (apb_mstr_d_resp_rd_data_p_net  ),
      .paddr                                (apb_mstr_paddr                 ),
      .paddr_p                              (apb_mstr_paddr_p               ),
      .pprot                                (apb_mstr_pprot                 ),
      .psel                                 (apb_mstr_psel_net           ),
      .penable                              (apb_mstr_penable_net        ),
      .pwrite                               (apb_mstr_pwrite                ),
      .pwdata                               (apb_mstr_pwdata                ),
      .pwdata_p                             (apb_mstr_pwdata_p              ),
      .pstrb                                (apb_mstr_pstrb                 ),
      .pready                               (apb_mstr_pready_net            ),
      .prdata                               (apb_mstr_prdata_net            ),
      .prdata_p                             (apb_mstr_prdata_p              ),
      .pslverr                              (apb_mstr_pslverr_net           )
    );  
  end else begin : ngen_apb_mstr
	assign apb_mstr_trx_os_d_rd_net = 1'b0;
	assign apb_mstr_trx_os_d_wr_net = 1'b0;
	assign apb_mstr_i_req_ready_net = 1'b0; 
	assign apb_mstr_i_resp_valid_net = 1'b0;
	assign apb_mstr_i_resp_error_net = 1'b0;
	assign apb_mstr_i_resp_rd_data_net = 32'b0; 
	assign apb_mstr_i_resp_rd_data_p_net = 4'b0; 
	assign apb_mstr_d_req_ready_net = 1'b0; 
	assign apb_mstr_d_resp_valid_net = 1'b0;
	assign apb_mstr_d_resp_error_net = 1'b0;
	assign apb_mstr_d_resp_rd_data_net = 32'b0;  
	assign apb_mstr_d_resp_rd_data_p_net = 4'b0;   
	assign apb_mstr_paddr = {APB_MSTR_ADDR_WIDTH{1'b0}}; 
	assign apb_mstr_paddr_p = 1'b0;
	assign apb_mstr_pprot = 3'b0;
	assign apb_mstr_psel_net = 1'b0;
	assign apb_mstr_penable_net = 1'b0; 
	assign apb_mstr_pwrite = 1'b0; 
	assign apb_mstr_pwdata = 32'b0;
	assign apb_mstr_pwdata_p = 4'b0;
	assign apb_mstr_pstrb = 4'b0; 
  end
  endgenerate


// APB Slave (Local memory direct access port)
//--------------------------------------------

  generate
  if(l_opsrv_cfg_lmem_dap_present) begin: gen_apb_lmem_dap
    MIV_RV32IMC_opsrv_lmem_dap_apb_slv
    #(    
      .CPU_ADDR_WIDTH                       (l_opsrv_cfg_cpu_addr_width          ),
      .LMEM_DAP_ADDR_WIDTH                  (LMEM_DAP_ADDR_WIDTH                 ),
      .LMEM0_ADDR_WIDTH                     (l_opsrv_cfg_lmem0_addr_width        ),
      .LMEM1_ADDR_WIDTH                     (l_opsrv_cfg_lmem1_addr_width        ),
      .UDMA_CTRL_ADDR_WIDTH                 (l_opsrv_cfg_udma_ctrl_addr_width    )
    )
    u_lmem_dap_apb_slv_0
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ),                                      
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .cfg_lmem_dap_udma_ctrl_start_addr    (l_lmem_dap_udma_ctrl_start_addr      ),
      .cfg_lmem_dap_udma_ctrl_end_addr      (l_lmem_dap_udma_ctrl_end_addr        ),
      .cfg_lmem_dap_lmem0_start_addr        (l_lmem_dap_lmem0_start_addr          ),
      .cfg_lmem_dap_lmem0_end_addr          (l_lmem_dap_lmem0_end_addr            ),
      .cfg_lmem_dap_lmem1_start_addr        (l_lmem_dap_lmem1_start_addr          ),
      .cfg_lmem_dap_lmem1_end_addr          (l_lmem_dap_lmem1_end_addr            ),
      .paddr                                (lmem_dap_apb_slv_paddr               ),
      .paddr_p                              (lmem_dap_apb_slv_paddr_p             ),
      .pprot                                (lmem_dap_apb_slv_pprot               ),
      .psel                                 (lmem_dap_apb_slv_psel                ),
      .penable                              (lmem_dap_apb_slv_penable             ),
      .pwrite                               (lmem_dap_apb_slv_pwrite              ),
      .pwdata                               (lmem_dap_apb_slv_pwdata              ),
      .pwdata_p                             (lmem_dap_apb_slv_pwdata_p            ),
      .pready                               (lmem_dap_apb_slv_pready              ),
      .prdata                               (lmem_dap_apb_slv_prdata              ),
      .prdata_p                             (lmem_dap_apb_slv_prdata_p            ),
      .pslverr                              (lmem_dap_apb_slv_pslverr             ),
      .lmem0_dap_req_valid                  (lmem0_dap_req_valid_net              ),
      .lmem0_dap_req_ready                  (lmem0_dap_req_ready_net              ),
      .lmem0_dap_req_rd_byte_en             (lmem0_dap_req_rd_byte_en_net         ),
      .lmem0_dap_req_wr_byte_en             (lmem0_dap_req_wr_byte_en_net         ),
      .lmem0_dap_req_addr                   (lmem0_dap_req_addr_net               ),
      .lmem0_dap_req_addr_p                 (lmem0_dap_req_addr_p_net             ),
      .lmem0_dap_req_wr_data                (lmem0_dap_req_wr_data_net            ),
      .lmem0_dap_req_wr_data_p              (lmem0_dap_req_wr_data_p_net          ),
      .lmem0_dap_resp_valid                 (lmem0_dap_resp_valid_net             ),
      .lmem0_dap_resp_ready                 (lmem0_dap_resp_ready_net             ),
      .lmem0_dap_resp_rd_error              (lmem0_dap_resp_rd_error_net          ),
      .lmem0_dap_resp_rd_data               (lmem0_dap_resp_rd_data_net           ),
      .lmem0_dap_resp_rd_data_p             (lmem0_dap_resp_rd_data_p_net         ),
      .lmem1_dap_req_valid                  (lmem1_dap_req_valid_net              ),
      .lmem1_dap_req_ready                  (lmem1_dap_req_ready_net              ),
      .lmem1_dap_req_rd_byte_en             (lmem1_dap_req_rd_byte_en_net         ),
      .lmem1_dap_req_wr_byte_en             (lmem1_dap_req_wr_byte_en_net         ),
      .lmem1_dap_req_addr                   (lmem1_dap_req_addr_net               ),
      .lmem1_dap_req_addr_p                 (lmem1_dap_req_addr_p_net             ),
      .lmem1_dap_req_wr_data                (lmem1_dap_req_wr_data_net            ),
      .lmem1_dap_req_wr_data_p              (lmem1_dap_req_wr_data_p_net          ),
      .lmem1_dap_resp_valid                 (lmem1_dap_resp_valid_net             ),
      .lmem1_dap_resp_ready                 (lmem1_dap_resp_ready_net             ),
      .lmem1_dap_resp_rd_error              (lmem1_dap_resp_rd_error_net          ),
      .lmem1_dap_resp_rd_data               (lmem1_dap_resp_rd_data_net           ),
      .lmem1_dap_resp_rd_data_p             (lmem1_dap_resp_rd_data_p_net         ),
      .udma_ctrl_req_valid                  (lmem_dap_udma_ctrl_req_valid_net     ),
      .udma_ctrl_req_ready                  (lmem_dap_udma_ctrl_req_ready_net     ),
      .udma_ctrl_req_rd_byte_en             (lmem_dap_udma_ctrl_req_rd_byte_en_net),
      .udma_ctrl_req_wr_byte_en             (lmem_dap_udma_ctrl_req_wr_byte_en_net),
      .udma_ctrl_req_addr                   (lmem_dap_udma_ctrl_req_addr_net      ),      
      .udma_ctrl_req_addr_p                 (lmem_dap_udma_ctrl_req_addr_p_net    ),
      .udma_ctrl_req_wr_data                (lmem_dap_udma_ctrl_req_wr_data_net   ),
      .udma_ctrl_req_wr_data_p              (lmem_dap_udma_ctrl_req_wr_data_p_net ),
      .udma_ctrl_resp_valid                 (lmem_dap_udma_ctrl_resp_valid_net    ),
      .udma_ctrl_resp_ready                 (lmem_dap_udma_ctrl_resp_ready_net    ),
      .udma_ctrl_resp_rd_error              (lmem_dap_udma_ctrl_resp_rd_error_net ),
      .udma_ctrl_resp_rd_data               (lmem_dap_udma_ctrl_resp_rd_data_net  ),
      .udma_ctrl_resp_rd_data_p             (lmem_dap_udma_ctrl_resp_rd_data_p_net) 
    );
  end
  else begin : ngen_apb_lmem_dap
  
    assign lmem_dap_apb_slv_pready                 = 1'b0;  
    assign lmem_dap_apb_slv_prdata                 = {32{1'b0}}; 
    assign lmem_dap_apb_slv_prdata_p               = {4{1'b0}};
    assign lmem_dap_apb_slv_pslverr                = 1'b0;    
    assign lmem0_dap_req_valid_net                 = 1'b0; 
    assign lmem0_dap_req_rd_byte_en_net            = {4{1'b0}};
    assign lmem0_dap_req_wr_byte_en_net            = {4{1'b0}};
    assign lmem0_dap_req_addr_net                  = {l_opsrv_cfg_lmem0_addr_width{1'b0}};
    assign lmem0_dap_req_addr_p_net                = 1'b0;
    assign lmem0_dap_req_wr_data_net               = {32{1'b0}};
    assign lmem0_dap_req_wr_data_p_net             = {4{1'b0}};
    assign lmem0_dap_resp_ready_net                = 1'b0; 
    assign lmem1_dap_req_valid_net                 = 1'b0; 
    assign lmem1_dap_req_rd_byte_en_net            = {4{1'b0}};
    assign lmem1_dap_req_wr_byte_en_net            = {4{1'b0}};
    assign lmem1_dap_req_addr_net                  = {l_opsrv_cfg_lmem1_addr_width{1'b0}};
    assign lmem1_dap_req_addr_p_net                = 1'b0;
    assign lmem1_dap_req_wr_data_net               = {32{1'b0}};
    assign lmem1_dap_req_wr_data_p_net             = {4{1'b0}};
    assign lmem1_dap_resp_ready_net                = 1'b0;    
    assign lmem_dap_udma_ctrl_req_valid_net        = 1'b0;
    assign lmem_dap_udma_ctrl_req_rd_byte_en_net   = {4{1'b0}}; 
    assign lmem_dap_udma_ctrl_req_wr_byte_en_net   = {4{1'b0}};
    assign lmem_dap_udma_ctrl_req_addr_net         = {l_opsrv_cfg_udma_ctrl_addr_width{1'b0}};
    assign lmem_dap_udma_ctrl_req_addr_p_net       = 1'b0;
    assign lmem_dap_udma_ctrl_req_wr_data_net      = {32{1'b0}};
    assign lmem_dap_udma_ctrl_req_wr_data_p_net    = {4{1'b0}};
    assign lmem_dap_udma_ctrl_resp_ready_net       = 1'b0;   
    
  end   
  endgenerate
  
  
  
  

// Local Memory 0
//--------------------------------------------


  generate
  if(l_opsrv_cfg_lmem0_present) begin: gen_lmem0
    MIV_RV32IMC_opsrv_lmem
    #(    
      .LMEM_ADDR_WIDTH                      (l_opsrv_cfg_lmem0_addr_width       ),
      .UDMA_PRESENT                         (l_opsrv_cfg_lmem0_udma_present     ),
      .LMEM_DAP_PRESENT                     (l_opsrv_cfg_lmem0_dap_present      ),
      .DEBUG_PRESENT                        (l_opsrv_cfg_submicron_debug        ),
      .CPU_I_PRESENT                        (l_opsrv_cfg_lmem0_cpu_i_present    ),
      .CPU_D_PRESENT                        (l_opsrv_cfg_lmem0_cpu_d_present    ),
      .USE_RAM_PARITY_BITS                  (l_opsrv_cfg_lmem0_use_ram_parity_bits),
      .RAM_SB_IN_WIDTH                      (RAM_SB_IN_WIDTH),
      .RAM_SB_OUT_WIDTH                     (RAM_SB_OUT_WIDTH),
	  .RAM_DEPTH                            (LMEM0_DEPTH),
	  .ECC_ENABLE                           (ECC_ENABLE)
      
    )
    u_opsrv_lmem_0
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ),                                      
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .trx_os_d_rd                          (lmem0_trx_os_d_rd_net                ),
      .trx_os_d_wr                          (lmem0_trx_os_d_wr_net                ),
      .ecc_err_correctable                  (lmem0_ecc_err_correctable_net        ),
      .ecc_err_uncorrectable                (lmem0_ecc_err_uncorrectable_net      ),
      .cpu_i_req_valid                      (lmem0_i_req_valid_net                ),
      .cpu_i_req_ready                      (lmem0_i_req_ready_net                ),
      .cpu_i_req_rd_byte_en                 (lmem0_i_req_rd_byte_en_net           ),
      .cpu_i_req_addr                       (lmem0_i_req_addr_net                 ),
      .cpu_i_req_addr_p                     (lmem0_i_req_addr_p_net               ),
      .cpu_i_resp_valid                     (lmem0_i_resp_valid_net               ),
      .cpu_i_resp_ready                     (lmem0_i_resp_ready_net               ),
      .cpu_i_resp_error                     (lmem0_i_resp_error_net               ),
      .cpu_i_resp_rd_data                   (lmem0_i_resp_rd_data_net             ),
      .cpu_i_resp_rd_data_p                 (lmem0_i_resp_rd_data_p_net           ),
      .cpu_d_req_valid                      (lmem0_d_req_valid_net                ),
      .cpu_d_req_ready                      (lmem0_d_req_ready_net                ),
      .cpu_d_req_rd_byte_en                 (lmem0_d_req_rd_byte_en_net           ),
      .cpu_d_req_wr_byte_en                 (lmem0_d_req_wr_byte_en_net           ),
      .cpu_d_req_read                       (lmem0_d_req_read_net                 ),
      .cpu_d_req_write                      (lmem0_d_req_write_net                ),
      .cpu_d_req_addr                       (lmem0_d_req_addr_net                 ),
      .cpu_d_req_addr_p                     (lmem0_d_req_addr_p_net               ),
      .cpu_d_req_wr_data                    (lmem0_d_req_wr_data_net              ),
      .cpu_d_req_wr_data_p                  (lmem0_d_req_wr_data_p_net            ),
      .cpu_d_resp_valid                     (lmem0_d_resp_valid_net               ),
      .cpu_d_resp_ready                     (lmem0_d_resp_ready_net               ),
      .cpu_d_resp_error                     (lmem0_d_resp_error_net               ),
      .cpu_d_resp_rd_data                   (lmem0_d_resp_rd_data_net             ),
      .cpu_d_resp_rd_data_p                 (lmem0_d_resp_rd_data_p_net           ),    
      .udma_req_valid                       (udma_lmem0_req_valid_net             ),
      .udma_req_ready                       (udma_lmem0_req_ready_net             ),
      .udma_req_rd_byte_en                  (udma_lmem0_req_rd_byte_en_net        ),
      .udma_req_wr_byte_en                  (udma_lmem0_req_wr_byte_en_net        ),
      .udma_req_read                        (udma_lmem0_req_read_net              ),
      .udma_req_write                       (udma_lmem0_req_write_net             ),
      .udma_req_addr                        (udma_lmem0_req_addr_net              ),
      .udma_req_addr_p                      (udma_lmem0_req_addr_p_net            ),
      .udma_req_len                         (udma_lmem0_req_len_net               ),
      .udma_req_wr_data                     (udma_lmem0_req_wr_data_net           ),
      .udma_req_wr_data_p                   (udma_lmem0_req_wr_data_p_net         ),
      .udma_resp_valid                      (udma_lmem0_resp_valid_net            ),
      .udma_resp_ready                      (udma_lmem0_resp_ready_net            ),
      .udma_resp_rd_error                   (udma_lmem0_resp_rd_error_net         ),
      .udma_resp_rd_data                    (udma_lmem0_resp_rd_data_net          ),
      .udma_resp_rd_data_p                  (udma_lmem0_resp_rd_data_p_net        ), 
      .lmem_dap_access_disable              (lmem0_dap_access_disable             ),
      .lmem_cpu_access_disable              (lmem0_cpu_access_disable             ),
      .lmem_dma_access_disable              (lmem0_dma_access_disable             ),
      .lmem_dap_req_valid                   (lmem0_dap_req_valid_net              ),
      .lmem_dap_req_ready                   (lmem0_dap_req_ready_net              ),
      .lmem_dap_req_rd_byte_en              (lmem0_dap_req_rd_byte_en_net         ),
      .lmem_dap_req_wr_byte_en              (lmem0_dap_req_wr_byte_en_net         ),
      .lmem_dap_req_addr                    (lmem0_dap_req_addr_net               ),
      .lmem_dap_req_addr_p                  (lmem0_dap_req_addr_p_net             ),
      .lmem_dap_req_wr_data                 (lmem0_dap_req_wr_data_net            ),
      .lmem_dap_req_wr_data_p               (lmem0_dap_req_wr_data_p_net          ),
      .lmem_dap_resp_valid                  (lmem0_dap_resp_valid_net             ),
      .lmem_dap_resp_ready                  (lmem0_dap_resp_ready_net             ),
      .lmem_dap_resp_rd_error               (lmem0_dap_resp_rd_error_net          ),
      .lmem_dap_resp_rd_data                (lmem0_dap_resp_rd_data_net           ),
      .lmem_dap_resp_rd_data_p              (lmem0_dap_resp_rd_data_p_net         ),
      .lmem_ram_sb_out                      (lmem0_ram_sb_out                     ), 
      .lmem_ram_sb_in                       (lmem0_ram_sb_in                      )       
    );
  end
  else begin : ngen_lmem0 
    assign lmem0_i_req_ready_net           = 1'b0;  
    assign lmem0_i_resp_valid_net          = 1'b0;  
    assign lmem0_i_resp_error_net          = 1'b0;  
    assign lmem0_i_resp_rd_data_net        = {32{1'b0}}; 
    assign lmem0_i_resp_rd_data_p_net      = {4{1'b0}};
    assign lmem0_d_req_ready_net           = 1'b0;  
    assign lmem0_d_resp_valid_net          = 1'b0;  
    assign lmem0_d_resp_error_net          = 1'b0;  
    assign lmem0_d_resp_rd_data_net        = {32{1'b0}}; 
    assign lmem0_d_resp_rd_data_p_net      = {4{1'b0}};
    assign udma_lmem0_req_ready_net        = 1'b0;              
    assign udma_lmem0_resp_valid_net       = 1'b0;               
    assign udma_lmem0_resp_rd_error_net    = 1'b0;              
    assign udma_lmem0_resp_rd_data_net     = {32{1'b0}};        
    assign udma_lmem0_resp_rd_data_p_net   = {4{1'b0}};                  
    assign lmem0_dap_req_ready_net         = 1'b0;                      
    assign lmem0_dap_resp_valid_net        = 1'b0;                      
    assign lmem0_dap_resp_rd_error_net     = 1'b0;                      
    assign lmem0_dap_resp_rd_data_net      = {32{1'b0}};                
    assign lmem0_dap_resp_rd_data_p_net    = {4{1'b0}};    
    assign lmem0_trx_os_d_rd_net           = 1'b0;
    assign lmem0_trx_os_d_wr_net           = 1'b0;
    assign lmem0_ecc_err_correctable_net   = 1'b0;
    assign lmem0_ecc_err_uncorrectable_net = 1'b0;
    assign lmem0_ram_sb_out                = {RAM_SB_OUT_WIDTH{1'b0}};
    
  end   
  endgenerate

// Local Memory 1
//--------------------------------------------

  generate
  if(l_opsrv_cfg_lmem1_present) begin: gen_lmem1
    MIV_RV32IMC_opsrv_lmem
    #(    
      .LMEM_ADDR_WIDTH                      (l_opsrv_cfg_lmem1_addr_width       ),
      .UDMA_PRESENT                         (l_opsrv_cfg_lmem1_udma_present     ),
      .LMEM_DAP_PRESENT                     (l_opsrv_cfg_lmem1_dap_present      ),
      .DEBUG_PRESENT                        (l_opsrv_cfg_submicron_debug        ),
      .CPU_I_PRESENT                        (l_opsrv_cfg_lmem1_cpu_i_present    ),
      .CPU_D_PRESENT                        (l_opsrv_cfg_lmem1_cpu_d_present    ),
      .USE_RAM_PARITY_BITS                  (l_opsrv_cfg_lmem1_use_ram_parity_bits),
      .RAM_SB_IN_WIDTH                      (RAM_SB_IN_WIDTH  ),
      .RAM_SB_OUT_WIDTH                     (RAM_SB_OUT_WIDTH ),
	  .RAM_DEPTH                            (LMEM1_DEPTH),
	  .ECC_ENABLE                           (ECC_ENABLE)
      
    )
    u_opsrv_lmem_1
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ),                                      
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .trx_os_d_rd                          (lmem1_trx_os_d_rd_net                ),
      .trx_os_d_wr                          (lmem1_trx_os_d_wr_net                ),
      .ecc_err_correctable                  (lmem1_ecc_err_correctable_net        ),
      .ecc_err_uncorrectable                (lmem1_ecc_err_uncorrectable_net      ),
      .cpu_i_req_valid                      (lmem1_i_req_valid_net                ),
      .cpu_i_req_ready                      (lmem1_i_req_ready_net                ),
      .cpu_i_req_rd_byte_en                 (lmem1_i_req_rd_byte_en_net           ),
      .cpu_i_req_addr                       (lmem1_i_req_addr_net                 ),
      .cpu_i_req_addr_p                     (lmem1_i_req_addr_p_net               ),
      .cpu_i_resp_valid                     (lmem1_i_resp_valid_net               ),
      .cpu_i_resp_ready                     (lmem1_i_resp_ready_net               ),
      .cpu_i_resp_error                     (lmem1_i_resp_error_net               ),
      .cpu_i_resp_rd_data                   (lmem1_i_resp_rd_data_net             ),
      .cpu_i_resp_rd_data_p                 (lmem1_i_resp_rd_data_p_net           ),
      .cpu_d_req_valid                      (lmem1_d_req_valid_net                ),
      .cpu_d_req_ready                      (lmem1_d_req_ready_net                ),
      .cpu_d_req_rd_byte_en                 (lmem1_d_req_rd_byte_en_net           ),
      .cpu_d_req_wr_byte_en                 (lmem1_d_req_wr_byte_en_net           ),
      .cpu_d_req_read                       (lmem1_d_req_read_net                 ),
      .cpu_d_req_write                      (lmem1_d_req_write_net                ),
      .cpu_d_req_addr                       (lmem1_d_req_addr_net                 ),
      .cpu_d_req_addr_p                     (lmem1_d_req_addr_p_net               ),
      .cpu_d_req_wr_data                    (lmem1_d_req_wr_data_net              ),
      .cpu_d_req_wr_data_p                  (lmem1_d_req_wr_data_p_net            ),
      .cpu_d_resp_valid                     (lmem1_d_resp_valid_net               ),
      .cpu_d_resp_ready                     (lmem1_d_resp_ready_net               ),
      .cpu_d_resp_error                     (lmem1_d_resp_error_net               ),
      .cpu_d_resp_rd_data                   (lmem1_d_resp_rd_data_net             ),
      .cpu_d_resp_rd_data_p                 (lmem1_d_resp_rd_data_p_net           ),    
      .udma_req_valid                       (udma_lmem1_req_valid_net             ),
      .udma_req_ready                       (udma_lmem1_req_ready_net             ),
      .udma_req_rd_byte_en                  (udma_lmem1_req_rd_byte_en_net        ),
      .udma_req_wr_byte_en                  (udma_lmem1_req_wr_byte_en_net        ),
      .udma_req_read                        (udma_lmem1_req_read_net              ),
      .udma_req_write                       (udma_lmem1_req_write_net             ),
      .udma_req_addr                        (udma_lmem1_req_addr_net              ),
      .udma_req_addr_p                      (udma_lmem1_req_addr_p_net            ),
      .udma_req_len                         (udma_lmem1_req_len_net               ),
      .udma_req_wr_data                     (udma_lmem1_req_wr_data_net           ),
      .udma_req_wr_data_p                   (udma_lmem1_req_wr_data_p_net         ),
      .udma_resp_valid                      (udma_lmem1_resp_valid_net            ),
      .udma_resp_ready                      (udma_lmem1_resp_ready_net            ),
      .udma_resp_rd_error                   (udma_lmem1_resp_rd_error_net         ),
      .udma_resp_rd_data                    (udma_lmem1_resp_rd_data_net          ),
      .udma_resp_rd_data_p                  (udma_lmem1_resp_rd_data_p_net        ), 
      .lmem_dap_access_disable              (lmem1_dap_access_disable             ),
      .lmem_cpu_access_disable              (lmem1_cpu_access_disable             ),
      .lmem_dma_access_disable              (lmem1_dma_access_disable             ),
      .lmem_dap_req_valid                   (lmem1_dap_req_valid_net              ),
      .lmem_dap_req_ready                   (lmem1_dap_req_ready_net              ),
      .lmem_dap_req_rd_byte_en              (lmem1_dap_req_rd_byte_en_net         ),
      .lmem_dap_req_wr_byte_en              (lmem1_dap_req_wr_byte_en_net         ),
      .lmem_dap_req_addr                    (lmem1_dap_req_addr_net               ),
      .lmem_dap_req_addr_p                  (lmem1_dap_req_addr_p_net             ),
      .lmem_dap_req_wr_data                 (lmem1_dap_req_wr_data_net            ),
      .lmem_dap_req_wr_data_p               (lmem1_dap_req_wr_data_p_net          ),
      .lmem_dap_resp_valid                  (lmem1_dap_resp_valid_net             ),
      .lmem_dap_resp_ready                  (lmem1_dap_resp_ready_net             ),
      .lmem_dap_resp_rd_error               (lmem1_dap_resp_rd_error_net          ),
      .lmem_dap_resp_rd_data                (lmem1_dap_resp_rd_data_net           ),
      .lmem_dap_resp_rd_data_p              (lmem1_dap_resp_rd_data_p_net         ),
      .lmem_ram_sb_out                      (lmem1_ram_sb_out                     ), 
      .lmem_ram_sb_in                       (lmem1_ram_sb_in                      ) 
      
    );
  end
  else begin : ngen_lmem1 
    assign lmem1_i_req_ready_net           = 1'b0;  
    assign lmem1_i_resp_valid_net          = 1'b0;  
    assign lmem1_i_resp_error_net          = 1'b0;  
    assign lmem1_i_resp_rd_data_net        = {32{1'b0}}; 
    assign lmem1_i_resp_rd_data_p_net      = {4{1'b0}};
    assign lmem1_d_req_ready_net           = 1'b0;  
    assign lmem1_d_resp_valid_net          = 1'b0;  
    assign lmem1_d_resp_error_net          = 1'b0;  
    assign lmem1_d_resp_rd_data_net        = {32{1'b0}}; 
    assign lmem1_d_resp_rd_data_p_net      = {4{1'b0}};
    assign udma_lmem1_req_ready_net        = 1'b0;              
    assign udma_lmem1_resp_valid_net       = 1'b0;              
    assign udma_lmem1_resp_rd_error_net    = 1'b0;              
    assign udma_lmem1_resp_rd_data_net     = {32{1'b0}};        
    assign udma_lmem1_resp_rd_data_p_net   = {4{1'b0}};
    assign lmem1_dap_req_ready_net         = 1'b0;       
    assign lmem1_dap_resp_valid_net        = 1'b0;       
    assign lmem1_dap_resp_rd_error_net     = 1'b0;       
    assign lmem1_dap_resp_rd_data_net      = {32{1'b0}}; 
    assign lmem1_dap_resp_rd_data_p_net    = {4{1'b0}};      
    assign lmem1_trx_os_d_rd_net           = 1'b0;
    assign lmem1_trx_os_d_wr_net           = 1'b0;
    assign lmem1_ecc_err_correctable_net   = 1'b0;
    assign lmem1_ecc_err_uncorrectable_net = 1'b0;    
    assign lmem1_ram_sb_out                = {RAM_SB_OUT_WIDTH{1'b0}};
  end   
  endgenerate

// AXI Master
//--------------------------------------------

  generate
  if(l_opsrv_cfg_axi_mstr_present) begin: gen_axi_mstr
    MIV_RV32IMC_opsrv_axi_mstr
    #( 
      .AXI_MSTR_ADDR_WIDTH                  (AXI_MSTR_ADDR_WIDTH                  )
    )
    u_opsrv_axi_mstr_0
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ), 
      .axi_rd_cfg_min_size                  (axi_rd_cfg_min_size_net              ),
      .axi_wr_cfg_min_size                  (axi_wr_cfg_min_size_net              ),
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .cfg_fence_all_src                    (cfg_fence_all_src_net                ),
      .cfg_ar_cache                         (cfg_ar_cache_net                     ),
      .cfg_aw_cache                         (cfg_aw_cache_net                     ),
      .cfg_raw_hzd_check                    (cfg_raw_hzd_check_net                ),
      .cfg_war_hzd_check                    (cfg_war_hzd_check_net                ),
      .trx_os_d_rd                          (axi_mstr_trx_os_d_rd_net             ),
      .trx_os_d_wr                          (axi_mstr_trx_os_d_wr_net             ),
      .cpu_i_req_valid                      (axi_mstr_i_req_valid_net             ),
      .cpu_i_req_ready                      (axi_mstr_i_req_ready_net             ),
      .cpu_i_req_rd_byte_en                 (axi_mstr_i_req_rd_byte_en_net        ),
      .cpu_i_req_addr                       (axi_mstr_i_req_addr_net              ),
      .cpu_i_req_addr_p                     (axi_mstr_i_req_addr_p_net            ),
      .cpu_i_resp_valid                     (axi_mstr_i_resp_valid_net            ),
      .cpu_i_resp_ready                     (axi_mstr_i_resp_ready_net            ),
      .cpu_i_resp_error                     (axi_mstr_i_resp_error_net            ),
      .cpu_i_resp_rd_data                   (axi_mstr_i_resp_rd_data_net          ),
      .cpu_i_resp_rd_data_p                 (axi_mstr_i_resp_rd_data_p_net        ),
      .cpu_d_req_valid                      (axi_mstr_d_req_valid_net             ),
      .cpu_d_req_ready                      (axi_mstr_d_req_ready_net             ),
      .cpu_d_req_rd_byte_en                 (axi_mstr_d_req_rd_byte_en_net        ),
      .cpu_d_req_wr_byte_en                 (axi_mstr_d_req_wr_byte_en_net        ),
      .cpu_d_req_read                       (axi_mstr_d_req_read_net              ),
      .cpu_d_req_write                      (axi_mstr_d_req_write_net             ),
      .cpu_d_req_addr                       (axi_mstr_d_req_addr_net              ),
      .cpu_d_req_addr_p                     (axi_mstr_d_req_addr_p_net            ),
      .cpu_d_req_wr_data                    (axi_mstr_d_req_wr_data_net           ),
      .cpu_d_req_wr_data_p                  (axi_mstr_d_req_wr_data_p_net         ),
      .cpu_d_resp_valid                     (axi_mstr_d_resp_valid_net            ),
      .cpu_d_resp_ready                     (axi_mstr_d_resp_ready_net            ),
      .cpu_d_resp_rd_error                  (axi_mstr_d_resp_rd_error_net         ),
      .cpu_d_resp_rd_data                   (axi_mstr_d_resp_rd_data_net          ),
      .cpu_d_resp_rd_data_p                 (axi_mstr_d_resp_rd_data_p_net        ),
      .cpu_d_wr_resp_err                    (axi_mstr_d_wr_resp_err_net           ),
      .udma_req_valid                       (udma_axi_req_valid_net               ),
      .udma_req_ready                       (udma_axi_req_ready_net               ),
      .udma_req_rd_byte_en                  (udma_axi_req_rd_byte_en_net          ),
      .udma_req_wr_byte_en                  (udma_axi_req_wr_byte_en_net          ),
      .udma_req_read                        (udma_axi_req_read_net                ),
      .udma_req_write                       (udma_axi_req_write_net               ),
      .udma_req_addr                        (udma_axi_req_addr_net                ),
      .udma_req_addr_p                      (udma_axi_req_addr_p_net              ),
      .udma_req_len                         (udma_axi_req_len_net                 ),
      .udma_req_wr_data                     (udma_axi_req_wr_data_net             ),
      .udma_req_wr_data_p                   (udma_axi_req_wr_data_p_net           ),
      .udma_req_wr_data_last                (udma_axi_req_wr_data_last_net        ),
      .udma_resp_valid                      (udma_axi_resp_valid_net              ),
      .udma_resp_last                       (udma_axi_resp_last_net               ),
      .udma_resp_ready                      (udma_axi_resp_ready_net              ),
      .udma_resp_rd_error                   (udma_axi_resp_rd_error_net           ),
      .udma_resp_rd_data                    (udma_axi_resp_rd_data_net            ),
      .udma_resp_rd_data_p                  (udma_axi_resp_rd_data_p_net          ),
      .udma_wr_resp_err                     (udma_axi_wr_resp_err_net             ),
      .aclk_en                              (1'b1                                 ),
      .aximstr_arid                         (axi_mstr_arid                        ),
      .aximstr_araddr                       (axi_mstr_araddr                      ),
      .aximstr_arlen                        (axi_mstr_arlen                       ),
      .aximstr_arsize                       (axi_mstr_arsize                      ),
      .aximstr_arburst                      (axi_mstr_arburst                     ),
      .aximstr_arlock                       (axi_mstr_arlock                      ),
      .aximstr_arcache                      (axi_mstr_arcache                     ),
      .aximstr_arprot                       (axi_mstr_arprot                      ),
      .aximstr_arready                      (axi_mstr_arready                     ),
      .aximstr_arvalid                      (axi_mstr_arvalid                     ),
      .aximstr_ar_addr_p                    (axi_mstr_ar_addr_p                   ),
      .aximstr_rresp                        (axi_mstr_rresp                       ),
      .aximstr_rdata                        (axi_mstr_rdata                       ),
      .aximstr_rlast                        (axi_mstr_rlast                       ),
      .aximstr_rid                          (axi_mstr_rid                         ),
      .aximstr_rready                       (axi_mstr_rready                      ),
      .aximstr_rvalid                       (axi_mstr_rvalid                      ),
      .aximstr_r_data_p                     (axi_mstr_r_data_p                    ),
      .aximstr_awid                         (axi_mstr_awid                        ),
      .aximstr_awaddr                       (axi_mstr_awaddr                      ),
      .aximstr_awlen                        (axi_mstr_awlen                       ),
      .aximstr_awsize                       (axi_mstr_awsize                      ),
      .aximstr_awburst                      (axi_mstr_awburst                     ),
      .aximstr_awlock                       (axi_mstr_awlock                      ),
      .aximstr_awcache                      (axi_mstr_awcache                     ),
      .aximstr_awprot                       (axi_mstr_awprot                      ),
      .aximstr_aw_addr_p                    (axi_mstr_aw_addr_p                   ),
      .aximstr_awready                      (axi_mstr_awready                     ),
      .aximstr_awvalid                      (axi_mstr_awvalid                     ),
      .aximstr_wdata                        (axi_mstr_wdata                       ),
      .aximstr_wstrb                        (axi_mstr_wstrb                       ),
      .aximstr_wlast                        (axi_mstr_wlast                       ),
      .aximstr_wid                          (axi_mstr_wid                         ),
      .aximstr_wready                       (axi_mstr_wready                      ),
      .aximstr_wvalid                       (axi_mstr_wvalid                      ),
      .aximstr_w_data_p                     (axi_mstr_w_data_p                    ),
      .aximstr_bresp                        (axi_mstr_bresp                       ),
      .aximstr_bid                          (axi_mstr_bid                         ),
      .aximstr_bready                       (axi_mstr_bready                      ),
      .aximstr_bvalid                       (axi_mstr_bvalid                      )
    );
  end
  else begin : ngen_axi_mstr 
               
    assign axi_mstr_i_req_ready_net          = 1'b0;
    assign axi_mstr_i_resp_valid_net         = 1'b0;
    assign axi_mstr_i_resp_error_net         = 1'b0;
    assign axi_mstr_i_resp_rd_data_net       = {32{1'b0}};
    assign axi_mstr_i_resp_rd_data_p_net     = {4{1'b0}};
    assign axi_mstr_d_req_ready_net          = 1'b0;
    assign axi_mstr_d_resp_valid_net         = 1'b0; 
    assign axi_mstr_d_resp_rd_error_net      = 1'b0;
    assign axi_mstr_d_resp_rd_data_net       = {32{1'b0}};
    assign axi_mstr_d_resp_rd_data_p_net     = {4{1'b0}};   
    assign axi_mstr_d_wr_resp_err_net        = 1'b0; 
    assign udma_axi_req_ready_net            = 1'b0;
    assign udma_axi_resp_valid_net           = 1'b0; 
    assign udma_axi_resp_last_net            = 1'b0;
    assign udma_axi_resp_rd_error_net        = 1'b0;
    assign udma_axi_resp_rd_data_net         = {32{1'b0}};
    assign udma_axi_resp_rd_data_p_net       = {4{1'b0}};    
    assign udma_axi_wr_resp_err_net          = 1'b0;  
    assign axi_mstr_arid                     = 1'b0;
    assign axi_mstr_araddr                   = {AXI_MSTR_ADDR_WIDTH{1'b0}};
    assign axi_mstr_arlen                    = {4{1'b0}};
    assign axi_mstr_arsize                   = {3{1'b0}};
    assign axi_mstr_arburst                  = {2{1'b0}};
    assign axi_mstr_arlock                   = {2{1'b0}};
    assign axi_mstr_arcache                  = {4{1'b0}};
    assign axi_mstr_arprot                   = {3{1'b0}};
    assign axi_mstr_arvalid                  = 1'b0;
    assign axi_mstr_ar_addr_p                = 1'b0;
    assign axi_mstr_rready                   = 1'b0;
    assign axi_mstr_awid                     = 1'b0;
    assign axi_mstr_awaddr                   = {AXI_MSTR_ADDR_WIDTH{1'b0}};
    assign axi_mstr_awlen                    = {4{1'b0}};
    assign axi_mstr_awsize                   = {3{1'b0}};
    assign axi_mstr_awburst                  = {2{1'b0}};
    assign axi_mstr_awlock                   = {2{1'b0}};
    assign axi_mstr_awcache                  = {4{1'b0}};
    assign axi_mstr_awprot                   = {3{1'b0}};
    assign axi_mstr_aw_addr_p                = 1'b0;
    assign axi_mstr_awvalid                  = 1'b0;
    assign axi_mstr_wdata                    = {32{1'b0}};
    assign axi_mstr_wstrb                    = {4{1'b0}};
    assign axi_mstr_wlast                    = 1'b0;
    assign axi_mstr_wid                      = 1'b0;
    assign axi_mstr_wvalid                   = 1'b0;
    assign axi_mstr_w_data_p                 = {4{1'b0}};
    assign axi_mstr_bready                   = 1'b0;
    assign axi_mstr_trx_os_d_rd_net          = 1'b0;
    assign axi_mstr_trx_os_d_wr_net          = 1'b0;
    
  end   
  endgenerate

// AHB Master
//--------------------------------------------

  generate
  if(l_opsrv_cfg_ahb_mstr_present) begin: gen_ahb_mstr
    MIV_RV32IMC_opsrv_ahb_mstr
    #( 
      .AHB_MSTR_ADDR_WIDTH                  (AHB_MSTR_ADDR_WIDTH                  )
    )
    u_opsrv_ahb_mstr_0
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ),                                      
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .trx_os_d_rd                          (ahb_mstr_trx_os_d_rd_net             ),
      .trx_os_d_wr                          (ahb_mstr_trx_os_d_wr_net             ),
      .cpu_i_req_valid                      (ahb_mstr_i_req_valid_net             ),
      .cpu_i_req_ready                      (ahb_mstr_i_req_ready_net             ),
      .cpu_i_req_rd_byte_en                 (ahb_mstr_i_req_rd_byte_en_net        ),
      .cpu_i_req_addr                       (ahb_mstr_i_req_addr_net              ),
      .cpu_i_req_addr_p                     (ahb_mstr_i_req_addr_p_net            ),
      .cpu_i_resp_valid                     (ahb_mstr_i_resp_valid_net            ),
      .cpu_i_resp_ready                     (ahb_mstr_i_resp_ready_net            ),
      .cpu_i_resp_error                     (ahb_mstr_i_resp_error_net            ),
      .cpu_i_resp_rd_data                   (ahb_mstr_i_resp_rd_data_net          ),
      .cpu_i_resp_rd_data_p                 (ahb_mstr_i_resp_rd_data_p_net        ),
      .cpu_d_req_valid                      (ahb_mstr_d_req_valid_net             ),
      .cpu_d_req_ready                      (ahb_mstr_d_req_ready_net             ),
      .cpu_d_req_rd_byte_en                 (ahb_mstr_d_req_rd_byte_en_net        ),
      .cpu_d_req_wr_byte_en                 (ahb_mstr_d_req_wr_byte_en_net        ),
      .cpu_d_req_read                       (ahb_mstr_d_req_read_net              ),
      .cpu_d_req_write                      (ahb_mstr_d_req_write_net             ),
      .cpu_d_req_addr                       (ahb_mstr_d_req_addr_net              ),
      .cpu_d_req_addr_p                     (ahb_mstr_d_req_addr_p_net            ),
      .cpu_d_req_wr_data                    (ahb_mstr_d_req_wr_data_net           ),
      .cpu_d_req_wr_data_p                  (ahb_mstr_d_req_wr_data_p_net         ),
      .cpu_d_resp_valid                     (ahb_mstr_d_resp_valid_net            ),
      .cpu_d_resp_ready                     (ahb_mstr_d_resp_ready_net            ),
      .cpu_d_resp_rd_error                  (ahb_mstr_d_resp_rd_error_net         ),
      .cpu_d_resp_rd_data                   (ahb_mstr_d_resp_rd_data_net          ),
      .cpu_d_resp_rd_data_p                 (ahb_mstr_d_resp_rd_data_p_net        ),
      .udma_req_valid                       (udma_ahb_req_valid_net               ),
      .udma_req_ready                       (udma_ahb_req_ready_net               ),
      .udma_req_rd_byte_en                  (udma_ahb_req_rd_byte_en_net          ),
      .udma_req_wr_byte_en                  (udma_ahb_req_wr_byte_en_net          ),
      .udma_req_read                        (udma_ahb_req_read_net                ),
      .udma_req_write                       (udma_ahb_req_write_net               ),
      .udma_req_addr                        (udma_ahb_req_addr_net                ),
      .udma_req_addr_p                      (udma_ahb_req_addr_p_net              ),
      .udma_req_len                         (udma_ahb_req_len_net                 ),
      .udma_req_wr_data                     (udma_ahb_req_wr_data_net             ),
      .udma_req_wr_data_p                   (udma_ahb_req_wr_data_p_net           ),
      .udma_req_wr_data_last                (udma_ahb_req_wr_data_last_net        ),
      .udma_resp_valid                      (udma_ahb_resp_valid_net              ),
      .udma_resp_last                       (udma_ahb_resp_last_net               ),
      .udma_resp_ready                      (udma_ahb_resp_ready_net              ),
      .udma_resp_rd_error                   (udma_ahb_resp_rd_error_net           ),
      .udma_resp_rd_data                    (udma_ahb_resp_rd_data_net            ),
      .udma_resp_rd_data_p                  (udma_ahb_resp_rd_data_p_net          ),
      .haddr                                (ahb_mstr_haddr                       ),
      .haddr_p                              (ahb_mstr_haddr_p                     ),
      .hburst                               (ahb_mstr_hburst                      ),
      .hmastlock                            (ahb_mstr_hmastlock                   ),
      .hprot                                (ahb_mstr_hprot                       ),
      .hsize                                (ahb_mstr_hsize                       ),
      .htrans                               (ahb_mstr_htrans                      ),
      .hwdata                               (ahb_mstr_hwdata                      ),
      .hwdata_p                             (ahb_mstr_hwdata_p                    ),
      .hwrite                               (ahb_mstr_hwrite                      ),
      .hrdata                               (ahb_mstr_hrdata                      ),
      .hrdata_p                             (ahb_mstr_hrdata_p                    ),
      .hready                               (ahb_mstr_hready                      ),
      .hresp                                (ahb_mstr_hresp                       )
    );
  end
  else begin : ngen_ahb_mstr 
  
    assign ahb_mstr_i_req_ready_net          = 1'b0;
    assign ahb_mstr_i_resp_valid_net         = 1'b0;
    assign ahb_mstr_i_resp_error_net         = 1'b0;
    assign ahb_mstr_i_resp_rd_data_net       = {32{1'b0}};
    assign ahb_mstr_i_resp_rd_data_p_net     = {4{1'b0}};
    assign ahb_mstr_d_req_ready_net          = 1'b0;
    assign ahb_mstr_d_resp_valid_net         = 1'b0; 
    assign ahb_mstr_d_resp_rd_error_net      = 1'b0;
    assign ahb_mstr_d_resp_rd_data_net       = {32{1'b0}};
    assign ahb_mstr_d_resp_rd_data_p_net     = {4{1'b0}};    
    assign udma_ahb_req_ready_net            = 1'b0;
    assign udma_ahb_resp_valid_net           = 1'b0; 
    assign udma_ahb_resp_last_net            = 1'b0;
    assign udma_ahb_resp_rd_error_net        = 1'b0;
    assign udma_ahb_resp_rd_data_net         = {32{1'b0}};
    assign udma_ahb_resp_rd_data_p_net       = {4{1'b0}};      
    assign ahb_mstr_haddr                    = {AHB_MSTR_ADDR_WIDTH{1'b0}}; 
    assign ahb_mstr_haddr_p                  = 1'b0;
    assign ahb_mstr_hburst                   = {3{1'b0}}; 
    assign ahb_mstr_hmastlock                = 1'b0;
    assign ahb_mstr_hprot                    = {4{1'b0}}; 
    assign ahb_mstr_hsize                    = {3{1'b0}}; 
    assign ahb_mstr_htrans                   = {2{1'b0}}; 
    assign ahb_mstr_hwdata                   = {32{1'b0}}; 
    assign ahb_mstr_hwdata_p                 = {4{1'b0}}; 
    assign ahb_mstr_hwrite                   = 1'b0;
    assign ahb_mstr_trx_os_d_rd_net          = 1'b0;
    assign ahb_mstr_trx_os_d_wr_net          = 1'b0;
    
  end   
  endgenerate                   

// uDMA
//--------------------------------------------

generate
  if(l_opsrv_cfg_udma_present) begin: gen_udma
    MIV_RV32IMC_opsrv_udma
    #( 
      .AXI_MSTR_ADDR_WIDTH                   (AXI_MSTR_ADDR_WIDTH                  ),
      .AHB_MSTR_ADDR_WIDTH                   (AHB_MSTR_ADDR_WIDTH                  ),
      .UDMA_CTRL_ADDR_WIDTH                  (l_opsrv_cfg_udma_ctrl_addr_width     ),
      .LMEM0_ADDR_WIDTH                      (l_opsrv_cfg_lmem0_addr_width         ),
      .LMEM1_ADDR_WIDTH                      (l_opsrv_cfg_lmem1_addr_width         )
    )
    u_opsrv_udma_0
    (
      .clk                                  (clk                                  ),
      .resetn                               (resetn                               ), 
      .opsrv_parity_en                      (opsrv_parity_en_net                  ),
      .trx_os_d_rd                          (udma_trx_os_d_rd_net                 ),
      .trx_os_d_wr                          (udma_trx_os_d_wr_net                 ),
      .cpu_udma_ctrl_req_valid              (cpu_udma_ctrl_req_valid_net          ),
      .cpu_udma_ctrl_req_ready              (cpu_udma_ctrl_req_ready_net          ),
      .cpu_udma_ctrl_req_rd_byte_en         (cpu_udma_ctrl_req_rd_byte_en_net     ),
      .cpu_udma_ctrl_req_wr_byte_en         (cpu_udma_ctrl_req_wr_byte_en_net     ),
      .cpu_udma_ctrl_req_read               (cpu_udma_ctrl_req_read_net           ),
      .cpu_udma_ctrl_req_write              (cpu_udma_ctrl_req_write_net          ),
      .cpu_udma_ctrl_req_addr               (cpu_udma_ctrl_req_addr_net           ),
      .cpu_udma_ctrl_req_addr_p             (cpu_udma_ctrl_req_addr_p_net         ),
      .cpu_udma_ctrl_req_wr_data            (cpu_udma_ctrl_req_wr_data_net        ),
      .cpu_udma_ctrl_req_wr_data_p          (cpu_udma_ctrl_req_wr_data_p_net      ),
      .cpu_udma_ctrl_resp_valid             (cpu_udma_ctrl_resp_valid_net         ),
      .cpu_udma_ctrl_resp_ready             (cpu_udma_ctrl_resp_ready_net         ),
      .cpu_udma_ctrl_resp_error             (cpu_udma_ctrl_resp_error_net      ),
      .cpu_udma_ctrl_resp_rd_data           (cpu_udma_ctrl_resp_rd_data_net       ),
      .cpu_udma_ctrl_resp_rd_data_p         (cpu_udma_ctrl_resp_rd_data_p_net     ),
      .cpu_udma_ctrl_irq                    (cpu_udma_ctrl_irq_net                ),
      .udma_lmem0_req_valid                 (udma_lmem0_req_valid_net             ),
      .udma_lmem0_req_ready                 (udma_lmem0_req_ready_net             ),
      .udma_lmem0_req_rd_byte_en            (udma_lmem0_req_rd_byte_en_net        ),
      .udma_lmem0_req_wr_byte_en            (udma_lmem0_req_wr_byte_en_net        ),
      .udma_lmem0_req_read                  (udma_lmem0_req_read_net              ),
      .udma_lmem0_req_write                  (udma_lmem0_req_write_net             ),
      .udma_lmem0_req_addr                  (udma_lmem0_req_addr_net              ),
      .udma_lmem0_req_addr_p                (udma_lmem0_req_addr_p_net            ),
      .udma_lmem0_req_len                   (udma_lmem0_req_len_net               ),
      .udma_lmem0_req_wr_data               (udma_lmem0_req_wr_data_net           ),
      .udma_lmem0_req_wr_data_p             (udma_lmem0_req_wr_data_p_net         ),
      .udma_lmem0_resp_valid                (udma_lmem0_resp_valid_net            ),
      .udma_lmem0_resp_ready                (udma_lmem0_resp_ready_net            ),
      .udma_lmem0_resp_rd_error             (udma_lmem0_resp_rd_error_net         ),
      .udma_lmem0_resp_rd_data              (udma_lmem0_resp_rd_data_net          ),
      .udma_lmem0_resp_rd_data_p            (udma_lmem0_resp_rd_data_p_net        ),
      .udma_lmem1_req_valid                 (udma_lmem1_req_valid_net             ),
      .udma_lmem1_req_ready                 (udma_lmem1_req_ready_net             ),
      .udma_lmem1_req_rd_byte_en            (udma_lmem1_req_rd_byte_en_net        ),
      .udma_lmem1_req_wr_byte_en            (udma_lmem1_req_wr_byte_en_net        ),
      .udma_lmem1_req_read                  (udma_lmem1_req_read_net              ),
      .udma_lmem1_req_write                 (udma_lmem1_req_write_net             ),
      .udma_lmem1_req_addr                  (udma_lmem1_req_addr_net              ),
      .udma_lmem1_req_addr_p                (udma_lmem1_req_addr_p_net            ),
      .udma_lmem1_req_len                   (udma_lmem1_req_len_net               ),
      .udma_lmem1_req_wr_data               (udma_lmem1_req_wr_data_net           ),
      .udma_lmem1_req_wr_data_p             (udma_lmem1_req_wr_data_p_net         ),
      .udma_lmem1_resp_valid                (udma_lmem1_resp_valid_net            ),
      .udma_lmem1_resp_ready                (udma_lmem1_resp_ready_net            ),
      .udma_lmem1_resp_rd_error             (udma_lmem1_resp_rd_error_net         ),
      .udma_lmem1_resp_rd_data              (udma_lmem1_resp_rd_data_net          ),
      .udma_lmem1_resp_rd_data_p            (udma_lmem1_resp_rd_data_p_net        ),
      .udma_axi_req_valid                   (udma_axi_req_valid_net               ),
      .udma_axi_req_ready                   (udma_axi_req_ready_net               ),
      .udma_axi_req_rd_byte_en              (udma_axi_req_rd_byte_en_net          ),
      .udma_axi_req_wr_byte_en              (udma_axi_req_wr_byte_en_net          ),
      .udma_axi_req_read                    (udma_axi_req_read_net                ),
      .udma_axi_req_write                   (udma_axi_req_write_net               ),
      .udma_axi_req_addr                    (udma_axi_req_addr_net                ),
      .udma_axi_req_addr_p                  (udma_axi_req_addr_p_net              ),
      .udma_axi_req_len                     (udma_axi_req_len_net                 ),
      .udma_axi_req_wr_data                 (udma_axi_req_wr_data_net             ),
      .udma_axi_req_wr_data_p               (udma_axi_req_wr_data_p_net           ),
      .udma_axi_req_wr_data_last            (udma_axi_req_wr_data_last_net        ),
      .udma_axi_resp_valid                  (udma_axi_resp_valid_net              ),
      .udma_axi_resp_last                   (udma_axi_resp_last_net               ),
      .udma_axi_resp_ready                  (udma_axi_resp_ready_net              ),
      .udma_axi_resp_rd_error               (udma_axi_resp_rd_error_net           ),
      .udma_axi_resp_rd_data                (udma_axi_resp_rd_data_net            ),
      .udma_axi_resp_rd_data_p              (udma_axi_resp_rd_data_p_net          ),     
      .udma_axi_wr_resp_err                 (udma_axi_wr_resp_err_net             ),
      .udma_ahb_req_valid                   (udma_ahb_req_valid_net               ),
      .udma_ahb_req_ready                   (udma_ahb_req_ready_net               ),
      .udma_ahb_req_rd_byte_en              (udma_ahb_req_rd_byte_en_net          ),
      .udma_ahb_req_wr_byte_en              (udma_ahb_req_wr_byte_en_net          ),
      .udma_ahb_req_read                    (udma_ahb_req_read_net                ),
      .udma_ahb_req_write                   (udma_ahb_req_write_net               ),
      .udma_ahb_req_addr                    (udma_ahb_req_addr_net                ),
      .udma_ahb_req_addr_p                  (udma_ahb_req_addr_p_net              ),
      .udma_ahb_req_len                     (udma_ahb_req_len_net                 ),
      .udma_ahb_req_wr_data                 (udma_ahb_req_wr_data_net             ),
      .udma_ahb_req_wr_data_p               (udma_ahb_req_wr_data_p_net           ),
      .udma_ahb_req_wr_data_last            (udma_ahb_req_wr_data_last_net        ),
      .udma_ahb_resp_valid                  (udma_ahb_resp_valid_net              ),
      .udma_ahb_resp_last                   (udma_ahb_resp_last_net               ),
      .udma_ahb_resp_ready                  (udma_ahb_resp_ready_net              ),
      .udma_ahb_resp_rd_error               (udma_ahb_resp_rd_error_net           ),
      .udma_ahb_resp_rd_data                (udma_ahb_resp_rd_data_net            ),
      .udma_ahb_resp_rd_data_p              (udma_ahb_resp_rd_data_p_net          ),
      .apb_dap_udma_ctrl_req_valid          (lmem_dap_udma_ctrl_req_valid_net     ),
      .apb_dap_udma_ctrl_req_ready          (lmem_dap_udma_ctrl_req_ready_net     ),
      .apb_dap_udma_ctrl_req_rd_byte_en     (lmem_dap_udma_ctrl_req_rd_byte_en_net),
      .apb_dap_udma_ctrl_req_wr_byte_en     (lmem_dap_udma_ctrl_req_wr_byte_en_net),
      .apb_dap_udma_ctrl_req_addr           (lmem_dap_udma_ctrl_req_addr_net      ),
      .apb_dap_udma_ctrl_req_addr_p         (lmem_dap_udma_ctrl_req_addr_p_net    ),
      .apb_dap_udma_ctrl_req_wr_data        (lmem_dap_udma_ctrl_req_wr_data_net   ),
      .apb_dap_udma_ctrl_req_wr_data_p      (lmem_dap_udma_ctrl_req_wr_data_p_net ),
      .apb_dap_udma_ctrl_resp_valid         (lmem_dap_udma_ctrl_resp_valid_net    ),
      .apb_dap_udma_ctrl_resp_ready         (lmem_dap_udma_ctrl_resp_ready_net    ),
      .apb_dap_udma_ctrl_resp_rd_error      (lmem_dap_udma_ctrl_resp_rd_error_net ),
      .apb_dap_udma_ctrl_resp_rd_data       (lmem_dap_udma_ctrl_resp_rd_data_net  ),
      .apb_dap_udma_ctrl_resp_rd_data_p     (lmem_dap_udma_ctrl_resp_rd_data_p_net),
      .apb_dap_udma_ctrl_irq                (lmem_dap_udma_ctrl_irq               )
    );
  end
  else begin : ngen_udma 
  
    assign cpu_udma_ctrl_req_ready_net              = 1'b0;  
    assign cpu_udma_ctrl_resp_valid_net             = 1'b0;  
    assign cpu_udma_ctrl_resp_error_net             = 1'b0;  
    assign cpu_udma_ctrl_resp_rd_data_net           = {32{1'b0}};
    assign cpu_udma_ctrl_resp_rd_data_p_net         = {4{1'b0}};
    assign cpu_udma_ctrl_irq_net                    = 1'b0;
    assign udma_lmem0_req_valid_net                 = 1'b0;  
    assign udma_lmem0_req_rd_byte_en_net            = {4{1'b0}};
    assign udma_lmem0_req_wr_byte_en_net            = {4{1'b0}};
    assign udma_lmem0_req_read_net                  = 1'b0; 
    assign udma_lmem0_req_write_net                 = 1'b0;  
    assign udma_lmem0_req_addr_net                  = {l_opsrv_cfg_lmem0_addr_width{1'b0}};
    assign udma_lmem0_req_addr_p_net                = 1'b0;  
    assign udma_lmem0_req_len_net                   = {4{1'b0}};
    assign udma_lmem0_req_wr_data_net               = {32{1'b0}};
    assign udma_lmem0_req_wr_data_p_net             = {4{1'b0}}; 
    assign udma_lmem0_resp_ready_net                = 1'b0;  
    assign udma_lmem1_req_valid_net                 = 1'b0;  
    assign udma_lmem1_req_rd_byte_en_net            = {4{1'b0}};
    assign udma_lmem1_req_wr_byte_en_net            = {4{1'b0}};
    assign udma_lmem1_req_read_net                  = 1'b0; 
    assign udma_lmem1_req_write_net                 = 1'b0;  
    assign udma_lmem1_req_addr_net                  = {l_opsrv_cfg_lmem1_addr_width{1'b0}};
    assign udma_lmem1_req_addr_p_net                = 1'b0;  
    assign udma_lmem1_req_len_net                   = {4{1'b0}};
    assign udma_lmem1_req_wr_data_net               = {32{1'b0}};
    assign udma_lmem1_req_wr_data_p_net             = {4{1'b0}}; 
    assign udma_lmem1_resp_ready_net                = 1'b0;  
    assign udma_axi_req_valid_net                   = 1'b0;  
    assign udma_axi_req_rd_byte_en_net              = {4{1'b0}};
    assign udma_axi_req_wr_byte_en_net              = {4{1'b0}};
    assign udma_axi_req_read_net                    = 1'b0;
    assign udma_axi_req_write_net                   = 1'b0;
    assign udma_axi_req_addr_net                    = {AXI_MSTR_ADDR_WIDTH{1'b0}};
    assign udma_axi_req_addr_p_net                  = 1'b0;  
    assign udma_axi_req_len_net                     = {4{1'b0}};
    assign udma_axi_req_wr_data_net                 = {32{1'b0}};
    assign udma_axi_req_wr_data_p_net               = {4{1'b0}};
    assign udma_axi_req_wr_data_last_net            = 1'b0;  
    assign udma_axi_resp_ready_net                  = 1'b0;  
    assign udma_ahb_req_valid_net                   = 1'b0;  
    assign udma_ahb_req_rd_byte_en_net              = {4{1'b0}};
    assign udma_ahb_req_wr_byte_en_net              = {4{1'b0}};
    assign udma_ahb_req_read_net                    = 1'b0; 
    assign udma_ahb_req_write_net                   = 1'b0;
    assign udma_ahb_req_addr_net                    = {AHB_MSTR_ADDR_WIDTH{1'b0}};
    assign udma_ahb_req_addr_p_net                  = 1'b0;  
    assign udma_ahb_req_len_net                     = {4{1'b0}};
    assign udma_ahb_req_wr_data_net                 = {32{1'b0}};
    assign udma_ahb_req_wr_data_p_net               = {4{1'b0}};
    assign udma_ahb_req_wr_data_last_net            = 1'b0;  
    assign udma_ahb_resp_ready_net                  = 1'b0;  
    assign lmem_dap_udma_ctrl_req_ready_net          = 1'b0;  
    assign lmem_dap_udma_ctrl_resp_valid_net         = 1'b0;  
    assign lmem_dap_udma_ctrl_resp_rd_error_net      = 1'b0;  
    assign lmem_dap_udma_ctrl_resp_rd_data_net       = {32{1'b0}};
    assign lmem_dap_udma_ctrl_resp_rd_data_p_net     = {4{1'b0}};
    assign udma_trx_os_d_rd_net                      = 1'b0;
    assign udma_trx_os_d_wr_net                      = 1'b0;
    assign lmem_dap_udma_ctrl_irq                    = 1'b0;
  
  end   
  endgenerate                   


// MTIME
//--------------------------------------------
  
generate
if(INTERNAL_MTIME | INTERNAL_MTIME_IRQ)
  begin : gen_mtime
    assign apb_mstr_int_sel     = (apb_mstr_paddr[APB_MSTR_ADDR_WIDTH-1:3] == l_mtime_addr_base[APB_MSTR_ADDR_WIDTH-1:3]) | 
                                  (apb_mstr_paddr[APB_MSTR_ADDR_WIDTH-1:3] == l_mtimecmp_addr_base[APB_MSTR_ADDR_WIDTH-1:3]) ? 1'b1 : 1'b0;
  								 
    assign apb_mstr_psel        = (apb_mstr_int_sel)   ? 1'b0                 : apb_mstr_psel_net;
    assign apb_mstr_penable     = (apb_mstr_int_sel)   ? 1'b0                 : apb_mstr_penable_net; 
    assign apb_mstr_psel_int    = (apb_mstr_int_sel)   ? apb_mstr_psel_net    : 1'b0;
    assign apb_mstr_penable_int = (apb_mstr_int_sel)   ? apb_mstr_penable_net : 1'b0; 
    assign apb_mstr_pslverr_net = (apb_mstr_int_sel)   ? apb_mstr_pslverr_int : apb_mstr_pslverr;
    assign apb_mstr_pready_net  = (apb_mstr_int_sel)   ? apb_mstr_pready_int  : apb_mstr_pready ;
    assign apb_mstr_prdata_net  = (apb_mstr_int_sel)   ? apb_mstr_prdata_int  : apb_mstr_prdata ;   
    assign mtime_count_sel      = (INTERNAL_MTIME)     ? mtime_count_int      : mtime_count ;
    assign m_timer_irq_sel      = (INTERNAL_MTIME_IRQ) ? m_timer_irq_int      : m_timer_irq ;
	assign mtime_count_out      = mtime_count_int;
  	
    MIV_RV32IMC_mtime_irq 
      #(
       .INTERNAL_MTIME(INTERNAL_MTIME),
       .INTERNAL_MTIME_IRQ(INTERNAL_MTIME_IRQ),
       .MTIME_PRESCALER(MTIME_PRESCALER)
       ) 
       u_mtime_irq 
       ( 
       .pclk           (clk),     
       .presetn        (resetn),   
       .penable        (apb_mstr_penable_int), 
       .psel           (apb_mstr_psel_int),   
       .paddr          (apb_mstr_paddr),     
       .pwrite         (apb_mstr_pwrite),   
       .pwdata         (apb_mstr_pwdata),   
       .prdata         (apb_mstr_prdata_int),     
       .pready         (apb_mstr_pready_int),     
       .pslverr        (apb_mstr_pslverr_int),    
       					  
       .m_timer_irq    (m_timer_irq_int),   
       .mtime_count_in (mtime_count),
       .mtime_count_out(mtime_count_int)
       );     
    end else begin  : ngen_mtime
	  assign m_timer_irq_int      = 1'b0;
      assign apb_mstr_penable_int = 1'b0; 
      assign apb_mstr_psel_int    = 1'b0;   
      assign apb_mstr_prdata_int  = 32'b0;     
      assign apb_mstr_pready_int  = 1'b0;     
      assign apb_mstr_pslverr_int = 1'b0; 
      assign apb_mstr_int_sel     = 1'b0; 							 
      assign apb_mstr_psel        = apb_mstr_psel_net;
      assign apb_mstr_penable     = apb_mstr_penable_net; 
      assign apb_mstr_pslverr_net = apb_mstr_pslverr;
      assign apb_mstr_pready_net  = apb_mstr_pready ;
      assign apb_mstr_prdata_net  = apb_mstr_prdata ;   
      assign mtime_count_sel      = mtime_count ;
      assign m_timer_irq_sel      = m_timer_irq ;
	  assign mtime_count_int      = 64'b0;
	  assign mtime_count_out      = 64'b0;
	end
endgenerate	

endmodule


`default_nettype wire
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_axi_egress_buffer.sv
//
//   Purpose: Egress buffer, buffers data leaving the AXI master/slave
//            Write side is clocked at core rate
//            Read side also clocked at core rate, but enable can make it appear 
//            to be at a different (synchronous integer multiple) rate
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_axi_egress_buffer
//********************************************************************************
// Parameter description

  #(
    parameter BUFF_WIDTH = 36,
    parameter BUFF_SIZE = 2,
    parameter PTR_SIZE = 1
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    input wire                               clken,
    
    input wire                               valid_in,
    output wire                              ready_in,
    input wire [BUFF_WIDTH-1:0]              data_in,
    
    output wire [BUFF_WIDTH-1:0]             data_out,
    output wire                              valid_out,
    
    input wire                               ready_out,  
    
    output wire [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd,
    output wire [BUFF_SIZE-1:0]              valid_out_pkd,
    
    output wire                              nearly_full  
    
 
    
  );

//********************************************************************************
// localparams
  localparam BUFF_MAX = BUFF_SIZE-1;

// Declarations

  reg  [PTR_SIZE-1:0]              buff_wr_ptr;
  reg  [PTR_SIZE-1:0]              buff_rd_ptr;
  wire [PTR_SIZE-1:0]              next_buff_wr_ptr;
  wire [PTR_SIZE-1:0]              next_buff_rd_ptr;
  
  wire [BUFF_SIZE-1:0]             buff_wr_strb;
  wire [BUFF_SIZE-1:0]             buff_rd_strb;
  wire [BUFF_SIZE-1:0]             next_alloc;
  
  reg [BUFF_SIZE-1:0]              buff_valid;
  wire [BUFF_SIZE-1:0]             next_buff_valid;
  reg [BUFF_WIDTH-1:0]             buff_data[BUFF_SIZE-1:0]; 
  wire                             valid_out_net;
  
  wire                             rd_data;
  wire                             wr_data;
  
  wire                             full;
  wire                             empty;
  
  reg [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd_reg;
  reg [BUFF_SIZE-1:0]              valid_out_pkd_reg;
  
  wire                             next_buff_ready;
  reg                              buff_ready_reg;

  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************

  assign full     = &buff_valid;
  assign empty    = ~(|buff_valid);
  assign wr_data  = valid_in & buff_ready_reg;
  assign rd_data  = ready_out & valid_out_net & clken;
  
  
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_rd_ptr <= {PTR_SIZE{1'b0}};
    else
      if(rd_data)
        buff_rd_ptr <= next_buff_rd_ptr;        
  end 
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_wr_ptr <= {PTR_SIZE{1'b0}};
    else
      if(wr_data)
        buff_wr_ptr <= next_buff_wr_ptr;
  end
  
  assign next_buff_wr_ptr = (buff_wr_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_wr_ptr+1;
  assign next_buff_rd_ptr = (buff_rd_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_rd_ptr+1;
  
  
  
  generate
  genvar gen_buff;
  for(gen_buff = 0; gen_buff<BUFF_SIZE; gen_buff=gen_buff+1)
  begin : gen_buff_loop
  
    assign buff_wr_strb[gen_buff] = wr_data & (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign next_alloc[gen_buff] = (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign buff_rd_strb[gen_buff] = rd_data & (buff_rd_ptr == gen_buff[PTR_SIZE-1:0]);
  
    // Data not reset
    always @(posedge clk)
    begin    
      begin
        if(buff_wr_strb[gen_buff])
        begin
          buff_data[gen_buff] <= data_in;
        end
      end
    end
  
  
    assign next_buff_valid[gen_buff] = (buff_valid[gen_buff] & ~buff_rd_strb[gen_buff]) | 
                                       buff_wr_strb[gen_buff];
  
    always @(posedge clk or negedge resetn)
    begin
      if(~resetn)
        buff_valid[gen_buff]  <=  1'b0;
      else
        buff_valid[gen_buff]  <= next_buff_valid[gen_buff]; 
    end  
    
  end
  endgenerate
  
  assign data_out      = buff_data[buff_rd_ptr];
  assign valid_out_net = buff_valid[buff_rd_ptr]; 
  assign valid_out     = valid_out_net;
  
  // only allow buffer to be written when aclk_en is asserted or
  // the location written will not be the same as the one read
  // This prevents the output value changing due to a buffer slot
  // being written on a core clock edge but not on a axi clk edge
  
  assign next_buff_ready = (~(&next_buff_valid)) & 
                           (clken | (buff_rd_ptr == buff_wr_ptr));
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_ready_reg <= 1'b0;
    else
      buff_ready_reg <= next_buff_ready;       
  end
  
  assign ready_in = buff_ready_reg;

  
  //assign packed outputs
  always @*
  begin: pkd_out_loop
    integer i;
    for(i=0;i<BUFF_SIZE; i=i+1)
    begin
      data_out_pkd_reg[(i*BUFF_WIDTH)+:BUFF_WIDTH] = buff_data[i];
      valid_out_pkd_reg[i] = buff_valid[i];
    end
  end
  
  assign data_out_pkd  = data_out_pkd_reg;
  assign valid_out_pkd = valid_out_pkd_reg; 
  
  // if the next buffer slot to be allocated would cause the buffer to become full if a write occurs
  // without a read, assert the nearly_full output
  assign nearly_full = &(buff_valid | next_alloc);
  


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_axi_egress_buffer.sv
//
//   Purpose: Egress buffer, buffers data leaving the AXI master/slave
//            Write side is clocked at core rate
//            Read side also clocked at core rate, but enable can make it appear 
//            to be at a different (synchronous integer multiple) rate
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_axi_egress_slip_buffer
//********************************************************************************
// Parameter description

  #(
    parameter BUFF_WIDTH = 1
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    input wire                               clken,
    
    input wire                               valid_in,
    output wire                              ready_in,
    input wire [BUFF_WIDTH-1:0]              data_in,
    
    output wire [BUFF_WIDTH-1:0]             data_out,
    output wire                              valid_out,    
    input wire                               ready_out,  
    
    output wire                              nearly_full  
    
 
    
  );

//********************************************************************************
// localparams

// Declarations

  wire                    alloc_output_buff;
  wire                    dealloc_output_buff; 
  reg                     output_buff_valid;
  wire                    next_output_buff_valid;  
  reg [BUFF_WIDTH-1:0]    output_buff_data;
  wire [BUFF_WIDTH-1:0]   next_output_buff_data;
  wire                    alloc_output_buff_from_slip;
  wire                    alloc_output_buff_from_din;
  
  wire                    alloc_slip_buff;
  wire                    dealloc_slip_buff;
  wire                    slip_buff_valid;
  wire [BUFF_WIDTH-1:0]   slip_buff_data;
 
  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************


  // output buffer (buff0)
  // AXI requires the output to be stable when clken is not asserted 
  // if the output buffer is empty and aclk is enabled assign the output buffer
  // directly, otherwise assign the slip buffer
  
  assign alloc_output_buff   = alloc_output_buff_from_slip | alloc_output_buff_from_din;
                                        
  assign alloc_output_buff_from_slip =  clken & slip_buff_valid & 
                                        ((~output_buff_valid) | dealloc_output_buff);
  
  assign alloc_output_buff_from_din =  clken & ~slip_buff_valid &
                                               valid_in & 
                                        ((~output_buff_valid) | dealloc_output_buff);                                      
                                                                             
  // deallocate output buffer (make invalid) when data is accepted
  assign dealloc_output_buff = clken & output_buff_valid & ready_out;
  
  // Data not reset  
  assign next_output_buff_data = alloc_output_buff ? (slip_buff_valid ? slip_buff_data : data_in) : output_buff_data;
  always @(posedge clk)
  begin
    if(clken)
      output_buff_data <= next_output_buff_data;
  end
    
  assign next_output_buff_valid = (output_buff_valid & ~dealloc_output_buff) | alloc_output_buff;
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      output_buff_valid  <=  1'b0;
    else if(clken)
      output_buff_valid  <= next_output_buff_valid;       
  end 
  
  assign valid_out = output_buff_valid;
  assign data_out  = output_buff_data;
  
  // the slip buffer is a 2 entry ping pong circular buffer (fifo)
  
  // Allocate the slip buffer unless the entry can be directly allocated to the
  // output buffer
  assign alloc_slip_buff     =  valid_in & ~alloc_output_buff_from_din;
  // when data is moved to output buffer, deallocate slot
  assign dealloc_slip_buff = alloc_output_buff;
  
  MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         (BUFF_WIDTH), 
    .BUFF_SIZE          (2),
    .PTR_SIZE           (1)
  )
  u_req_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (alloc_slip_buff),
    .ready_in           (ready_in),
    .data_in            (data_in),
    .data_out           (slip_buff_data),
    .valid_out          (slip_buff_valid),
    .ready_out          (alloc_output_buff),
    .data_out_pkd       (), // open
    .valid_out_pkd      (), // open
    .nearly_full        (nearly_full)  // open
  );

  // REVISIT make ready_in more agressive?
  // can factor in output buffer ready too?
endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_axi_ingress_buffer.sv
//
//   Purpose: Ingress buffer, buffers data entering the AXI master/slave
//            Read side is clocked at core rate
//            Write side also clocked at core rate, but enable can make it appear 
//            to be at a different (synchronous integer multiple) rate
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_axi_ingress_buffer
//********************************************************************************
// Parameter description

  #(
    parameter BUFF_WIDTH = 36,
    parameter BUFF_SIZE = 2,
    parameter PTR_SIZE = 1
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    input wire                               clken,
    
    input wire                               valid_in,
    output wire                              ready_in,
    input wire [BUFF_WIDTH-1:0]              data_in,
    
    output wire [BUFF_WIDTH-1:0]             data_out,
    output wire                              valid_out,
    
    input wire                               ready_out,  
    
    output wire [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd,
    output wire [BUFF_SIZE-1:0]              valid_out_pkd,
    
    output wire                              nearly_full  
    
 
    
  );

//********************************************************************************
// localparams
  localparam BUFF_MAX = BUFF_SIZE-1;

// Declarations

  reg  [PTR_SIZE-1:0]              buff_wr_ptr;
  reg  [PTR_SIZE-1:0]              buff_rd_ptr;
  wire [PTR_SIZE-1:0]              next_buff_wr_ptr;
  wire [PTR_SIZE-1:0]              next_buff_rd_ptr;
  
  wire [BUFF_SIZE-1:0]             buff_wr_strb;
  wire [BUFF_SIZE-1:0]             buff_rd_strb;
  wire [BUFF_SIZE-1:0]             next_alloc;
  
  reg [BUFF_SIZE-1:0]              buff_valid;
  wire [BUFF_SIZE-1:0]             next_buff_valid;
  reg [BUFF_WIDTH-1:0]             buff_data[BUFF_SIZE-1:0]; 
  
  wire                             rd_data;
  wire                             wr_data;
  
  wire                             full;
  wire                             empty;
  
  reg [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd_reg;
  reg [BUFF_SIZE-1:0]              valid_out_pkd_reg;
  
  wire                             next_buff_ready;
  reg                              buff_ready_reg;

  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************

  assign full     = &buff_valid;
  assign empty    = ~(|buff_valid);
  assign wr_data  = valid_in & buff_ready_reg & clken;
  assign rd_data  = ready_out & ~empty;
  
  
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_rd_ptr <= {PTR_SIZE{1'b0}};
    else
      if(rd_data)
        buff_rd_ptr <= next_buff_rd_ptr;        
  end 
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_wr_ptr <= {PTR_SIZE{1'b0}};
    else
      if(wr_data)
        buff_wr_ptr <= next_buff_wr_ptr;
  end
  
  assign next_buff_wr_ptr = (buff_wr_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_wr_ptr+1;
  assign next_buff_rd_ptr = (buff_rd_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_rd_ptr+1;
  
  
  
  generate
  genvar gen_buff;
  for(gen_buff = 0; gen_buff<BUFF_SIZE; gen_buff=gen_buff+1)
  begin : gen_buff_loop
  
    assign buff_wr_strb[gen_buff] = wr_data & (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign next_alloc[gen_buff] = (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign buff_rd_strb[gen_buff] = rd_data & (buff_rd_ptr == gen_buff[PTR_SIZE-1:0]);
  
    // Data not reset
    always @(posedge clk)
    begin    
      begin
        if(buff_wr_strb[gen_buff])
        begin
          buff_data[gen_buff] <= data_in;
        end
      end
    end
  
  
    assign next_buff_valid[gen_buff] = (buff_valid[gen_buff] & ~buff_rd_strb[gen_buff]) | 
                                       buff_wr_strb[gen_buff];
  
    always @(posedge clk or negedge resetn)
    begin
      if(~resetn)
        buff_valid[gen_buff]  <=  1'b0;
      else
        buff_valid[gen_buff]  <= next_buff_valid[gen_buff]; 
    end  
    
  end
  endgenerate
  
  assign data_out = buff_data[buff_rd_ptr];
  assign valid_out = buff_valid[buff_rd_ptr];
  
  assign next_buff_ready = ~(&next_buff_valid);
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_ready_reg <= 1'b0;
    else
      if(clken)
        buff_ready_reg <= next_buff_ready;       
  end
  
  assign ready_in = buff_ready_reg;

  
  //assign packed outputs
  always @*
  begin: pkd_out_loop
    integer i;
    for(i=0;i<BUFF_SIZE; i=i+1)
    begin
      data_out_pkd_reg[(i*BUFF_WIDTH)+:BUFF_WIDTH] = buff_data[i];
      valid_out_pkd_reg[i] = buff_valid[i];
    end
  end
  
  assign data_out_pkd  = data_out_pkd_reg;
  assign valid_out_pkd = valid_out_pkd_reg; 
  
  // if the next buffer slot to be allocated would cause the buffer to become full if a write occurs
  // without a read, assert the nearly_full output
  assign nearly_full = &(buff_valid | next_alloc);
  


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

//
//   File:
//   MIV_RV32IMC_axi_mstr_rchan.sv
//
//   Purpose:
//    opsrv_Bridge AXI Master read/read response channel
//   
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_axi_rchan
//********************************************************************************
// Parameter description

  #(   
    parameter AXI_MSTR_RADDR_WIDTH = 32,
    parameter NUM_REQUESTERS = 2,
    parameter NUM_OS_READS = 4,
    parameter LOG2_NUM_OS_READS = 2
   )

//********************************************************************************
// Port description

  (    
    input wire                                           resetn,
    input wire                                           clk,
    input wire                                           aclk_en,
    // controls   
    //output wire                                          mstr_r_idle,
    output wire [NUM_REQUESTERS-1:0]                     read_parity_error,
    input wire                                           opsrv_parity_en,
    input wire                                           cfg_fence_all,
    input wire [3:0]                                     cfg_ar_cache,
    //RADDR channel (and sidebands)
    output wire                                          aximstr_arid,
    output wire [AXI_MSTR_RADDR_WIDTH-1:0]               aximstr_araddr,
    output wire [3:0]                                    aximstr_arlen,
    output wire [2:0]                                    aximstr_arsize,
    output wire [1:0]                                    aximstr_arburst,
    output wire                                          aximstr_arlock,
    output wire [3:0]                                    aximstr_arcache,
    output wire [2:0]                                    aximstr_arprot,
    input wire                                           aximstr_arready,
    output wire                                          aximstr_arvalid,
    output wire                                          aximstr_ar_addr_p,
    //RRESP channel (and sidebands)
    input wire [1:0]                                     aximstr_rresp,
    input wire [31:0]                                    aximstr_rdata,
    input wire                                           aximstr_rlast,
    input wire                                           aximstr_rid,
    output wire                                          aximstr_rready,
    input wire                                           aximstr_rvalid,
    input wire [3:0]                                     aximstr_r_data_p,
       
    //cpu i-side
    input wire [AXI_MSTR_RADDR_WIDTH-1:0]                cpu_i_axi_araddr,
    input wire [3:0]                                     cpu_i_axi_arlen,
    input wire [2:0]                                     cpu_i_axi_arsize,
    output wire                                          cpu_i_axi_arready,
    input wire                                           cpu_i_axi_arvalid,
    input wire                                           cpu_i_axi_rready,
    output wire                                          cpu_i_axi_rvalid,
    output wire [1:0]                                    cpu_i_axi_rresp,
    output wire                                          cpu_i_axi_rlast,
    output wire [31:0]                                   cpu_i_axi_rdata,
    output wire [3:0]                                    cpu_i_axi_rdata_p,  
    input wire                                           cpu_i_axi_fence_rd_flush,    
    output wire                                          cpu_i_axi_fence_rd_os,   
    input wire                                           cpu_i_axi_raw_hzd,  
    //cpu d-side
    input wire [AXI_MSTR_RADDR_WIDTH-1:0]                cpu_d_axi_araddr,
    input wire [3:0]                                     cpu_d_axi_arlen,
    input wire [2:0]                                     cpu_d_axi_arsize,
    output wire                                          cpu_d_axi_arready,
    input wire                                           cpu_d_axi_arvalid,
    input wire                                           cpu_d_axi_rready,
    output wire                                          cpu_d_axi_rvalid,
    output wire [1:0]                                    cpu_d_axi_rresp,
    output wire                                          cpu_d_axi_rlast,
    output wire [31:0]                                   cpu_d_axi_rdata,
    output wire [3:0]                                    cpu_d_axi_rdata_p,  
    input wire                                           cpu_d_axi_fence_rd_flush,    
    output wire                                          cpu_d_axi_fence_rd_os,  
    input wire                                           cpu_d_axi_raw_hzd,                     
    //udma
    input wire [AXI_MSTR_RADDR_WIDTH-1:0]                udma_axi_araddr,
    input wire [3:0]                                     udma_axi_arlen,
    input wire [2:0]                                     udma_axi_arsize,
    output wire                                          udma_axi_arready,
    input wire                                           udma_axi_arvalid,
    input wire                                           udma_axi_rready,
    output wire                                          udma_axi_rvalid,
    output wire [1:0]                                    udma_axi_rresp,
    output wire                                          udma_axi_rlast,
    output wire [31:0]                                   udma_axi_rdata,
    output wire [3:0]                                    udma_axi_rdata_p, 
    input wire                                           udma_axi_fence_rd_flush,    
    output wire                                          udma_axi_fence_rd_os, 
    input wire                                           udma_axi_raw_hzd, 
    // outstanding read transaction addresses
    output wire [(NUM_OS_READS*AXI_MSTR_RADDR_WIDTH)-1:0]   os_read_addr_pkd,
    output wire [NUM_OS_READS-1:0]                          os_read_valid_pkd,
    output wire [NUM_OS_READS-1:0]                          os_read_cpu_d_valid_pkd
  );

//********************************************************************************
// Declarations

// localparams
  localparam AR_BUFF_WIDTH = AXI_MSTR_RADDR_WIDTH + 4 + 3 + 1;
  localparam R_BUFF_WIDTH  = 2 + 32 + 1 + 4;
  
  localparam RESP_OKAY   = 2'b00;
  localparam RESP_EXOKAY = 2'b01;
  localparam RESP_SLVERR = 2'b10;
  localparam RESP_DECERR = 2'b11;

// Internal nets/regs

  logic [NUM_REQUESTERS-1:0]                                 cpu_ar_req;
  logic [NUM_REQUESTERS-1:0]                                 cpu_ar_gnt;
  logic                                                      raddr_buffer_ready;
  logic                                                      accept_req;
  logic                                                      r_os_buffer_ready;
  
  logic [31:0]                                               cpu_araddr[NUM_REQUESTERS-1:0];
  logic [1:0]                                                cpu_id [NUM_REQUESTERS-1:0];
  logic [3:0]                                                cpu_arlen[NUM_REQUESTERS-1:0]; 
  logic [2:0]                                                cpu_arsize[NUM_REQUESTERS-1:0];
  logic [NUM_REQUESTERS-1:0]                                 cpu_addr_p;        
  logic [NUM_REQUESTERS-1:0]                                 cpu_arvalid;
  logic [NUM_REQUESTERS-1:0]                                 cpu_rvalid;
  logic [NUM_REQUESTERS-1:0]                                 cpu_rlast;
  logic [NUM_REQUESTERS-1:0]                                 cpu_rready;
  logic [NUM_REQUESTERS-1:0]                                 raw_hzd; 
  
  logic [AXI_MSTR_RADDR_WIDTH-1:0]                           cpu_araddr_mux;
  logic [3:0]                                                cpu_arlen_mux;
  logic [2:0]                                                cpu_arsize_mux;
  logic                                                      cpu_addr_p_mux;
  logic [1:0]                                                cpu_id_mux;
  logic                                                      cpu_num_mux;
  
  logic [AXI_MSTR_RADDR_WIDTH-1:0]                           cpu_araddr_buff;
  logic [3:0]                                                cpu_arlen_buff;
  logic [3:0]                                                cpu_arcache_buff;
  logic [2:0]                                                cpu_arsize_buff;
  logic                                                      cpu_addr_p_buff;
  
  logic [1:0]                                                resp_buff_rresp;
  logic [31:0]                                               resp_buff_rdata;
  logic                                                      resp_buff_rlast;
  logic                                                      axi_resp_buff_rid; 
  logic                                                      cpu_resp_buff_rid;   
  logic [3:0]                                                resp_buff_rdata_p;
  logic                                                      resp_buff_valid;
  logic [1:0]                                                resp_id_index;
  
  logic [AR_BUFF_WIDTH-1:0]                                  ar_out_buff_in;
  logic [AR_BUFF_WIDTH-1:0]                                  ar_out_buff_out;
  
  logic [R_BUFF_WIDTH-1:0]                                   rresp_buff_in;
  logic [R_BUFF_WIDTH-1:0]                                   rresp_buff_out;
  logic                                                      resp_buff_ready;
  logic                                                      resp_buff_valid_last;
  logic [AXI_MSTR_RADDR_WIDTH-3:0]                           curr_resp_id_addr;
  
  logic                                                      rbyte_parity_err;
  
  logic [NUM_REQUESTERS-1:0]                                 cpu_fence_flush;
  logic [NUM_REQUESTERS-1:0]                                 fence_flush;
  logic [NUM_REQUESTERS-1:0]                                 cpu_rd_os;
  
  logic [(NUM_OS_READS*AXI_MSTR_RADDR_WIDTH)-1:0]            os_read_addr_pkd_net;
  logic [(NUM_OS_READS*2)-1:0]                               os_read_id_pkd_net;
  logic [NUM_OS_READS-1:0]                                   os_rd_cpud_dma_net;
  logic [((NUM_OS_READS+1)*2)-1:0]                           os_read_id_pkd;
  logic [(NUM_OS_READS*(AXI_MSTR_RADDR_WIDTH-2))-1:0]        os_read_id_addr_pkd_net;
  logic [NUM_OS_READS-1:0]                                   os_read_valid_pkd_net;
  

//********************************************************************************
// Main code

  // Read requests from the CPU D-side are directly arbitrated.
  // Reads from the I-side are made to the prefetch unit which then makes a request to 
  // the master.
  
  // put in an array so can be dealt with in a loop 
// cpu i
    assign cpu_araddr[0]         = cpu_i_axi_araddr;
    assign cpu_id[0]             = 2'd0;
    assign cpu_arlen[0]          = cpu_i_axi_arlen;
    assign cpu_arsize[0]         = cpu_i_axi_arsize;
    assign cpu_arvalid[0]        = cpu_i_axi_arvalid;
    assign cpu_i_axi_arready     = cpu_ar_gnt[0];
    assign cpu_rready[0]         = cpu_i_axi_rready;
    assign cpu_i_axi_rvalid      = cpu_rvalid[0];
    assign cpu_i_axi_rlast       = cpu_rlast[0];
    assign cpu_i_axi_rresp       = resp_buff_rresp;
    assign cpu_i_axi_rdata       = resp_buff_rdata;
    assign cpu_i_axi_rdata_p     = resp_buff_rdata_p;
    assign read_parity_error[0]  = rbyte_parity_err & cpu_rvalid[0];
    assign cpu_fence_flush[0]     = cpu_i_axi_fence_rd_flush;
    assign cpu_i_axi_fence_rd_os  = (cfg_fence_all  & (|cpu_rd_os)) |
                                   (~cfg_fence_all  & cpu_rd_os[0]);
    assign raw_hzd[0]             = cpu_i_axi_raw_hzd;                            

// cpu d
    assign cpu_araddr[1]         = cpu_d_axi_araddr;
    assign cpu_id[1]             = 2'd1;
    assign cpu_arlen[1]          = cpu_d_axi_arlen;
    assign cpu_arsize[1]         = cpu_d_axi_arsize;
    assign cpu_arvalid[1]        = cpu_d_axi_arvalid;
    assign cpu_d_axi_arready     = cpu_ar_gnt[1];
    assign cpu_rready[1]         = cpu_d_axi_rready;
    assign cpu_d_axi_rvalid      = cpu_rvalid[1];
    assign cpu_d_axi_rlast       = cpu_rlast[1];
    assign cpu_d_axi_rresp       = resp_buff_rresp;
    assign cpu_d_axi_rdata       = resp_buff_rdata;
    assign cpu_d_axi_rdata_p     = resp_buff_rdata_p;
    assign read_parity_error[1]  = rbyte_parity_err & cpu_rvalid[1];
    assign cpu_fence_flush[1]     = cpu_d_axi_fence_rd_flush;
    assign cpu_d_axi_fence_rd_os  = (cfg_fence_all  & (|cpu_rd_os)) |
                                   (~cfg_fence_all  & cpu_rd_os[1]);
    assign raw_hzd[1]             = cpu_d_axi_raw_hzd;    

  generate
  if((NUM_REQUESTERS >= 3)) begin: gen_assign_udma_cons
    assign cpu_araddr[2]         = udma_axi_araddr;
    assign cpu_id[2]             = 2'd2;
    assign cpu_arlen[2]          = udma_axi_arlen;
    assign cpu_arsize[2]         = udma_axi_arsize;
    assign cpu_arvalid[2]        = udma_axi_arvalid;
    assign udma_axi_arready      = cpu_ar_gnt[2];
    assign cpu_rready[2]         = udma_axi_rready;
    assign udma_axi_rvalid       = cpu_rvalid[2];
    assign udma_axi_rlast        = cpu_rlast[2];
    assign udma_axi_rresp        = resp_buff_rresp;
    assign udma_axi_rdata        = resp_buff_rdata;
    assign udma_axi_rdata_p      = resp_buff_rdata_p;
    assign read_parity_error[2]  = rbyte_parity_err & cpu_rvalid[2];
    assign cpu_fence_flush[2]     = udma_axi_fence_rd_flush;
    assign udma_axi_fence_rd_os   = (cfg_fence_all  & (|cpu_rd_os)) |
                                   (~cfg_fence_all  & cpu_rd_os[2]);
    assign raw_hzd[2]             = udma_axi_raw_hzd;    
  end
  else begin : ngen_assign_udma_cons
    assign udma_axi_arready      = 1'b0;
    assign udma_axi_rvalid       = 1'b0;
    assign udma_axi_rlast        = 1'b0;
    assign udma_axi_rresp        = 2'b00;
    assign udma_axi_rdata        = {32{1'b0}};
    assign udma_axi_rdata_p      = {4{1'b0}};
    assign udma_axi_fence_rd_os   = 1'b0;
  end   
  endgenerate
 

  // When cfg_fence_all is asserted stop accepting requests from all cpus except the 
  // one(s) that issues a flush
  assign fence_flush = {NUM_REQUESTERS{(cfg_fence_all & (|cpu_fence_flush))}} 
                      & ~cpu_fence_flush;
  
  generate
  genvar i_req;
  for (i_req = 0; i_req < NUM_REQUESTERS; i_req = i_req+1) begin : gen_req
    // allow a request to propagate if there are:
    //   - no fence flushes in progress
    //   - there is space in the output buffer (ie ar channel not backpressured)
    //   - there is space in the read request os tracking buffer
    //   - theer are no read-after-write hazards outstanding for the current request
    assign cpu_ar_req[i_req] = cpu_arvalid[i_req] & 
                               (~fence_flush[i_req]) &
                                raddr_buffer_ready &
                                r_os_buffer_ready &
                                ~raw_hzd[i_req];
                                  
    // compute address parity in parallel for each source and multiplex so it can be computed 
    // whilst arbitrating    
    assign cpu_addr_p[i_req] = ^cpu_araddr[i_req];                               
 
  end
  endgenerate
  
  // arbitrate write requests
    
  MIV_RV32IMC_rr_pri_arb
  //***************************************************************
  // Parameter description
  #(
    .NUM_REQS                  (NUM_REQUESTERS),
    .USE_FORMAL                (1),
    .USE_SIM                   (1)
   )

  u_raddr_arb
  //***************************************************************
  // Signal description
  (
    .resetn              (resetn),
    .clk                 (clk),
    .unlock              (1'b1),
    .req                 (cpu_ar_req),
    .gnt                 (cpu_ar_gnt),
    .sel_seq             (),                   //open
    .sel_early           ()                    //open
  );
  
  // ar request multiplexer
  
  always @*
  begin : raddr_mux_loop
    integer i;
    cpu_araddr_mux    = {AXI_MSTR_RADDR_WIDTH{1'b0}};  
    cpu_arlen_mux     = {4{1'b0}};
    cpu_id_mux        = 2'd0;
    cpu_arsize_mux    = {3{1'b0}};
    cpu_addr_p_mux    = 1'b0;
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_araddr_mux    = cpu_araddr_mux  | ({AXI_MSTR_RADDR_WIDTH{cpu_ar_gnt[i]}} & cpu_araddr[i]); 
      cpu_id_mux        = cpu_id_mux      | ({2{cpu_ar_gnt[i]}}  & cpu_id[i]);  
      cpu_arlen_mux     = cpu_arlen_mux   | ({4{cpu_ar_gnt[i]}}  & cpu_arlen[i]); 
      cpu_arsize_mux    = cpu_arsize_mux  | ({3{cpu_ar_gnt[i]}}  & cpu_arsize[i]); 
      cpu_addr_p_mux    = cpu_addr_p_mux  | (cpu_ar_gnt[i]       & cpu_addr_p[i]);
    end
  end
  

  // request/data output buffers
  
  assign accept_req = |cpu_ar_gnt; 
  
  assign ar_out_buff_in = {cpu_araddr_mux,
                           cpu_arlen_mux,
                           cpu_arsize_mux,
                           cpu_addr_p_mux};
                           
  assign {cpu_araddr_buff,
          cpu_arlen_buff,
          cpu_arsize_buff,
          cpu_addr_p_buff} = ar_out_buff_out;
         
  
  
  MIV_RV32IMC_axi_egress_slip_buffer
  #(
    .BUFF_WIDTH         (AR_BUFF_WIDTH)
  )
  u_raddr_output_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .clken              (aclk_en),
    .valid_in           (accept_req),
    .ready_in           (raddr_buffer_ready),
    .data_in            (ar_out_buff_in),
    .data_out           (ar_out_buff_out),
    .valid_out          (aximstr_arvalid),
    .ready_out          (aximstr_arready), 
    .nearly_full        ()  //open  
  );
  
  // Read response buffer
  
  assign rresp_buff_in = 
         {aximstr_rresp,aximstr_rdata,aximstr_rlast,aximstr_r_data_p};
         
  assign {resp_buff_rresp,resp_buff_rdata,resp_buff_rlast,resp_buff_rdata_p} = 
         rresp_buff_out;
                
  
  MIV_RV32IMC_axi_ingress_buffer
  #(
    .BUFF_WIDTH         (R_BUFF_WIDTH), 
    .BUFF_SIZE          (2),
    .PTR_SIZE           (1)
  )
  u_rresp_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .clken              (aclk_en),
    .valid_in           (aximstr_rvalid),
    .ready_in           (aximstr_rready),
    .data_in            (rresp_buff_in),
    .data_out           (rresp_buff_out),
    .valid_out          (resp_buff_valid),
    .ready_out          (resp_buff_ready),
    .data_out_pkd       (), //open
    .valid_out_pkd      (), //open  
    .nearly_full        ()  //open  
  );
  
  
  // The response is forwarded to the appropriate destination based on the response ID by asserting valid
  // (all other fields broadcast)

  
  
  // select read from CPU that generated the request
  assign resp_id_index = curr_resp_id_addr[(AXI_MSTR_RADDR_WIDTH-4)+:2];
  assign resp_buff_ready = |cpu_rready;
  
  always @*
  begin : respid_map_loop
    integer i;
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_rvalid[i] = (resp_id_index == i[1:0]) & resp_buff_valid;
      cpu_rlast[i]  = (resp_id_index == i[1:0]) & resp_buff_rlast;
    end
  end  
  
  always @*
  begin :rd_parity_err_loop
    reg tmp_err;
    integer i;
    tmp_err = 1'b0;
    for(i=0; i<4; i=i+1)
    begin
      tmp_err = tmp_err | (^{resp_buff_rdata_p[i],resp_buff_rdata[i*8+:8]});
    end
    rbyte_parity_err = tmp_err & opsrv_parity_en;
  end 
  
  // assign AXI outputs
  assign aximstr_arid        = 1'b0;
  assign aximstr_araddr      = cpu_araddr_buff;
  assign aximstr_arlen       = cpu_arlen_buff;
  assign aximstr_arsize      = cpu_arsize_buff;
  assign aximstr_arburst     = 2'b01;    // Always incrementing
  assign aximstr_arlock      = 1'b0;    // Always normal (no lock, no exclusive) for now
  assign aximstr_arcache     = cfg_ar_cache;
  assign aximstr_arprot      = 3'b010;   // Always data, non-secure, normal
  assign aximstr_ar_addr_p   = cpu_addr_p_buff;


  

  // outstanding request buffer. 
  // This stores a list of the address (16B granularity) and Requester ID of outstanding read transactions 
  // such that the master can keep track of them to reassociate responses and manage WAR hazards.
  // An entry is added to the buffer when a request is successfully arbitrated
  // An entry is removed from the list when a read request  completes 
  // Since the OPSRV AXI master only supports one ID, all responses are received in order so only a simple buffer
  // to maintain the list is required
  
  assign resp_buff_valid_last = resp_buff_valid & resp_buff_ready & resp_buff_rlast; 
  

  
    MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         ((AXI_MSTR_RADDR_WIDTH-2)), 
    .BUFF_SIZE          (NUM_OS_READS),
    .PTR_SIZE           (LOG2_NUM_OS_READS)
  )
  u_ros_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (accept_req),
    .ready_in           (r_os_buffer_ready),
    .data_in            ({cpu_id_mux,(cpu_araddr_mux[AXI_MSTR_RADDR_WIDTH-1:4])}),
    .data_out           (curr_resp_id_addr),     
    .valid_out          (),     //open
    .ready_out          (resp_buff_valid_last),
    .data_out_pkd       (os_read_id_addr_pkd_net), 
    .valid_out_pkd      (os_read_valid_pkd_net),
    .nearly_full        ()
  );
  
  always @*
  begin :extract_addr_loop
    integer i;
    logic [AXI_MSTR_RADDR_WIDTH-3:0] tmp_resp;
    logic [AXI_MSTR_RADDR_WIDTH-5:0] tmp_addr;
    logic [1:0] tmp_id;
    
    for(i=0; i<NUM_OS_READS; i=i+1)
    begin
      tmp_resp = os_read_id_addr_pkd_net[(i*(AXI_MSTR_RADDR_WIDTH-2))+:(AXI_MSTR_RADDR_WIDTH-2)];
      {tmp_id, tmp_addr} = tmp_resp;
      os_read_addr_pkd_net[(i*AXI_MSTR_RADDR_WIDTH)+:AXI_MSTR_RADDR_WIDTH] = {tmp_addr,4'b0000};
      os_read_id_pkd_net[(i*2)+:2] = tmp_id;
      os_rd_cpud_dma_net[i] = (tmp_id == 2'd1) | (tmp_id == 2'd2);
    end
  end
  
  
  assign os_read_id_pkd          = {2'b0, os_read_id_pkd_net};
  assign os_read_addr_pkd        = os_read_addr_pkd_net;
  assign os_read_valid_pkd       = os_read_valid_pkd_net;  
  
  assign os_read_cpu_d_valid_pkd = (os_rd_cpud_dma_net & os_read_valid_pkd_net);
  
  // for each CPU work out if any reads are outstanding
  always @*
  begin : id_rd_os_loop
    integer i,j;
    logic tmp_id; 
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_rd_os[i] = 1'b0;
      for(j=0; j< NUM_OS_READS; j=j+1)
      begin
        tmp_id = os_read_id_pkd[j];
        cpu_rd_os[i] = cpu_rd_os[i] | ((tmp_id == i[0]) & os_read_valid_pkd[j]);
      end
      
    end
  end
  
 // assign mstr_r_idle = ~(|os_read_valid_pkd_net); 
  


 
  
endmodule

`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

//
//   File:
//   MIV_RV32IMC_axi_mstr_wchan.sv
//
//   Purpose:
//    OPSrv_Bridge AXI Master write (AW,W) channel
//    Simple master. 
//    Supports single requester with single AXI ID and fixed 4 byte width
//    Supports incrementing burst of 1 or 4 beats only
//   
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_axi_wchan
//********************************************************************************
// Parameter description

  #(
    parameter AXI_MSTR_WADDR_WIDTH = 32,
    parameter NUM_REQUESTERS = 2,
    parameter NUM_OS_WRITES = 4,
    parameter LOG2_NUM_OS_WRITES = 2
   )

//********************************************************************************
// Port description

  (
    
    input wire logic                                            resetn,
    input wire logic                                            clk,
    input wire logic                                            aclk_en,
    // controls   
    input wire logic                                            opsrv_parity_en,
    input wire logic                                            cfg_fence_all,
    output logic                                                mstr_w_idle,
    output logic [NUM_REQUESTERS-1:0]                           write_response_error,
    input wire logic [3:0]                                      cfg_aw_cache,
    //WADDR channel (and sidebands)
    output logic                                                aximstr_awid,
    output logic [AXI_MSTR_WADDR_WIDTH-1:0]                     aximstr_awaddr,
    output logic [3:0]                                          aximstr_awlen,
    output logic [2:0]                                          aximstr_awsize,
    output logic [1:0]                                          aximstr_awburst,
    output logic                                                aximstr_awlock,
    output logic [3:0]                                          aximstr_awcache,
    output logic [2:0]                                          aximstr_awprot,
    output logic                                                aximstr_aw_addr_p,
    input wire logic                                            aximstr_awready,
    output logic                                                aximstr_awvalid,
    //WDATA channel (and sidebands)
    output logic [31:0]                                         aximstr_wdata,
    output logic [3:0]                                          aximstr_wstrb,
    output logic                                                aximstr_wlast,
    output logic                                                aximstr_wid,
    input wire logic                                            aximstr_wready,
    output logic                                                aximstr_wvalid,
    output logic [3:0]                                          aximstr_w_data_p,   
    //BRESP channel
    input wire logic  [1:0]                                     aximstr_bresp,
    input wire logic                                            aximstr_bid,
    output logic                                                aximstr_bready,
    input wire logic                                            aximstr_bvalid,
    
    //cpu dside   
    input wire logic [31:0]                                     cpu_axi_awaddr,
    input wire logic [2:0]                                      cpu_axi_awsize,
    output logic                                                cpu_axi_awready,
    input wire logic                                            cpu_axi_awvalid,
    input wire logic [31:0]                                     cpu_axi_wdata,
    input wire logic [3:0]                                      cpu_axi_wdata_p,
    input wire logic                                            cpu_axi_wlast,
    input wire logic [3:0]                                      cpu_axi_wstrb,
    output logic                                                cpu_axi_wready,
    input wire logic                                            cpu_axi_wvalid,  
    input wire logic                                            cpu_axi_fence_wr_flush,
    output logic                                                cpu_axi_fence_wr_os,
    input wire logic                                            cpu_axi_war_hzd,
    //udma   
    input wire logic [31:0]                                     udma_axi_awaddr,
    input wire logic [3:0]                                      udma_axi_awlen,
    input wire logic [2:0]                                      udma_axi_awsize,
    output logic                                                udma_axi_awready,
    input wire logic                                            udma_axi_awvalid,
    input wire logic [31:0]                                     udma_axi_wdata,
    input wire logic [3:0]                                      udma_axi_wdata_p,
    input wire logic                                            udma_axi_wlast,
    input wire logic [3:0]                                      udma_axi_wstrb,
    output logic                                                udma_axi_wready,
    input wire logic                                            udma_axi_wvalid,   
    input wire logic                                            udma_axi_fence_wr_flush,
    output logic                                                udma_axi_fence_wr_os, 
    input wire logic                                            udma_axi_war_hzd,   

    // outstanding write transaction addresses
    output logic [(NUM_OS_WRITES*AXI_MSTR_WADDR_WIDTH)-1:0]     os_write_addr_pkd,
    output logic [NUM_OS_WRITES-1:0]                            os_write_valid_pkd
  );

//********************************************************************************
// Declarations

// localparams

  localparam AW_BUFF_WIDTH = AXI_MSTR_WADDR_WIDTH + 4 + 3 + 1;
  localparam W_BUFF_WIDTH  = 32 + 4 + 4 + 1;

  localparam RESP_OKAY   = 2'b00;
  localparam RESP_EXOKAY = 2'b01;
  localparam RESP_SLVERR = 2'b10;
  localparam RESP_DECERR = 2'b11;  

  // Internal nets

  logic [NUM_REQUESTERS-1:0]                                 cpu_aww_req;
  logic [NUM_REQUESTERS-1:0]                                 cpu_aww_gnt;
  logic [NUM_REQUESTERS-1:0]                                 cpu_aww_sel;
  logic [NUM_REQUESTERS-1:0]                                 rd_all_hzd;
  logic [NUM_REQUESTERS-1:0]                                 rd_self_hzd;
  logic [NUM_REQUESTERS-1:0]                                 rd_prefetch_hzd;
  logic                                                      waddr_buffer_ready;
  logic                                                      wdata_buffer_ready;
  logic                                                      w_os_buffer_ready;
  logic                                                      accept_aw_req;
  logic                                                      accept_w_data;

  logic [AXI_MSTR_WADDR_WIDTH-1:0]                           cpu_awaddr[NUM_REQUESTERS-1:0];
  logic [NUM_REQUESTERS-1:0]                                 cpu_awid;   
  logic [3:0]                                                cpu_awlen[NUM_REQUESTERS-1:0]; 
  logic [2:0]                                                cpu_awsize[NUM_REQUESTERS-1:0];
  logic [NUM_REQUESTERS-1:0]                                 cpu_addr_p;        
  logic [NUM_REQUESTERS-1:0]                                 cpu_awvalid;      
  logic [31:0]                                               cpu_wdata[NUM_REQUESTERS-1:0];    
  logic [3:0]                                                cpu_wdata_p[NUM_REQUESTERS-1:0];  
  logic [3:0]                                                cpu_wstrb[NUM_REQUESTERS-1:0];  
  logic [NUM_REQUESTERS-1:0]                                 cpu_wvalid; 
  logic [NUM_REQUESTERS-1:0]                                 cpu_wlast;          
  logic [(AXI_MSTR_WADDR_WIDTH-1):4]                         cpu_rd_hzd_addr [NUM_REQUESTERS-1:0];     
  logic [NUM_REQUESTERS-1:0]                                 cpu_rd_hzd_addr_valid;
  logic [NUM_REQUESTERS-1:0]                                 war_hzd;
  
  logic [AXI_MSTR_WADDR_WIDTH-1:0]                           cpu_awaddr_mux;
  logic                                                      cpu_awid_mux;
  logic [3:0]                                                cpu_awlen_mux; 
  logic [2:0]                                                cpu_awsize_mux; 
  logic                                                      cpu_addr_p_mux;
  logic [31:0]                                               cpu_wdata_mux;
  logic [3:0]                                                cpu_wdata_p_mux;
  logic                                                      cpu_wlast_mux;
  logic [3:0]                                                cpu_wstrb_mux;
  logic                                                      axi_wid_mux;
  logic                                                      cpu_wvalid_mux;
  logic                                                      cpu_num_mux;
  
  logic [AXI_MSTR_WADDR_WIDTH-1:0]                           cpu_awaddr_buff;
  logic [3:0]                                                cpu_awlen_buff; 
  logic [2:0]                                                cpu_awsize_buff; 
  logic [3:0]                                                cpu_awcache_buff;  
  logic                                                      cpu_addr_p_buff;
  logic [31:0]                                               cpu_wdata_buff;
  logic [3:0]                                                cpu_wdata_p_buff;
  logic                                                      cpu_wlast_buff;
  logic [3:0]                                                cpu_wstrb_buff;
  logic                                                      axi_awid_buff;
  logic                                                      axi_wid_buff;
  
  logic [AW_BUFF_WIDTH-1:0]                                  aw_buff_in;
  logic [AW_BUFF_WIDTH-1:0]                                  aw_buff_out;
  logic [W_BUFF_WIDTH-1:0]                                   w_buff_in;
  logic [W_BUFF_WIDTH-1:0]                                   w_buff_out; 

  logic [1:0]                                                bresp_buff;
  logic                                                      cpu_bid_buff;
  logic                                                      bvalid_buff; 
  logic                                                      bready_buff;    
  logic [NUM_REQUESTERS-1:0]                                 cpu_bresp_id_valid;
  logic                                                      b_valid_aclken;
  
  logic                                                      wlast_valid;
  
  logic [NUM_REQUESTERS-1:0]                                 fence_flush;
  logic [NUM_REQUESTERS-1:0]                                 cpu_wr_os;
  logic [(NUM_OS_WRITES*(AXI_MSTR_WADDR_WIDTH-3))-1:0]       os_write_id_addr_pkd_net;
  logic [NUM_OS_WRITES-1:0]                                  os_write_id_pkd_net;
  logic [NUM_OS_WRITES:0]                                    os_write_id_pkd;
  logic [(NUM_OS_WRITES*AXI_MSTR_WADDR_WIDTH)-1:0]           os_write_addr_pkd_net;
  logic [NUM_OS_WRITES-1:0]                                  os_write_valid_pkd_net; 
  logic [AXI_MSTR_WADDR_WIDTH-4:0]                           curr_resp_id_addr;

//********************************************************************************
// Main code

  // write side 
  
    // a write request from a CPU can be considered for acceptance (arbitration)if:
    //   - there is no fence flush in progress
    //   - there is space in the write outstanding (os) buffer
    //   - there is space in the write request buffer
    //   - read hazarding is disabled or the write address does not hazard with os reads
  
// cpu
    assign cpu_awaddr[0]               = cpu_axi_awaddr;
    assign cpu_awid[0]                 = 1'b0;
    assign cpu_awlen[0]                = 4'd0; // CPU currently only generates single beat transactions
    assign cpu_awsize[0]               = cpu_axi_awsize;
    assign cpu_awvalid[0]              = cpu_axi_awvalid;
    assign cpu_wdata[0]                = cpu_axi_wdata;
    assign cpu_wdata_p[0]              = cpu_axi_wdata_p;
    assign cpu_wstrb[0]                = cpu_axi_wstrb;
    assign cpu_wlast[0]                = cpu_axi_wlast;
    assign cpu_wvalid[0]               = cpu_axi_wvalid;
    assign cpu_axi_awready             = cpu_aww_gnt[0];
    assign cpu_axi_wready              = cpu_aww_sel[0] & wdata_buffer_ready;
    assign cpu_axi_fence_wr_os          = (cfg_fence_all  & (|cpu_wr_os)) |
                                         (~cfg_fence_all  & cpu_wr_os[0]);
    assign war_hzd[0]                  = cpu_axi_war_hzd; 

  
  generate
  if((NUM_REQUESTERS >= 2)) begin: gen_assign_udma_cons
    assign cpu_awaddr[1]               = udma_axi_awaddr;
    assign cpu_awid[1]                 = 1'b1;
    assign cpu_awlen[1]                = udma_axi_awlen;
    assign cpu_awsize[1]               = udma_axi_awsize;
    assign cpu_awvalid[1]              = udma_axi_awvalid;
    assign cpu_wdata[1]                = udma_axi_wdata;
    assign cpu_wdata_p[1]              = udma_axi_wdata_p;
    assign cpu_wstrb[1]                = udma_axi_wstrb;
    assign cpu_wlast[1]                = udma_axi_wlast;
    assign cpu_wvalid[1]               = udma_axi_wvalid; 
    assign udma_axi_awready            = cpu_aww_gnt[1];
    assign udma_axi_wready             = cpu_aww_sel[1] & wdata_buffer_ready;
    assign udma_axi_fence_wr_os        = (cfg_fence_all  & (|cpu_wr_os)) |
                                         (~cfg_fence_all & cpu_wr_os[1]);
    assign war_hzd[1]                  = udma_axi_war_hzd;                                    
  end
  else begin: gen_assign_udma_cons
    assign udma_axi_awready            = 1'b0;
    assign udma_axi_wready             = 1'b0;
    assign udma_axi_fence_wr_os        = 1'b0;
  end
  endgenerate

  
  generate
  genvar i_req;
  for (i_req = 0; i_req < NUM_REQUESTERS; i_req = i_req+1) begin : gen_cpu_req
    
    assign cpu_aww_req[i_req] = cpu_awvalid[i_req] & 
                                //cpu_wvalid[i_req] &
                                // (~fence_flush[i_req]) & REVISIT add fence logic back
                                w_os_buffer_ready &
                                waddr_buffer_ready &
                                ~war_hzd[i_req];
                                                       
    // compute address parity in parallel for each source and multiplex so it can be computed 
    // whilst arbitrating    
    assign cpu_addr_p[i_req] = ^cpu_awaddr[i_req];                                               
                                                       
  end
  endgenerate

                                    
  // arbitrate write requests
  // once arbitrated, lock the selection and do not re-arbitrate until last data beat is transferred 
    
  MIV_RV32IMC_rr_pri_arb
  //***************************************************************
  // Parameter description
  #(
    .NUM_REQS            (NUM_REQUESTERS),
    .USE_FORMAL          (1),
    .USE_SIM             (1)
   )

  u_waddr_arb
  //***************************************************************
  // Signal description
  (
    .resetn              (resetn),
    .unlock              (wlast_valid),  
    .clk                 (clk),
    .req                 (cpu_aww_req),
    .gnt                 (cpu_aww_gnt),
    .sel_seq             (), // open
    .sel_early           (cpu_aww_sel)
  );
  
  assign wlast_valid = cpu_wlast_mux & cpu_wvalid_mux & wdata_buffer_ready;
  
  // request/data multiplexer
  
  always @*
  begin : waddr_wdata_mux_loop
    integer i;
    cpu_awaddr_mux    = {32{1'b0}};
    cpu_awid_mux      = 1'b0; 
    cpu_awlen_mux     = {4{1'b0}}; 
    cpu_awsize_mux    = {3{1'b0}};
    cpu_addr_p_mux    = 1'b0;  
    cpu_wdata_mux     = {32{1'b0}};       
    cpu_wdata_p_mux   = {4{1'b0}};     
    cpu_wstrb_mux     = {4{1'b0}};
    cpu_wlast_mux     = 1'b0;
    cpu_wvalid_mux    = 1'b0;
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_awaddr_mux    = cpu_awaddr_mux  | ({AXI_MSTR_WADDR_WIDTH{cpu_aww_gnt[i]}} & cpu_awaddr[i]); 
      cpu_awid_mux      = cpu_awid_mux    | (cpu_aww_gnt[i] & cpu_awid[i]);
      cpu_awlen_mux     = cpu_awlen_mux   | ({4{cpu_aww_gnt[i]}} & cpu_awlen[i]);
      cpu_awsize_mux    = cpu_awsize_mux  | ({3{cpu_aww_gnt[i]}} & cpu_awsize[i]);
      cpu_addr_p_mux    = cpu_addr_p_mux  | (cpu_aww_gnt[i] & cpu_addr_p[i]);        
      cpu_wdata_mux     = cpu_wdata_mux   | ({32{cpu_aww_sel[i]}} & cpu_wdata[i]);  
      cpu_wdata_p_mux   = cpu_wdata_p_mux | ({4{cpu_aww_sel[i]}}  & cpu_wdata_p[i]);  
      cpu_wstrb_mux     = cpu_wstrb_mux   | ({4{cpu_aww_sel[i]}}  & cpu_wstrb[i]);
      cpu_wlast_mux     = cpu_wlast_mux   | (cpu_aww_sel[i]  & cpu_wlast[i]);
      cpu_wvalid_mux    = cpu_wvalid_mux  | (cpu_aww_sel[i]  & cpu_wvalid[i]);
    end
  end

  
  // request/data output buffers
  
  assign accept_aw_req  = |cpu_aww_gnt;
                             
  
  // translate/map CPU transaction AWID to AXI AWID
  // OPSRV AXI master supports only a single ID, so ditrect translation to CPU num to know where to send responses
  
  
  assign cpu_num_mux = cpu_awid_mux; 
  

  
  assign aw_buff_in = {cpu_awaddr_mux,
                       cpu_awlen_mux,
                       cpu_awsize_mux,
                       cpu_addr_p_mux};
                       
  assign {cpu_awaddr_buff,
          cpu_awlen_buff,
          cpu_awsize_buff,
          cpu_addr_p_buff} = aw_buff_out;
          
  
  
  
  MIV_RV32IMC_axi_egress_slip_buffer
  #(
    .BUFF_WIDTH         (AW_BUFF_WIDTH)
  )
  u_waddr_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .clken              (aclk_en),
    .valid_in           (accept_aw_req),
    .ready_in           (waddr_buffer_ready),
    .data_in            (aw_buff_in),
    .data_out           (aw_buff_out),
    .valid_out          (aximstr_awvalid),
    .ready_out          (aximstr_awready),  
    .nearly_full        ()  //open      
  );
  
  
  
  assign w_buff_in = {cpu_wdata_mux,
                      cpu_wdata_p_mux,
                      cpu_wstrb_mux,
                      cpu_wlast_mux};
  assign {cpu_wdata_buff,
          cpu_wdata_p_buff,
          cpu_wstrb_buff,
          cpu_wlast_buff} = w_buff_out;
          
  
  assign accept_w_data = |(cpu_aww_sel & cpu_wvalid);
  
  MIV_RV32IMC_axi_egress_slip_buffer
  #(
    .BUFF_WIDTH         (W_BUFF_WIDTH)
  )
  u_wdata_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .clken              (aclk_en),
    .valid_in           (accept_w_data),
    .ready_in           (wdata_buffer_ready),
    .data_in            (w_buff_in),
    .data_out           (w_buff_out),
    .valid_out          (aximstr_wvalid),
    .ready_out          (aximstr_wready), 
    .nearly_full        ()  //open   
  );
  
  // outstanding request buffer. 
  // This stores a list of the write address (16 byte granularity)  
  // such that the master can keep track of them and manage RAW hazards.
  // OPSRV supports a single AXI ID therefore request always stay in order, so just need a simple buffer 
  // to maintain a list.
  
  
  MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         (AXI_MSTR_WADDR_WIDTH-3), 
    .BUFF_SIZE          (NUM_OS_WRITES),
    .PTR_SIZE           (LOG2_NUM_OS_WRITES)
  )
  u_wos_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (accept_aw_req),    
    .ready_in           (w_os_buffer_ready),
    .data_in            ({cpu_num_mux,cpu_awaddr_mux[AXI_MSTR_WADDR_WIDTH-1:4]}),
    .data_out           (curr_resp_id_addr),     //open
    .valid_out          (),     //open
    .ready_out          (bvalid_buff),
    .data_out_pkd       (os_write_id_addr_pkd_net),                         
    .valid_out_pkd      (os_write_valid_pkd_net),
    .nearly_full        () //open
  );
  
  always @*
  begin :extract_addr_loop
    integer i;
    for(i=0; i<NUM_OS_WRITES; i=i+1)
    begin
      os_write_addr_pkd_net[(i*AXI_MSTR_WADDR_WIDTH)+:AXI_MSTR_WADDR_WIDTH]  =
           {(os_write_id_addr_pkd_net[(i*(AXI_MSTR_WADDR_WIDTH-3))+:(AXI_MSTR_WADDR_WIDTH-4)]),4'b0000};
      os_write_id_pkd_net[i]   = os_write_id_addr_pkd_net[(i*(AXI_MSTR_WADDR_WIDTH-3))+(AXI_MSTR_WADDR_WIDTH-4)];
    end
  end
    
  
//  // append any write request arbitrated this cycle to the list of outstanding requests since it will not 
//  // yet be in the buffer list, but will still need to prevent writes following
//  assign os_write_id_pkd    = {cpu_awid_mux,os_write_id_pkd_net};
//  assign os_write_addr_pkd  = {{(cpu_awaddr_mux[AXI_MSTR_WADDR_WIDTH-1:4]),4'b0000},os_write_addr_pkd_net};
//  assign os_write_valid_pkd = {accept_aw_req,os_write_valid_pkd_net};
  
  assign os_write_id_pkd    = {1'b0, os_write_id_pkd_net};
  assign os_write_addr_pkd  = os_write_addr_pkd_net;
  assign os_write_valid_pkd = os_write_valid_pkd_net;  
  
  // for each requester (cpu, udma) work out if any writes are outstanding
  
  always @*
  begin : id_wr_os_loop
    integer i,j;
    logic tmp_id; 
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_wr_os[i] = 1'b0;
      for(j=0; j<NUM_OS_WRITES; j=j+1)
      begin
        tmp_id = os_write_id_pkd[j];
        cpu_wr_os[i] = cpu_wr_os[i] | ((tmp_id == i[0]) & os_write_valid_pkd[j]);
      end      
    end
  end
  
  
  // Write response (BRESP) buffer
  // Buffer is here just for timing purposes since the response is not used except for indicating
  // that an outstanding write can be removed from the buffer and to generate an exception
  // in the case of a write error
  
  assign b_valid_aclken = aximstr_bvalid & aclk_en;
  
  always @(posedge clk)
  begin
    bresp_buff   <=  aximstr_bresp;         
  end
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      bvalid_buff <=  1'b0;
    else
      bvalid_buff <=  b_valid_aclken; 
  end
  

  

  
  always @*
  begin : respid_map_loop
    integer i;
    for(i=0; i<NUM_REQUESTERS; i=i+1)
    begin
      cpu_bresp_id_valid[i] = (curr_resp_id_addr[(AXI_MSTR_WADDR_WIDTH-4)] == i[0]) & bvalid_buff;
    end
  end  
  
  // if the write response is SLVERR/DECERR then generate an exception
  // EXOKAY will be treated as OKAY since there are no exclusive transactions generated
  assign write_response_error = {NUM_REQUESTERS{((bresp_buff == 2'b10) | (bresp_buff == 2'b11))}} & cpu_bresp_id_valid;
  

  // assign AXI outputs
  
  assign aximstr_awid           = 1'b0;  
  assign aximstr_awaddr         = cpu_awaddr_buff;
  assign aximstr_awlen          = cpu_awlen_buff;  
  assign aximstr_awsize         = cpu_awsize_buff; 
  assign aximstr_awburst        = 2'b01;    // OPSRV only supports incrementing bursts 
  assign aximstr_awlock         = 1'b0;    // Always normal (no lock, no exclusive) for now
  assign aximstr_awcache        = cfg_aw_cache;
  assign aximstr_awprot         = 3'b010;   // Always data, non-secure, normal
  assign aximstr_aw_addr_p      = cpu_addr_p_buff;     
  
  assign aximstr_wdata          = cpu_wdata_buff;
  assign aximstr_wstrb          = cpu_wstrb_buff;
  assign aximstr_wlast          = cpu_wlast_buff;
  assign aximstr_wid            = 1'b0;
  assign aximstr_w_data_p       = cpu_wdata_p_buff;
  
  assign aximstr_bready = 1'b1; // always accept write responses
  
  assign mstr_w_idle            = ~(|os_write_valid_pkd);
  

                           
    
endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_axi_xaddr_buffer.sv
//
//   Purpose: Specialised version of the buffer for handling AXI a*addr channel
//            Supports 32 bit incr and wrapped bursts with burst address generation
//
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_axi_xaddr_buffer
//********************************************************************************
// Parameter description

  #(
    parameter ATTB_WIDTH = 5,
    parameter BUFF_SIZE = 2,
    parameter PTR_SIZE = 1,
    parameter NUM_DBYTES = 8
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    input wire                               clken,
    
    input wire                               addr_parity_en,
    
    input wire                               valid_in,
    output wire                              ready_in,
    input wire                               beat_accepted,
    input wire [31:0]                        addr_in,
    input wire                               addr_in_p,
    input wire [3:0]                         len_in,
    input wire [ATTB_WIDTH-1:0]              attb_in,
    input wire                               wrap_in,
    
    output wire [31:0]                       addr_out,
    output wire [3:0]                        len_out,
    output wire [ATTB_WIDTH-1:0]             attb_out,
    output wire                              valid_out,
    output wire                              addr_parity_err,
    output wire [(ATTB_WIDTH*BUFF_SIZE)-1:0] attb_out_pkd,
    output wire [BUFF_SIZE-1:0]              valid_out_pkd,
    input wire                               ready_out,
    output wire                              last_out  
    
 
    
  );

//********************************************************************************
// localparams
  localparam BUFF_MAX   = BUFF_SIZE-1;

// Declarations

  reg  [PTR_SIZE-1:0]   buff_wr_ptr;
  reg  [PTR_SIZE-1:0]   buff_rd_ptr;
  wire [PTR_SIZE-1:0]   next_buff_wr_ptr;
  wire [PTR_SIZE-1:0]   next_buff_rd_ptr;
  
  wire [BUFF_SIZE-1:0]  buff_wr_strb;
  wire [BUFF_SIZE-1:0]  buff_rd_strb;
  
  wire [BUFF_SIZE-1:0]   buff_valid;
  wire [BUFF_SIZE-1:0]   next_buff_valid;
  wire [31:0]            buff_addr[BUFF_SIZE-1:0]; 
  wire [3:0]             buff_len[BUFF_SIZE-1:0];  
  wire [ATTB_WIDTH-1:0]  buff_attb[BUFF_SIZE-1:0]; 
  wire [BUFF_SIZE-1:0]   buff_last_beat; 
  wire [BUFF_SIZE-1:0]   buff_wrap;
  wire [BUFF_SIZE-1:0]   buff_excl;  
  wire [BUFF_SIZE-1:0]   curr_beat_accepted;
  wire [BUFF_SIZE-1:0]   buff_addr_parity_err;
  
  wire                   next_buff_ready;
  reg                    buff_ready_reg;  

  wire                   rd_data;
  wire                   wr_data;
  
  wire                   full;
  wire                   empty;


  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************

  assign full     = &buff_valid;
  assign empty    = ~(|buff_valid);
  assign wr_data  = valid_in & buff_ready_reg & clken;
  assign rd_data  = ready_out & ~empty;
  
  assign next_buff_ready = ~(&next_buff_valid);

  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_ready_reg <= 1'b0;
    else
      if(clken)
        buff_ready_reg <= next_buff_ready;       
  end
  
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_rd_ptr <= {PTR_SIZE{1'b0}};
    else
      if(rd_data)
        buff_rd_ptr <= next_buff_rd_ptr;        
  end 
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_wr_ptr <= {PTR_SIZE{1'b0}};
    else
      if(wr_data)
        buff_wr_ptr <= next_buff_wr_ptr;
  end
  
  assign next_buff_wr_ptr = (buff_wr_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_wr_ptr+1;
  assign next_buff_rd_ptr = (buff_rd_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_rd_ptr+1;
 
  
  generate
  genvar gen_buff;
  for(gen_buff = 0; gen_buff<BUFF_SIZE; gen_buff=gen_buff+1)
  begin : gen_buff_loop
    
    assign curr_beat_accepted[gen_buff] = beat_accepted & 
                                          (buff_rd_ptr == gen_buff[PTR_SIZE-1:0]);
    
    assign buff_wr_strb[gen_buff] = wr_data & (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign buff_rd_strb[gen_buff] = rd_data & (buff_rd_ptr == gen_buff[PTR_SIZE-1:0]);
  
    MIV_RV32IMC_axi_xaddr_buffer_slot
    #(
      .ATTB_WIDTH         (ATTB_WIDTH),
      .NUM_DBYTES         (NUM_DBYTES)
    )
    u_MIV_RV32IMC_axi_xaddr_buffer_slot
    (
      .clk                (clk),
      .resetn             (resetn),
      .addr_parity_en     (addr_parity_en),
      .alloc_buffer       (buff_wr_strb[gen_buff]),
      .dealloc_buffer     (buff_rd_strb[gen_buff]),
      .update_address     (curr_beat_accepted[gen_buff]),
      .addr_in            (addr_in),
      .addr_in_p          (addr_in_p),
      .len_in             (len_in),
      .attb_in            (attb_in),
      .wrap_in            (wrap_in),
      .addr_out           (buff_addr[gen_buff]),
      .len_out            (buff_len[gen_buff]),
      .attb_out           (buff_attb[gen_buff]),
      .addr_parity_err    (buff_addr_parity_err[gen_buff]),
      .valid_out          (buff_valid[gen_buff]),
      .last_beat          (buff_last_beat[gen_buff]),
      .next_valid_out     (next_buff_valid[gen_buff])
    );

    assign attb_out_pkd[(ATTB_WIDTH*gen_buff)+:ATTB_WIDTH] = buff_attb[gen_buff];
    assign valid_out_pkd[gen_buff]                         = buff_valid[gen_buff];
    
  end
  endgenerate
  
  // output mux/assign
  assign addr_out        = buff_addr[buff_rd_ptr];
  assign len_out         = buff_len[buff_rd_ptr];
  assign attb_out        = buff_attb[buff_rd_ptr];     
  assign valid_out       = buff_valid[buff_rd_ptr];
  assign last_out        = buff_last_beat[buff_rd_ptr];
  
  assign ready_in        = buff_ready_reg;
  
  assign addr_parity_err = |buff_addr_parity_err; 
  


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_axi_xaddr_buffer_slot.sv
//
//   Purpose: slot buffer for a*addr requests
//
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_axi_xaddr_buffer_slot
//********************************************************************************
// Parameter description

  #(
    parameter ATTB_WIDTH = 4,
    parameter NUM_DBYTES = 8
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                    resetn,
    input wire                    clk,
    
    input wire                    addr_parity_en,
    
    input wire                    alloc_buffer,
    input wire                    dealloc_buffer,
    input wire                    update_address,
    input wire [31:0]             addr_in,
    input wire                    addr_in_p,
    input wire [3:0]              len_in,
    input wire [ATTB_WIDTH-1:0]   attb_in,
    input wire                    wrap_in,
    
    output wire [31:0]            addr_out,
    output wire [3:0]             len_out,
    output wire [ATTB_WIDTH-1:0]  attb_out,
    output wire                   addr_parity_err,
    output wire                   valid_out,
    output wire                   last_beat,
    output wire                   next_valid_out   
    
 
    
  );

//********************************************************************************
// localparams


// Declarations

 
  reg                   buff_valid;
  reg [31:0]            buff_addr; 
  reg [3:0]             buff_len;  
  reg [ATTB_WIDTH-1:0]  buff_attb;  
  reg                   buff_wrap; 
  reg [3:0]             beats_remaining;
  

  wire                  next_buff_valid;  
  wire [31:0]           next_buff_addr;
  wire [3:0]            next_buff_len;
  wire [ATTB_WIDTH-1:0] next_buff_attb;
  wire                  next_buff_wrap;
  
  wire [3:0]            next_buff_addr_wrap_bits;
  wire [9:0]            next_buff_addr_incr_bits; 
  wire [31:0]           next_buff_addr_sel; 
  wire [3:0]            next_beats_remaining;
  reg                   alloc_buffer_d1;
  reg                   orig_addr_parity;
  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************


    
  // Everything but address stays stable throughout the life of the transaction in the buffer
  // Address is re-computed each time a beat is accepted (indicated by beat_accepted)
  // First address is always the one in the request so only need updated address
  // for subsequent beats
  
  generate if(NUM_DBYTES == 8) begin : gen_64_bit_datapath
  
    // wrapping burst can only have max length 16 and since the size is always 8 bytes for a multibeat burst, 
    // can only be within a 64 byte region so only need to worry about bits [6:3] changing
    assign next_buff_addr_wrap_bits = ( buff_addr[6:3] & ~ buff_len) | 
                                      ((buff_addr[6:3]+4'd1) & buff_len);

    // incrementing bursts may not cross 4K boundary so only need to compute bottom 12 bits, since all 64 bit OPSx transactions
    // are 64-bit aligned then only need 10 bits.
    // single beat transactions can still be 32 bit aligned, so keep buff_addr[2]  
    assign next_buff_addr_incr_bits = buff_addr[11:2]+10'd2; 
  
    assign next_buff_addr_sel       = ~update_address ? buff_addr :
                                                        buff_wrap ? {buff_addr[31:7], next_buff_addr_wrap_bits,buff_addr[2], buff_addr[1:0]} :
                                                                    {buff_addr[31:12], next_buff_addr_incr_bits, buff_addr[1:0]};
  
  end else begin : gen_32_bit_datpath
  
    // wrapping burst can only have max length 16 and since the size is always 4 bytes, can only be within a 64 byte  
    // region so only need to worry about bits [5:2] changing
    assign next_buff_addr_wrap_bits = ( buff_addr[5:2] & ~ buff_len) | 
                                      ((buff_addr[5:2]+4'd1) & buff_len);

    // incrementing bursts may not cross 4K boundary so only need to compute bottom 12 bits, since all 32 bit OPSx transactions
    // are 32-bit aligned then only need 10 bits.
    assign next_buff_addr_incr_bits = buff_addr[11:2]+10'd1; 
  
    assign next_buff_addr_sel       = ~update_address ? buff_addr :
                                                        buff_wrap ? {buff_addr[31:6], next_buff_addr_wrap_bits, buff_addr[1:0]} :
                                                                    {buff_addr[31:12], next_buff_addr_incr_bits, buff_addr[1:0]};
  
  end
  endgenerate
  
  assign next_beats_remaining     = alloc_buffer ? len_in : (update_address ? (beats_remaining - 4'd1) :
                                                                              beats_remaining);
   
  assign next_buff_addr  =  alloc_buffer ? addr_in : next_buff_addr_sel;
  assign next_buff_len   =  alloc_buffer ? len_in  : buff_len; 
  assign next_buff_attb  =  alloc_buffer ? attb_in : buff_attb;  
  assign next_buff_wrap  =  alloc_buffer ? wrap_in : buff_wrap;
  
  // request attributes not reset
  always @(posedge clk)
  begin    
    begin
      buff_addr        <= next_buff_addr;
      buff_len         <= next_buff_len;
      buff_attb        <= next_buff_attb;
      buff_wrap        <= next_buff_wrap;
      beats_remaining  <= next_beats_remaining;
    end
  end
  

         
  assign next_buff_valid = (buff_valid & ~dealloc_buffer) | 
                            alloc_buffer;
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_valid  <=  1'b0;
    else
      buff_valid  <= next_buff_valid; 
  end  

  
  assign addr_out         = buff_addr;
  assign len_out          = buff_len;
  assign attb_out         = buff_attb;     
  assign valid_out        = buff_valid;
  assign next_valid_out   = next_buff_valid;
  assign last_beat        = (beats_remaining == 4'd0);
  
  // check the address parity when a request is allocated.
  // Becasue the address signals from AXI might be late, use the buffered version
  

  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      alloc_buffer_d1  <=  1'b0;
    else
      alloc_buffer_d1  <= alloc_buffer; 
  end
  
  always @(posedge clk)
  begin
    orig_addr_parity <= addr_in_p; 
  end
  
  assign addr_parity_err = (^{orig_addr_parity,buff_addr}) & alloc_buffer_d1 & addr_parity_en;
  
  
  


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_buffer.sv
//
//   Purpose:

//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_buffer
//********************************************************************************
// Parameter description

  #(
    parameter BUFF_WIDTH = 36,
    parameter BUFF_SIZE = 2,
    parameter PTR_SIZE = 1
 
   )

//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    
    input wire                               valid_in,
    output wire                              ready_in,
    input wire [BUFF_WIDTH-1:0]              data_in,
    
    output wire [BUFF_WIDTH-1:0]             data_out,
    output wire                              valid_out,
    
    input wire                               ready_out,  
    
    output wire [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd,
    output wire [BUFF_SIZE-1:0]              valid_out_pkd,
    
    output wire                              nearly_full  
    
 
    
  );

//********************************************************************************
// localparams
  localparam BUFF_MAX = BUFF_SIZE-1;

// Declarations

  reg  [PTR_SIZE-1:0]              buff_wr_ptr;
  reg  [PTR_SIZE-1:0]              buff_rd_ptr;
  wire [PTR_SIZE-1:0]              next_buff_wr_ptr;
  wire [PTR_SIZE-1:0]              next_buff_rd_ptr;
  
  wire [BUFF_SIZE-1:0]             buff_wr_strb;
  wire [BUFF_SIZE-1:0]             buff_rd_strb;
  wire [BUFF_SIZE-1:0]             next_alloc;
  
  reg [BUFF_SIZE-1:0]              buff_valid;
  wire [BUFF_SIZE-1:0]             next_buff_valid;
  reg [BUFF_WIDTH-1:0]             buff_data[BUFF_SIZE-1:0]; 
  
  wire                             rd_data;
  wire                             wr_data;
  
  wire                             full;
  wire                             empty;
  
  reg [(BUFF_SIZE*BUFF_WIDTH)-1:0] data_out_pkd_reg;
  reg [BUFF_SIZE-1:0]              valid_out_pkd_reg;
  
  wire                             next_buff_ready;
  reg                              buff_ready_reg;

  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************

  assign full     = &buff_valid;
  assign empty    = ~(|buff_valid);
  assign wr_data  = valid_in & buff_ready_reg;
  assign rd_data  = ready_out & ~empty;
  
  
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_rd_ptr <= {PTR_SIZE{1'b0}};
    else
      if(rd_data)
        buff_rd_ptr <= next_buff_rd_ptr;        
  end 
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_wr_ptr <= {PTR_SIZE{1'b0}};
    else
      if(wr_data)
        buff_wr_ptr <= next_buff_wr_ptr;
  end
  
  assign next_buff_wr_ptr = (buff_wr_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_wr_ptr+1;
  assign next_buff_rd_ptr = (buff_rd_ptr == BUFF_MAX) ? {PTR_SIZE{1'b0}} : buff_rd_ptr+1;
  
  
  
  generate
  genvar gen_buff;
  for(gen_buff = 0; gen_buff<BUFF_SIZE; gen_buff=gen_buff+1)
  begin : gen_buff_loop
  
    assign buff_wr_strb[gen_buff] = wr_data & (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign next_alloc[gen_buff] = (buff_wr_ptr == gen_buff[PTR_SIZE-1:0]);
    assign buff_rd_strb[gen_buff] = rd_data & (buff_rd_ptr == gen_buff[PTR_SIZE-1:0]);
  
    // Data not reset
    always @(posedge clk)
    begin    
      begin
        if(buff_wr_strb[gen_buff])
        begin
          buff_data[gen_buff] <= data_in;
        end
      end
    end
  
  
    assign next_buff_valid[gen_buff] = (buff_valid[gen_buff] & ~buff_rd_strb[gen_buff]) | 
                                       buff_wr_strb[gen_buff];
  
    always @(posedge clk or negedge resetn)
    begin
      if(~resetn)
        buff_valid[gen_buff]  <=  1'b0;
      else
        buff_valid[gen_buff]  <= next_buff_valid[gen_buff]; 
    end  
    
  end
  endgenerate
  
  assign data_out = buff_data[buff_rd_ptr];
  assign valid_out = buff_valid[buff_rd_ptr];
  
  assign next_buff_ready = ~(&next_buff_valid);
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      buff_ready_reg <= 1'b0;
    else
      buff_ready_reg <= next_buff_ready;       
  end
  
  assign ready_in = buff_ready_reg;

  
  //assign packed outputs
  always @*
  begin: pkd_out_loop
    integer i;
    for(i=0;i<BUFF_SIZE; i=i+1)
    begin
      data_out_pkd_reg[(i*BUFF_WIDTH)+:BUFF_WIDTH] = buff_data[i];
      valid_out_pkd_reg[i] = buff_valid[i];
    end
  end
  
  assign data_out_pkd  = data_out_pkd_reg;
  assign valid_out_pkd = valid_out_pkd_reg; 
  
  // if the next buffer slot to be allocated would cause the buffer to become full if a write occurs
  // without a read, assert the nearly_full output
  assign nearly_full = &(buff_valid | next_alloc);
  


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_fixed_arb.sv
//
//   Purpose: Parameterized fixed priority arbiter
//
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_fixed_arb
//********************************************************************************
// Parameter description

  #(
     parameter NUM_REQS = 3
   )

//********************************************************************************
// Port description

  (
    input wire [NUM_REQS-1:0]       req, 
    output wire [NUM_REQS-1:0]      gnt,
    output wire [(2*NUM_REQS)-1:0]  gnt_dbl 

  );

//********************************************************************************
// localparams
// Declarations


  reg  [NUM_REQS:0]     higher_pri_reqs;
  wire [NUM_REQS:0]     req_ext;
  wire [NUM_REQS-1:0]   tmp_gnt;
      
  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************
  
  // add a '0' so it works even when NUM_REQS == 1
  
  assign req_ext = {1'b0,req};
  
  always @*
  begin : higher_pri_loop
    integer i;
    higher_pri_reqs[0] = 1'b0;
    for(i=0; i < NUM_REQS; i=i+1)
    begin
      higher_pri_reqs[i+1] = req_ext[i] | higher_pri_reqs[i];
    end
  end
  
  assign tmp_gnt = req & ~higher_pri_reqs[NUM_REQS-1:0];
  assign gnt = tmp_gnt;
  assign gnt_dbl = {tmp_gnt,tmp_gnt};
     




endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

import MIV_RV32IMC_opsrv_cfg_pkg::*;

module MIV_RV32IMC_mtime_irq 
//********************************************************************************
// Parameter description
  #(
   parameter INTERNAL_MTIME               = 0,
   parameter INTERNAL_MTIME_IRQ           = 0,
   parameter MTIME_PRESCALER     = 16'h63
   )

//********************************************************************************
// Port description

     ( 

      input wire logic        pclk,       // APB clock
      input wire logic        presetn,    // APB reset 
      input wire logic        penable,    // APB enable
      input wire logic        psel,       // APB select
      input wire logic [31:0] paddr,      // APB address bus
      input wire logic        pwrite,     // APB write
      input wire logic [31:0] pwdata,     // APB write data
      output     logic [31:0] prdata,     // APB read data
      output     logic        pready,     // APB ready	
	  output     logic        pslverr,    // APB slv error	
	  
      output     logic        m_timer_irq,   
	  input      logic [63:0] mtime_count_in,
	  output     logic [63:0] mtime_count_out
    );                      
	
	  
    //-----------------------------------------------------------------------------
    // Parameters
    //-----------------------------------------------------------------------------
      localparam        SYNC_RESET = 1;

      localparam logic [31:0] l_mtime_addr_u    = l_mtime_addr_base + 4; 
      localparam logic [31:0] l_mtimecmp_addr_u = l_mtimecmp_addr_base + 4; 
    //-----------------------------------------------------------------------------
    // Signal Declarations
    //-----------------------------------------------------------------------------

      logic aresetn;
      logic sresetn;
      logic rtc_tick;

      logic T_l_En;   
      logic T_h_En;  
      logic Tc0_l_En;
      logic Tc0_h_En;

      logic [63:0] mtimecmp;
      logic [31:0] rtc_count;	
	  logic [63:0] mtime_count_sel; 

    //-----------------------------------------------------------------------------
    // Assignments
    //-----------------------------------------------------------------------------
      // APB
	  assign pslverr = 1'b0;
      assign pready  = (psel && penable);
	  
	  // Enables
      assign T_l_En   = ((INTERNAL_MTIME)     & (paddr == l_mtime_addr_base   )) ? (pwrite && psel && penable) : 1'b0;
      assign T_h_En   = ((INTERNAL_MTIME)     & (paddr == l_mtime_addr_u      )) ? (pwrite && psel && penable) : 1'b0;
      assign Tc0_l_En = ((INTERNAL_MTIME_IRQ) & (paddr == l_mtimecmp_addr_base)) ? (pwrite && psel && penable) : 1'b0;
      assign Tc0_h_En = ((INTERNAL_MTIME_IRQ) & (paddr == l_mtimecmp_addr_u   )) ? (pwrite && psel && penable) : 1'b0;
     
	  // Interrupts
	  assign mtime_count_sel = (INTERNAL_MTIME) ? mtime_count_out : mtime_count_in;
      assign m_timer_irq     = ((INTERNAL_MTIME_IRQ) & (mtime_count_sel >= mtimecmp)) ? 1'b1 : 1'b0;
	
      // Sync Reset
      assign aresetn = (SYNC_RESET == 1) ? 1'b1 : presetn;
      assign sresetn = (SYNC_RESET == 1) ? presetn : 1'b1;
	  
      // RTC Tick
      assign rtc_tick = (rtc_count == MTIME_PRESCALER) ? 1'b1 : 1'b0;
	
    //-----------------------------------------------------------------------------
    // Logic 
    //-----------------------------------------------------------------------------
      //RTC
      always @(negedge aresetn or posedge pclk) 
	    begin
          if ((!aresetn) || (!sresetn)) begin
              rtc_count <= 32'h0;
          end else begin
              if(rtc_tick) begin
                  rtc_count <= 32'h0;
              end else begin
                  rtc_count <= rtc_count + 32'h1;
              end
          end
        end
	    
      // mtime_count_out Register
      always @(negedge aresetn or posedge pclk)
        begin : p_MTIME
          if ((!aresetn) || (!sresetn) || (!INTERNAL_MTIME)) begin
              mtime_count_out <= 32'b0;
          end else begin
              if (T_l_En) begin
                  mtime_count_out[31:0] <= pwdata[31:0];
              end else if (T_h_En) begin
                  mtime_count_out[63:32] <= pwdata[31:0];
              end else if (rtc_tick) begin
                  mtime_count_out <= mtime_count_out + 1;
              end
          end
        end
		
      // MTIMECMP Register
        always @(negedge aresetn or posedge pclk)
          begin : p_MTIMECMP
            if ((!aresetn) || (!sresetn)) begin
                mtimecmp <= 64'hFFFF_FFFF_FFFF_FFFF;
            end else begin
                if (Tc0_l_En) mtimecmp[31:0]  <= pwdata[31:0]; 
                if (Tc0_h_En) mtimecmp[63:32] <= pwdata[31:0];
            end
          end
	
      // APB_0 Read Register
        always @(pwrite or psel or paddr)
          begin : p_APB_0_Read
            if (!pwrite && psel) begin
                case (paddr)
                  l_mtime_prescaler_addr: prdata <= {15'b0, MTIME_PRESCALER[15:0]};
                    l_mtimecmp_addr_base: prdata <= mtimecmp[31:0];
                       l_mtimecmp_addr_u: prdata <= mtimecmp[63:32];
                       l_mtime_addr_base: prdata <= mtime_count_sel[31:0];
                          l_mtime_addr_u: prdata <= mtime_count_sel[63:32];
                                 default: prdata <= 32'b0;
                endcase
            end else begin
                prdata <= 32'b0;
            end
          end
	
endmodule
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_ahb_mstr.sv
//
//   Purpose:
//    opsrv_Bridge AHB Master
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_opsrv_ahb_mstr
//********************************************************************************
// Parameter description

  #(   
    parameter AHB_MSTR_ADDR_WIDTH = 32

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,

    // Control/status/config    
    input wire logic                             opsrv_parity_en,
    output     logic                             trx_os_d_rd,
    output     logic                             trx_os_d_wr,

    // CPU interface    
    input wire  logic                            cpu_i_req_valid,
    output      logic                            cpu_i_req_ready, 
    input wire  logic [3:0]                      cpu_i_req_rd_byte_en,
    input wire  logic [AHB_MSTR_ADDR_WIDTH-1:0]  cpu_i_req_addr,
    input wire  logic                            cpu_i_req_addr_p,
    output      logic                            cpu_i_resp_valid,
    input wire  logic                            cpu_i_resp_ready,
    output      logic                            cpu_i_resp_error,
    output      logic [31:0]                     cpu_i_resp_rd_data, 
    output      logic [3:0]                      cpu_i_resp_rd_data_p, 
    input wire  logic                            cpu_d_req_valid,
    output      logic                            cpu_d_req_ready, 
    input wire  logic [3:0]                      cpu_d_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_d_req_wr_byte_en,
    input wire  logic                            cpu_d_req_read,  
    input wire  logic                            cpu_d_req_write,
    input wire  logic [AHB_MSTR_ADDR_WIDTH-1:0]  cpu_d_req_addr,
    input wire  logic                            cpu_d_req_addr_p,
    input wire  logic [31:0]                     cpu_d_req_wr_data,
    input wire  logic [3:0]                      cpu_d_req_wr_data_p,
    output      logic                            cpu_d_resp_valid,
    input wire  logic                            cpu_d_resp_ready,
    output      logic                            cpu_d_resp_rd_error,
    output      logic [31:0]                     cpu_d_resp_rd_data,  
    output      logic [3:0]                      cpu_d_resp_rd_data_p,   
    
    input wire  logic                            udma_req_valid,      
    output      logic                            udma_req_ready,      
    input wire  logic [3:0]                      udma_req_rd_byte_en, 
    input wire  logic [3:0]                      udma_req_wr_byte_en, 
    input wire  logic                            udma_req_read,       
    input wire  logic                            udma_req_write,      
    input wire  logic [AHB_MSTR_ADDR_WIDTH-1:0]  udma_req_addr,       
    input wire  logic                            udma_req_addr_p,     
    input wire  logic [3:0]                      udma_req_len,         
    input wire  logic [31:0]                     udma_req_wr_data,     
    input wire  logic [3:0]                      udma_req_wr_data_p,   
    input wire  logic                            udma_req_wr_data_last,
    output      logic                            udma_resp_valid,      
    output      logic                            udma_resp_last,       
    input wire  logic                            udma_resp_ready,      
    output      logic                            udma_resp_rd_error,   
    output      logic [31:0]                     udma_resp_rd_data,    
    output      logic [3:0]                      udma_resp_rd_data_p,  
    
    // AHB Master interface
    output      logic [AHB_MSTR_ADDR_WIDTH-1:0]  haddr, 
    output      logic                            haddr_p,
    output      logic [2:0]                      hburst, 
    output      logic                            hmastlock, 
    output      logic [3:0]                      hprot, 
    output      logic [2:0]                      hsize, 
    output      logic [1:0]                      htrans,
    output      logic [31:0]                     hwdata,
    output      logic [3:0]                      hwdata_p,
    output      logic                            hwrite,
    input wire  logic [31:0]                     hrdata, 
    input wire  logic [3:0]                      hrdata_p,
    input wire  logic                            hready, 
    input wire  logic                            hresp
    
  );

//********************************************************************************
// Declarations


// localparams
  localparam AHB_MSTR_REGISTER_IO = 1;
  localparam IDLE_ST = 3'd0, ADDR_ST = 3'd1, DATA_ST = 3'd2;
  
// Internal nets

  logic [1:0]                       req_valid;                   
  logic [3:0]                       req_rd_byte_en [1:0];        
  logic [3:0]                       req_wr_byte_en [1:0];        
  logic [AHB_MSTR_ADDR_WIDTH-1:0]   req_addr [1:0];              
  //logic [1:0]                       req_addr_p;                  
  logic [31:0]                      req_wr_data [1:0];           
  logic [3:0]                       req_wr_data_p [1:0];         
      
  logic [1:0]                       ahb_src_req;
  logic [1:0]                       ahb_src_gnt;
  logic [1:0]                       ahb_src_sel;
  logic [1:0]                       ahb_resp_sel;
  
  logic                             req_valid_mux;
  logic [3:0]                       req_wr_byte_en_mux;
  logic [3:0]                       req_rd_byte_en_mux;
  logic [AHB_MSTR_ADDR_WIDTH-1:0]   req_addr_mux;
  logic                             req_addr_p_mux;
  logic [31:0]                      req_wr_data_mux;
  logic [3:0]                       req_wr_data_p_mux;
  
  logic [31:0]                      resp_rd_data; 
  logic                             resp_error;
  logic [3:0]                       resp_rd_data_p;
   
  logic [31:0]                      hrdata_reg;    
  logic [3:0]                       hrdata_p_reg;  
  logic                             hresp_reg;   
  
  logic                             req_complete;
  logic                             req_complete_reg;
  logic [2:0]                       ahb_st;
  

  
   assign udma_req_ready      = 1'b0;      
   assign udma_resp_valid     = 1'b0;            
   assign udma_resp_last      = 1'b0;              
   assign udma_resp_rd_error  = 1'b0;         
   assign udma_resp_rd_data   = 32'b0;          
   assign udma_resp_rd_data_p = 4'b0;        
//********************************************************************************
// Main code
//********************************************************************************

 // Arbitrate between I and D-side
 
 // CPU I
  assign req_valid[0]         = cpu_i_req_valid;
  assign req_rd_byte_en[0]    = cpu_i_req_rd_byte_en;
  assign req_wr_byte_en[0]    = {4{1'b0}};
  assign req_addr[0]          = cpu_i_req_addr;
  //assign req_addr_p[0]        = cpu_i_req_addr_p;
  assign req_wr_data[0]       = {32{1'b0}};
  assign req_wr_data_p[0]     = {4{1'b0}};
  assign cpu_i_resp_error     = resp_error;  
  assign cpu_i_resp_rd_data   = resp_rd_data;  
  assign cpu_i_resp_rd_data_p = resp_rd_data_p;   

// CPU D
  assign req_valid[1]         = cpu_d_req_valid;
  assign req_rd_byte_en[1]    = cpu_d_req_rd_byte_en;
  assign req_wr_byte_en[1]    = cpu_d_req_wr_byte_en;
  assign req_addr[1]          = cpu_d_req_addr;
  //assign req_addr_p[1]        = cpu_d_req_addr_p;
  assign req_wr_data[1]       = cpu_d_req_wr_data;
  assign req_wr_data_p[1]     = cpu_d_req_wr_data_p;
  assign cpu_d_resp_rd_error     = resp_error; 
  assign cpu_d_resp_rd_data   = resp_rd_data;  
  assign cpu_d_resp_rd_data_p = resp_rd_data_p; 

  assign ahb_src_req = req_valid;

  MIV_RV32IMC_rr_pri_arb
  //***************************************************************
  // Parameter description
  #(
    .NUM_REQS                  (2),
    .USE_FORMAL                (1),
    .USE_SIM                   (1)
   )

  u_ahb_mstr_req_arb
  //***************************************************************
  // Signal description
  (
    .resetn              (resetn),
    .clk                 (clk),
    .unlock              (req_complete),
    .req                 (ahb_src_req),
    .gnt                 (ahb_src_gnt),            //open
    .sel_seq             (ahb_resp_sel),
    .sel_early           (ahb_src_sel)                   
  );
  
  always @*
  begin : raddr_mux_loop
    integer i;
    req_wr_byte_en_mux   = {4{1'b0}};
    req_rd_byte_en_mux   = {4{1'b0}};
    req_addr_mux         = {AHB_MSTR_ADDR_WIDTH{1'b0}};
    req_wr_data_mux      = {32{1'b0}};
    req_wr_data_p_mux    = {4{1'b0}};
    for(i=0; i<2; i=i+1)
    begin                                                                                      
      req_wr_byte_en_mux   = req_wr_byte_en_mux | ({4{ahb_src_sel[i]}} & req_wr_byte_en[i]);   
      req_rd_byte_en_mux   = req_rd_byte_en_mux | ({4{ahb_src_sel[i]}} & req_rd_byte_en[i]); 
      req_addr_mux         = req_addr_mux       | ({AHB_MSTR_ADDR_WIDTH{ahb_src_sel[i]}} & req_addr[i]);      
      req_wr_data_mux      = req_wr_data_mux    | ({32{ahb_src_sel[i]}} & req_wr_data[i]);    
      req_wr_data_p_mux    = req_wr_data_p_mux  | ({4{ahb_src_sel[i]}} & req_wr_data_p[i]);  
    end
  end
  
  
////////////////////////////////////////////////////////////////////////////////  
  
  assign cpu_i_resp_valid = ahb_resp_sel[0] & req_complete;  
  assign cpu_d_resp_valid = ahb_resp_sel[1] & req_complete;
  
  assign hburst = 3'b000;    // Always single burst 
  assign hmastlock = 1'b0;   // No lock
  assign hprot = 4'b0;       // Currently not supported 
	
	
  always @(posedge clk or negedge resetn)
    begin
      if(~resetn) begin
          req_complete_reg <= 1'b0;
          ahb_st           <= IDLE_ST;
          
          htrans           <= 2'b00;
          hsize            <= 3'b000;
          hwrite           <= 1'b0;
          hwdata           <= {32{1'b0}};
          hwdata_p         <= {4{1'b0}};  // REVISIT seperate this out to remove unecessary flops when not configured      
      end else begin
          case(ahb_st)
              IDLE_ST: begin
                         req_complete_reg <= 1'b0;
                         if(req_valid_mux) begin
                             ahb_st   <= ADDR_ST;                         
                             hwdata   <= req_wr_data_mux;
                             hwdata_p <= req_wr_data_p_mux;
                             hwrite   <= |req_wr_byte_en_mux;
                             htrans   <= 2'b10;
                             
                             if(|req_wr_byte_en_mux) begin
                                 case(req_wr_byte_en_mux)
                                   4'b0011: hsize <= 3'b001;
                                   4'b0110: hsize <= 3'b001;
                                   4'b1100: hsize <= 3'b001;
                                   4'b1111: hsize <= 3'b010;
                                   default: hsize <= 3'b000;
                                 endcase
                             end else begin
                                 case(req_rd_byte_en_mux)
                                   4'b0011: hsize <= 3'b001;
                                   4'b0110: hsize <= 3'b001;
                                   4'b1100: hsize <= 3'b001;
                                   4'b1111: hsize <= 3'b010;
                                   default: hsize <= 3'b000;
                                 endcase
                             end
                         end
                       end
             ADDR_ST: begin
                         if(hready) begin
                             ahb_st  <= DATA_ST;
                         end else begin
                             ahb_st  <= ADDR_ST;
                         end
                       end
            DATA_ST: begin
                         if(hready) begin
                             req_complete_reg <= 1'b1;
                             ahb_st           <= IDLE_ST;
                             
                             htrans           <= 2'b00;
                             hsize            <= 3'b000;
                             hwrite           <= 1'b0;
                         end
                       end
              default: begin
                         req_complete_reg <= 1'b0;
                         ahb_st           <= IDLE_ST;
        
                         htrans           <= 2'b00;
                         hsize            <= 3'b000;
                         hwrite           <= 1'b0;
                         hwdata           <= {32{1'b0}};
                         hwdata_p         <= {4{1'b0}};
                       end
          endcase
      end
    end
  
  //haddr
  always @(posedge clk or negedge resetn)
    begin
      if(~resetn) begin
          haddr   <= {AHB_MSTR_ADDR_WIDTH{1'b0}};
          haddr_p <= 1'b0;
      end else if(req_valid_mux) begin
          haddr   <= req_addr_mux;
          haddr_p <= ^req_addr_mux;
      end
  end
  
  always @(posedge clk or negedge resetn)
    begin 
      if(~resetn) begin
          hrdata_reg   <= {32{1'b0}};
          hrdata_p_reg <= {4{1'b0}};
          hresp_reg  <= 1'b0; 
      end else begin
          hrdata_reg   <= hrdata;
          hrdata_p_reg <= hrdata_p;
          hresp_reg  <= hresp; 
      end 
    end
  
  assign req_valid_mux   = |ahb_src_gnt; 
  assign cpu_i_req_ready = ahb_src_gnt[0];
  assign cpu_d_req_ready = ahb_src_gnt[1];

  // todo - Is this needed ?
  generate if(AHB_MSTR_REGISTER_IO) begin : gen_ahb_reg 
	assign req_complete   = req_complete_reg;
    assign resp_rd_data   = hrdata_reg;  
    assign resp_rd_data_p = hrdata_p_reg;
    assign resp_error  = hresp_reg;
  end else begin : gen_ahb_no_reg
	assign req_complete   = ((ahb_st == DATA_ST) & (hready)) ? 1'b1 : 1'b0;
    assign resp_rd_data   = hrdata;  
    assign resp_rd_data_p = hrdata_p; 
    assign resp_error  = hresp;
  end 
  endgenerate
	
  assign trx_os_d_rd = 1'b0; // REVISIT
  assign trx_os_d_wr = 1'b0; // REVISIT

endmodule


`default_nettype wire


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_apb_mstr.sv
//
//   Purpose:
//    opsrv_Bridge APB Master
//    Supports AMBA4 APB interface (also AMBA 3 without strb, prot signals)
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_opsrv_apb_mstr
//********************************************************************************
// Parameter description

  #(   
    parameter APB_MSTR_ADDR_WIDTH = 32,
    parameter APB_MSTR_REGISTER_IO     = 1

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             presetn,
    input wire logic                             clk,

    // Control/status/config    
    input wire logic                             opsrv_parity_en,
    output     logic                             trx_os_d_rd,
    output     logic                             trx_os_d_wr,

    // CPU interface    
    input wire  logic                            cpu_i_req_valid,
    output      logic                            cpu_i_req_ready, 
    input wire  logic [3:0]                      cpu_i_req_rd_byte_en,
    input wire  logic [APB_MSTR_ADDR_WIDTH-1:0]  cpu_i_req_addr,
    input wire  logic                            cpu_i_req_addr_p,
    output      logic                            cpu_i_resp_valid,
    input wire  logic                            cpu_i_resp_ready,
    output      logic                            cpu_i_resp_error,
    output      logic [31:0]                     cpu_i_resp_rd_data, 
    output      logic [3:0]                      cpu_i_resp_rd_data_p, 
    input wire  logic                            cpu_d_req_valid,
    output      logic                            cpu_d_req_ready, 
    input wire  logic [3:0]                      cpu_d_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_d_req_wr_byte_en,
    input wire  logic [APB_MSTR_ADDR_WIDTH-1:0]  cpu_d_req_addr,
    input wire  logic                            cpu_d_req_addr_p,
    input wire  logic [31:0]                     cpu_d_req_wr_data,
    input wire  logic [3:0]                      cpu_d_req_wr_data_p,
    output      logic                            cpu_d_resp_valid,
    input wire  logic                            cpu_d_resp_ready,
    output      logic                            cpu_d_resp_error,
    output      logic [31:0]                     cpu_d_resp_rd_data,  
    output      logic [3:0]                      cpu_d_resp_rd_data_p,   
    
    // APB Master interface
    output      logic [APB_MSTR_ADDR_WIDTH-1:0]  paddr, 
    output      logic                            paddr_p,
    output      logic [2:0]                      pprot,
    output      logic                            psel,
    output      logic                            penable, 
    output      logic                            pwrite, 
    output      logic [31:0]                     pwdata,
    output      logic [3:0]                      pwdata_p,
    output      logic [3:0]                      pstrb, 
    input wire  logic                            pready, 
    input wire  logic [31:0]                     prdata,
    input wire  logic [3:0]                      prdata_p, 
    input wire  logic                            pslverr
    
  );

//********************************************************************************
// Declarations

// localparams
  localparam l_opsrv_cfg_apb_byte_shim = 1'b1;
  localparam IDLE_ST = 3'd0, SETUP_ST = 3'd1, ACCESS_ST = 3'd2, BH_READ_0_ST = 3'd3, BH_READ_1_ST = 3'd4, BH_WRITE_ST = 3'd5;
  
// Internal nets

  logic [1:0]                       req_valid;                   
  //logic [3:0]                       req_rd_byte_en [1:0];        
  logic [3:0]                       req_wr_byte_en [1:0];        
  logic [APB_MSTR_ADDR_WIDTH-1:0]   req_addr [1:0];              
  //logic [1:0]                       req_addr_p;                  
  logic [31:0]                      req_wr_data [1:0];           
  logic [3:0]                       req_wr_data_p [1:0];         
      
  logic [1:0]                       apb_src_req;
  logic [1:0]                       apb_src_gnt;
  logic [1:0]                       apb_src_sel;
  logic [1:0]                       apb_resp_sel;
  
  logic                             req_valid_mux;
  logic [3:0]                       req_wr_byte_en_mux;
  //logic [3:0]                       req_rd_byte_en_mux;
  logic [APB_MSTR_ADDR_WIDTH-1:0]   req_addr_mux;
  logic                             req_addr_p_mux;
  logic [31:0]                      req_wr_data_mux;
  logic [3:0]                       req_wr_data_p_mux;
  
  logic [31:0]                      resp_rd_data; 
  logic                             resp_error;
  logic [3:0]                       resp_rd_data_p;
   
  logic [31:0]                      prdata_reg;    
  logic [3:0]                       prdata_p_reg;  
  logic                             pslverr_reg;   
  
  logic                             req_complete;
  logic                             req_complete_reg;
  logic [2:0]                       apb_st;
  

//********************************************************************************
// Main code
//********************************************************************************

 // Arbitrate between I and D-side
 
 // CPU I
  assign req_valid[0]         = cpu_i_req_valid;
  //assign req_rd_byte_en[0]    = cpu_i_req_rd_byte_en;
  assign req_wr_byte_en[0]    = {4{1'b0}};
  assign req_addr[0]          = cpu_i_req_addr;
  //assign req_addr_p[0]        = cpu_i_req_addr_p;
  assign req_wr_data[0]       = {32{1'b0}};
  assign req_wr_data_p[0]     = {4{1'b0}};
  assign cpu_i_resp_error     = resp_error;  
  assign cpu_i_resp_rd_data   = resp_rd_data;  
  assign cpu_i_resp_rd_data_p = resp_rd_data_p;   

// CPU D
  assign req_valid[1]         = cpu_d_req_valid;
  //assign req_rd_byte_en[1]    = cpu_d_req_rd_byte_en;
  assign req_wr_byte_en[1]    = cpu_d_req_wr_byte_en;
  assign req_addr[1]          = cpu_d_req_addr;
  //assign req_addr_p[1]        = cpu_d_req_addr_p;
  assign req_wr_data[1]       = cpu_d_req_wr_data;
  assign req_wr_data_p[1]     = cpu_d_req_wr_data_p;
  assign cpu_d_resp_error     = resp_error; 
  assign cpu_d_resp_rd_data   = resp_rd_data;  
  assign cpu_d_resp_rd_data_p = resp_rd_data_p; 

  assign apb_src_req = req_valid;

  MIV_RV32IMC_rr_pri_arb
  //***************************************************************
  // Parameter description
  #(
    .NUM_REQS                  (2),
    .USE_FORMAL                (1),
    .USE_SIM                   (1)
   )

  u_apb_mstr_req_arb
  //***************************************************************
  // Signal description
  (
    .resetn              (presetn),
    .clk                 (clk),
    .unlock              (req_complete),
    .req                 (apb_src_req),
    .gnt                 (apb_src_gnt),            //open
    .sel_seq             (apb_resp_sel),
    .sel_early           (apb_src_sel)                   
  );
  
  always @*
  begin : raddr_mux_loop
    integer i;
    req_wr_byte_en_mux   = {4{1'b0}};
    //req_rd_byte_en_mux   = {4{1'b0}};
    req_addr_mux         = {APB_MSTR_ADDR_WIDTH{1'b0}};
    req_wr_data_mux      = {32{1'b0}};
    req_wr_data_p_mux    = {4{1'b0}};
    for(i=0; i<2; i=i+1)
    begin                                                                                      
      req_wr_byte_en_mux   = req_wr_byte_en_mux | ({4{apb_src_sel[i]}} & req_wr_byte_en[i]);   
      //req_rd_byte_en_mux   = req_rd_byte_en_mux | ({4{apb_src_sel[i]}} & req_rd_byte_en[i]); 
      req_addr_mux         = req_addr_mux       | ({APB_MSTR_ADDR_WIDTH{apb_src_sel[i]}} & req_addr[i]);      
      req_wr_data_mux      = req_wr_data_mux    | ({32{apb_src_sel[i]}} & req_wr_data[i]);    
      req_wr_data_p_mux    = req_wr_data_p_mux  | ({4{apb_src_sel[i]}} & req_wr_data_p[i]);  
    end
  end
  
  
////////////////////////////////////////////////////////////////////////////////  
  
  assign cpu_i_resp_valid = apb_resp_sel[0] & req_complete;  
  assign cpu_d_resp_valid = apb_resp_sel[1] & req_complete;
  
  generate if(l_opsrv_cfg_apb_byte_shim) begin : gen_apb_byte_shim
      always @(posedge clk or negedge presetn)
        begin
          if(~presetn) begin
              req_complete_reg <= 1'b0;
              apb_st   <= IDLE_ST;
              penable  <= 1'b0;
              psel     <= 1'b0;
			  pwrite   <= 1'b0;
			  pwdata   <= 32'b0;
			  pwdata_p <= 4'b0;
			  pstrb    <= 4'b0;
          end else begin
              case(apb_st)
                  IDLE_ST: begin
                             req_complete_reg <= 1'b0;
                             if(req_valid_mux) begin
                                 psel     <= 1'b1;
                                 pwdata   <= req_wr_data_mux;
                                 pwdata_p <= req_wr_data_p_mux;
                                 pstrb    <= req_wr_byte_en_mux;
							     if(req_wr_byte_en_mux != 4'b0000 & req_wr_byte_en_mux != 4'b1111) begin
								     apb_st <= BH_READ_0_ST;
                                     pwrite <= 1'b0;
								 end else begin								 
                                     apb_st   <= SETUP_ST;
                                     pwrite   <= |req_wr_byte_en_mux;
								 end 
                             end
                           end
             BH_READ_0_ST: begin
                             penable <= 1'b1;
                             apb_st  <= BH_READ_1_ST;
                           end
             BH_READ_1_ST: begin
                             if(pready) begin
                                 apb_st  <= BH_WRITE_ST;
                                 penable <= 1'b0;
                                 psel    <= 1'b0;
                             end
						   end
              BH_WRITE_ST : begin
							 apb_st <= SETUP_ST;
                             psel   <= 1'b1;
                             pwrite <= 1'b1;
							 
							 pwdata[31:24] <= (pstrb[3]) ? pwdata[31:24] : prdata_reg[31:24];
							 pwdata[23:16] <= (pstrb[2]) ? pwdata[23:16] : prdata_reg[23:16];
							 pwdata[15:8 ] <= (pstrb[1]) ? pwdata[15:8 ] : prdata_reg[15:8 ];
							 pwdata[ 7:0 ] <= (pstrb[0]) ? pwdata[ 7:0 ] : prdata_reg[ 7:0 ];
							 
							 pwdata_p[3] <= (pstrb[3]) ? pwdata_p[3] : prdata_p_reg[3];
							 pwdata_p[2] <= (pstrb[2]) ? pwdata_p[2] : prdata_p_reg[2];
							 pwdata_p[1] <= (pstrb[1]) ? pwdata_p[1] : prdata_p_reg[1];
							 pwdata_p[0] <= (pstrb[0]) ? pwdata_p[0] : prdata_p_reg[0];
				           end
                 SETUP_ST: begin
                             penable <= 1'b1;
                             apb_st  <= ACCESS_ST;
                           end
                ACCESS_ST: begin
                             if(pready) begin
                                 req_complete_reg <= 1'b1;
                                 apb_st  <= IDLE_ST;
                                 penable <= 1'b0;
                                 psel    <= 1'b0;
                             end
                           end
                  default: begin
                             req_complete_reg <= 1'b0;
                             apb_st  <= IDLE_ST;
                             penable <= 1'b0;
                             psel    <= 1'b0;
                           end
              endcase
          end
        end
    end else begin  : ngen_apb_byte_shim
      always @(posedge clk or negedge presetn)
        begin
          if(~presetn) begin
              req_complete_reg <= 1'b0;
              apb_st   <= IDLE_ST;
              penable  <= 1'b0;
              psel     <= 1'b0;
              pwrite   <= 1'b0;
              pstrb    <= {4{1'b0}};
              pwdata   <= {32{1'b0}};
              pwdata_p <= {4{1'b0}};  // REVISIT seperate this out to remove unecessary flops when not configured
          end else begin
              case(apb_st)
                  IDLE_ST: begin
                             req_complete_reg <= 1'b0;
                             if(req_valid_mux) begin
                                 apb_st   <= SETUP_ST;
                                 psel     <= 1'b1;
                                 pwrite   <= |req_wr_byte_en_mux;
                                 pstrb    <= req_wr_byte_en_mux;
                                 pwdata   <= req_wr_data_mux;
                                 pwdata_p <= req_wr_data_p_mux;
                             end
                           end
                 SETUP_ST: begin
                             penable <= 1'b1;
                             apb_st  <= ACCESS_ST;
                           end
                ACCESS_ST: begin
                             if(pready) begin
                                 req_complete_reg <= 1'b1;
                                 apb_st  <= IDLE_ST;
                                 penable <= 1'b0;
                                 psel    <= 1'b0;
                             end
                           end
                  default: begin
                             req_complete_reg <= 1'b0;
                             apb_st   <= IDLE_ST;
                             penable  <= 1'b0;
                             psel     <= 1'b0;
                             pwrite   <= 1'b0;
                             pstrb    <= {4{1'b0}};
                             pwdata   <= {32{1'b0}};
                             pwdata_p <= {4{1'b0}};
                           end
              endcase
          end
        end
  end
  endgenerate
  
  //paddr
  always @(posedge clk or negedge presetn)
    begin
      if(~presetn) begin
          paddr   <= {APB_MSTR_ADDR_WIDTH{1'b0}};
          paddr_p <= 1'b0;
      end else if(req_valid_mux) begin
          paddr   <= req_addr_mux;
          paddr_p <= ^req_addr_mux;
      end
  end
  
  always @(posedge clk or negedge presetn)
    begin 
      if(~presetn) begin
          prdata_reg   <= {32{1'b0}};
          prdata_p_reg <= {4{1'b0}};
          pslverr_reg  <= 1'b0; 
      end else begin
          prdata_reg   <= prdata;
          prdata_p_reg <= prdata_p;
          pslverr_reg  <= pslverr; 
      end 
    end
  
  assign pprot           = 3'b000; // REVISIT could make prot[2] instruction hint accurate
  assign req_valid_mux   = |apb_src_gnt; 
  assign cpu_i_req_ready = apb_src_gnt[0];
  assign cpu_d_req_ready = apb_src_gnt[1];

  generate if(APB_MSTR_REGISTER_IO) begin : gen_apb_reg 
	assign req_complete   = req_complete_reg;
    assign resp_rd_data   = prdata_reg;  
    assign resp_rd_data_p = prdata_p_reg;
    assign resp_error  = pslverr_reg;
  end else begin : gen_apb_no_reg
	assign req_complete   = ((apb_st == ACCESS_ST) & (pready)) ? 1'b1 : 1'b0;
    assign resp_rd_data   = prdata;  
    assign resp_rd_data_p = prdata_p; 
    assign resp_error  = pslverr;
  end 
  endgenerate
	
  assign trx_os_d_rd = 1'b0; // REVISIT
  assign trx_os_d_wr = 1'b0; // REVISIT

endmodule

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_axi_mstr.sv
//
//   Purpose:
//    opsrv_Bridge AXI Master
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv_axi_mstr
//********************************************************************************
// Parameter description

  #(   
    parameter AXI_MSTR_ADDR_WIDTH = 32

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,
    input wire logic                             aclk_en,

    // Control/status/config    
    input wire logic [1:0]                       axi_rd_cfg_min_size,
    input wire logic [1:0]                       axi_wr_cfg_min_size,
    input wire logic                             opsrv_parity_en,
    input wire logic                             cfg_fence_all_src,
    input wire logic [3:0]                       cfg_ar_cache,
    input wire logic [3:0]                       cfg_aw_cache,  
    input wire logic                             cfg_raw_hzd_check,
    input wire logic                             cfg_war_hzd_check,
    output     logic                             trx_os_d_rd,
    output     logic                             trx_os_d_wr,
    

    // CPU interface    
    input wire logic                             cpu_i_req_valid,
    output     logic                             cpu_i_req_ready, 
    input wire logic [3:0]                       cpu_i_req_rd_byte_en,
    input wire logic [AXI_MSTR_ADDR_WIDTH-1:0]   cpu_i_req_addr,
    input wire logic                             cpu_i_req_addr_p,
    output     logic                             cpu_i_resp_valid,
    input wire logic                             cpu_i_resp_ready,
    output     logic                             cpu_i_resp_error,
    output     logic [31:0]                      cpu_i_resp_rd_data, 
    output     logic [3:0]                       cpu_i_resp_rd_data_p, 
    input wire logic                             cpu_d_req_valid,
    output     logic                             cpu_d_req_ready, 
    input wire logic [3:0]                       cpu_d_req_rd_byte_en,  
    input wire logic [3:0]                       cpu_d_req_wr_byte_en,
    input wire logic                             cpu_d_req_read, 
    input wire logic                             cpu_d_req_write,
    input wire logic [AXI_MSTR_ADDR_WIDTH-1:0]   cpu_d_req_addr,
    input wire logic                             cpu_d_req_addr_p,
    input wire logic [31:0]                      cpu_d_req_wr_data,
    input wire logic [3:0]                       cpu_d_req_wr_data_p,
    output     logic                             cpu_d_resp_valid,
    input wire logic                             cpu_d_resp_ready,
    output     logic                             cpu_d_resp_rd_error,
    output     logic [31:0]                      cpu_d_resp_rd_data,  
    output     logic [3:0]                       cpu_d_resp_rd_data_p,  
    output     logic                             cpu_d_wr_resp_err,
  
    
    // uDMA interface 
    input wire logic                             udma_req_valid,
    output     logic                             udma_req_ready, 
    input wire logic [3:0]                       udma_req_rd_byte_en,  
    input wire logic [3:0]                       udma_req_wr_byte_en,
    input wire logic                             udma_req_read, 
    input wire logic                             udma_req_write,
    input wire logic [AXI_MSTR_ADDR_WIDTH-1:0]   udma_req_addr,
    input wire logic                             udma_req_addr_p,
    input wire logic [3:0]                       udma_req_len,
    input wire logic [31:0]                      udma_req_wr_data,
    input wire logic [3:0]                       udma_req_wr_data_p,
    input wire logic                             udma_req_wr_data_last,
    output     logic                             udma_resp_valid,
    output     logic                             udma_resp_last,
    input wire logic                             udma_resp_ready,
    output     logic                             udma_resp_rd_error,
    output     logic [31:0]                      udma_resp_rd_data, 
    output     logic [3:0]                       udma_resp_rd_data_p,
    output     logic                             udma_wr_resp_err,
    
    // AXI Master interface
      // AXI Read channel interface
        //RADDR channel (and sidebands)
    output logic                                  aximstr_arid,
    output logic [AXI_MSTR_ADDR_WIDTH-1:0]        aximstr_araddr,
    output logic [3:0]                            aximstr_arlen,
    output logic [2:0]                            aximstr_arsize,
    output logic [1:0]                            aximstr_arburst,
    output logic                                  aximstr_arlock,
    output logic [3:0]                            aximstr_arcache,
    output logic [2:0]                            aximstr_arprot,
    input wire logic                              aximstr_arready,
    output logic                                  aximstr_arvalid,
    output logic                                  aximstr_ar_addr_p,
        //RRESP channel (and sidebands)
    input wire logic [1:0]                        aximstr_rresp,
    input wire logic [31:0]                       aximstr_rdata,
    input wire logic                              aximstr_rlast,
    input wire logic                              aximstr_rid,
    output logic                                  aximstr_rready,
    input wire logic                              aximstr_rvalid,
    input wire logic [3:0]                        aximstr_r_data_p,
      // AXI Write channel interface
        //WADDR channel (and sidebands)
    output logic                                  aximstr_awid,
    output logic [AXI_MSTR_ADDR_WIDTH-1:0]        aximstr_awaddr,
    output logic [3:0]                            aximstr_awlen,
    output logic [2:0]                            aximstr_awsize,
    output logic [1:0]                            aximstr_awburst,
    output logic                                  aximstr_awlock,
    output logic [3:0]                            aximstr_awcache,
    output logic [2:0]                            aximstr_awprot,
    output logic                                  aximstr_aw_addr_p,
    input wire logic                              aximstr_awready,
    output logic                                  aximstr_awvalid,
        //WDATA channel (and sidebands)
    output logic [31:0]                           aximstr_wdata,
    output logic [3:0]                            aximstr_wstrb,
    output logic                                  aximstr_wlast,
    output logic                                  aximstr_wid,
    input wire logic                              aximstr_wready,
    output logic                                  aximstr_wvalid,
    output logic [3:0]                            aximstr_w_data_p,   
        //BRESP channel
    input wire logic  [1:0]                       aximstr_bresp,
    input wire logic                              aximstr_bid,
    output logic                                  aximstr_bready,
    input wire logic                              aximstr_bvalid    
    
    
  );

//********************************************************************************
// Declarations

// localparams

    localparam NUM_READ_REQUESTERS  = 2 + l_opsrv_cfg_udma_present;
    localparam NUM_WRITE_REQUESTERS = 1 + l_opsrv_cfg_udma_present;
    localparam NUM_OS_WRITES        = 2;
    localparam LOG2_NUM_OS_WRITES   = 1;
    localparam NUM_OS_READS         = 2;
    localparam LOG2_NUM_OS_READS    = 1;


// Internal nets


  
   logic [AXI_MSTR_ADDR_WIDTH-1:0]                      cpu_i_axi_araddr;
   logic [3:0]                                          cpu_i_axi_arlen;
   logic [2:0]                                          cpu_i_axi_arsize;
   logic                                                cpu_i_axi_arready;
   logic                                                cpu_i_axi_arvalid;
   logic                                                cpu_i_axi_rready;
   logic                                                cpu_i_axi_rvalid;
   logic [1:0]                                          cpu_i_axi_rresp;
   logic [31:0]                                         cpu_i_axi_rdata;
   logic [3:0]                                          cpu_i_axi_rdata_p;  
   logic                                                cpu_i_axi_fence_rd_flush;    
   logic                                                cpu_i_axi_fence_rd_os; 
   logic [1:0]                                          cpu_i_rd_size;
   logic [2:0]                                          cpu_i_req_addr_strb;
   //cpu d-side
   logic [AXI_MSTR_ADDR_WIDTH-1:0]                      cpu_d_axi_araddr;
   logic [3:0]                                          cpu_d_axi_arlen;
   logic [2:0]                                          cpu_d_axi_arsize;
   logic                                                cpu_d_axi_arready;
   logic                                                cpu_d_axi_arvalid;
   logic                                                cpu_d_axi_rready;
   logic                                                cpu_d_axi_rvalid;
   logic [1:0]                                          cpu_d_axi_rresp;
   logic [31:0]                                         cpu_d_axi_rdata;
   logic [3:0]                                          cpu_d_axi_rdata_p;  
   logic                                                cpu_d_axi_fence_rd_flush;    
   logic                                                cpu_d_axi_fence_rd_os;  
   logic [1:0]                                          cpu_d_rd_size;
   logic [2:0]                                          cpu_d_req_rd_addr_strb;                    
   //udma
   logic [AXI_MSTR_ADDR_WIDTH-1:0]                      udma_axi_araddr;
   logic [3:0]                                          udma_axi_arlen;
   logic [2:0]                                          udma_axi_arsize;
   logic                                                udma_axi_arready;
   logic                                                udma_axi_arvalid;
   logic                                                udma_axi_rready;
   logic                                                udma_axi_rvalid;
   logic [1:0]                                          udma_axi_rresp;
   logic                                                udma_axi_rlast;
   logic [31:0]                                         udma_axi_rdata;
   logic [3:0]                                          udma_axi_rdata_p; 
   logic                                                udma_axi_fence_rd_flush;    
   logic                                                udma_axi_fence_rd_os; 
   logic [1:0]                                          udma_rd_size;
   logic [2:0]                                          udma_req_rd_addr_strb;
   
   logic [(NUM_OS_READS*AXI_MSTR_ADDR_WIDTH)-1:0]       os_read_addr_pkd;
   logic [NUM_OS_READS-1:0]                             os_read_valid_pkd;
   logic [NUM_OS_READS-1:0]                             os_read_cpu_d_valid_pkd;
   
   // cpu
   logic [AXI_MSTR_ADDR_WIDTH-1:0]                      cpu_axi_awaddr;
   logic [2:0]                                          cpu_axi_awsize;
   logic                                                cpu_axi_awready;
   logic                                                cpu_axi_awvalid;
   logic [31:0]                                         cpu_axi_wdata;
   logic [3:0]                                          cpu_axi_wdata_p;
   logic                                                cpu_axi_wlast;
   logic [3:0]                                          cpu_axi_wstrb;
   logic                                                cpu_axi_wready;
   logic                                                cpu_axi_wvalid; 
   logic                                                cpu_axi_fence_wr_flush;  
   logic                                                cpu_axi_fence_wr_os;
   logic [1:0]                                          cpu_d_wr_size;
   logic [2:0]                                          cpu_d_req_wr_addr_strb;  
   //udma   
   logic [AXI_MSTR_ADDR_WIDTH-1:0]                      udma_axi_awaddr;
   logic [3:0]                                          udma_axi_awlen;
   logic [2:0]                                          udma_axi_awsize;
   logic                                                udma_axi_awready;
   logic                                                udma_axi_awvalid;
   logic [31:0]                                         udma_axi_wdata;
   logic [3:0]                                          udma_axi_wdata_p;
   logic                                                udma_axi_wlast;
   logic [3:0]                                          udma_axi_wstrb;
   logic                                                udma_axi_wready;
   logic                                                udma_axi_wvalid;   
   logic                                                udma_axi_fence_wr_flush; 
   logic                                                udma_axi_fence_wr_os;
   logic [1:0]                                          udma_wr_size;
   logic [2:0]                                          udma_req_wr_addr_strb; 
   
   logic [(NUM_OS_WRITES*AXI_MSTR_ADDR_WIDTH)-1:0]      os_write_addr_pkd;
   logic [NUM_OS_WRITES-1:0]                            os_write_valid_pkd;   

   logic [NUM_OS_WRITES-1:0]                            raw_hzd_i;
   logic [NUM_OS_WRITES-1:0]                            raw_hzd_d;
   logic [NUM_OS_READS-1:0]                             war_hzd_d;
   logic                                                axi_raw_hzd_i;
   logic                                                axi_raw_hzd_d;
   logic                                                axi_war_hzd_d;
   
   logic [NUM_WRITE_REQUESTERS-1:0]                     write_response_error;


//********************************************************************************
// Main code
//********************************************************************************


  // the rchan block will perform arbitrartion between the read sources (cpu_i, cpu_d, and uDMA (if implemented)
  // NUM_READ_REQUESTERS must = 2 if no uDMA and = 3 if uDMA present

  // convert rd strobes into address and size, and align AXI address accordingly
  MIV_RV32IMC_strb_to_addr
  #(
    .NUM_BYTES          (4)
  )
  u_strb_to_addr_cpu_i_rd
  (
    .clk                (clk),
    .resetn             (resetn),
    .strb               (cpu_i_req_rd_byte_en),
    .cfg_min_size       (axi_rd_cfg_min_size),
    .addr               (cpu_i_req_addr_strb),
    .size               (cpu_i_rd_size)
  ); 
  
  assign cpu_i_axi_araddr             = {cpu_i_req_addr[AXI_MSTR_ADDR_WIDTH-1:2],cpu_i_req_addr_strb[1:0]};
  assign cpu_i_axi_arlen              = 4'd0;       // always 1 beat from CPU
  assign cpu_i_axi_arsize             = {1'b0,cpu_i_rd_size};
  assign cpu_i_axi_arvalid            = cpu_i_req_valid;       
  assign cpu_i_axi_rready             = cpu_i_resp_ready;  
  assign cpu_i_axi_fence_rd_flush      = 1'b0; // REVISIT 
  
  assign cpu_i_req_ready              = cpu_i_axi_arready;
  assign cpu_i_resp_valid             = cpu_i_axi_rvalid;
  assign cpu_i_resp_error             = (cpu_i_axi_rresp == 2'b10) || (cpu_i_axi_rresp == 2'b11); 
  assign cpu_i_resp_rd_data           = cpu_i_axi_rdata;         
  assign cpu_i_resp_rd_data_p         = cpu_i_axi_rdata_p;
  

  MIV_RV32IMC_strb_to_addr
  #(
    .NUM_BYTES          (4)
  )
  u_strb_to_addr_cpu_d_rd
  (
    .clk                (clk),
    .resetn             (resetn),
    .strb               (cpu_d_req_rd_byte_en),
    .cfg_min_size       (axi_rd_cfg_min_size),
    .addr               (cpu_d_req_rd_addr_strb),
    .size               (cpu_d_rd_size)
  ); 
  
  assign cpu_d_axi_araddr             = {cpu_d_req_addr[AXI_MSTR_ADDR_WIDTH-1:2],cpu_d_req_rd_addr_strb[1:0]};
  assign cpu_d_axi_arlen              = 4'd0;       // always 1 beat from CPU
  assign cpu_d_axi_arsize             = {1'b0,cpu_d_rd_size};
  assign cpu_d_axi_arvalid            = cpu_d_req_valid & cpu_d_req_read;       
  assign cpu_d_axi_rready             = cpu_d_resp_ready;  
  assign cpu_d_axi_fence_rd_flush     = 1'b0; // REVISIT 
  
  assign cpu_d_req_ready              = (cpu_d_req_read & cpu_d_axi_arready) |
                                        (cpu_d_req_write & cpu_axi_awready & cpu_axi_wready);
  assign cpu_d_resp_valid             = cpu_d_axi_rvalid;
  assign cpu_d_resp_rd_error          = (cpu_d_axi_rresp == 2'b10) || (cpu_d_axi_rresp == 2'b11); 
  assign cpu_d_resp_rd_data           = cpu_d_axi_rdata;         
  assign cpu_d_resp_rd_data_p         = cpu_d_axi_rdata_p;
  
  MIV_RV32IMC_strb_to_addr
  #(
    .NUM_BYTES          (4)
  )
  u_strb_to_addr_udma_rd
  (
    .clk                (clk),
    .resetn             (resetn),
    .strb               (udma_req_rd_byte_en),
    .cfg_min_size       (axi_rd_cfg_min_size),
    .addr               (udma_req_rd_addr_strb),
    .size               (udma_rd_size)
  ); 
  
  assign udma_axi_araddr             = {udma_req_addr[AXI_MSTR_ADDR_WIDTH-1:2],udma_req_rd_addr_strb[1:0]};
  assign udma_axi_arlen              = udma_req_len;      
  assign udma_axi_arsize             = {1'b0,udma_rd_size};
  assign udma_axi_arvalid            = udma_req_valid & udma_req_read;        
  assign udma_axi_rready             = udma_resp_ready;  
  assign udma_axi_fence_rd_flush     = 1'b0; // REVISIT 
  
  assign udma_req_ready              = (udma_req_read & udma_axi_arready) |
                                       (udma_req_write & udma_axi_awready & udma_axi_wready);
  assign udma_resp_valid             = udma_axi_rvalid;
  assign udma_resp_last              = udma_axi_rlast;
  assign udma_resp_rd_error          = (udma_axi_rresp == 2'b10) || (udma_axi_rresp == 2'b11); 
  assign udma_resp_rd_data           = udma_axi_rdata;         
  assign udma_resp_rd_data_p         = udma_axi_rdata_p;



  // read side 
  // contains AR and R channels
                
  MIV_RV32IMC_axi_rchan
  //***************************************************************
  // Parameter description
  #(
    .AXI_MSTR_RADDR_WIDTH           (AXI_MSTR_ADDR_WIDTH),         
    .NUM_REQUESTERS                 (NUM_READ_REQUESTERS),                  
    .NUM_OS_READS                   (NUM_OS_READS),              
    .LOG2_NUM_OS_READS              (LOG2_NUM_OS_READS)               
   )
  u_axi_rchan
  //***************************************************************
  // Signal description
  (
    .resetn                         (resetn),
    .clk                            (clk),
    .aclk_en                        (aclk_en),
   // .mstr_r_idle                    ( ),  // open. not currently used
    .read_parity_error              ( ),  // open. not currently used
    .opsrv_parity_en                (opsrv_parity_en),
    .cfg_fence_all                  (cfg_fence_all_src),
    .cfg_ar_cache                   (cfg_ar_cache),
    .aximstr_arid                   (aximstr_arid),
    .aximstr_araddr                 (aximstr_araddr),
    .aximstr_arlen                  (aximstr_arlen),
    .aximstr_arsize                 (aximstr_arsize),
    .aximstr_arburst                (aximstr_arburst),
    .aximstr_arlock                 (aximstr_arlock),
    .aximstr_arcache                (aximstr_arcache),
    .aximstr_arprot                 (aximstr_arprot),
    .aximstr_arready                (aximstr_arready),
    .aximstr_arvalid                (aximstr_arvalid),
    .aximstr_ar_addr_p              (aximstr_ar_addr_p),
    .aximstr_rresp                  (aximstr_rresp),
    .aximstr_rdata                  (aximstr_rdata),
    .aximstr_rlast                  (aximstr_rlast),
    .aximstr_rid                    (aximstr_rid),
    .aximstr_rready                 (aximstr_rready),
    .aximstr_rvalid                 (aximstr_rvalid),
    .aximstr_r_data_p               (aximstr_r_data_p),
    .cpu_i_axi_araddr               (cpu_i_axi_araddr),
    .cpu_i_axi_arlen                (cpu_i_axi_arlen),
    .cpu_i_axi_arsize               (cpu_i_axi_arsize),
    .cpu_i_axi_arready              (cpu_i_axi_arready),
    .cpu_i_axi_arvalid              (cpu_i_axi_arvalid),
    .cpu_i_axi_rready               (cpu_i_axi_rready),
    .cpu_i_axi_rvalid               (cpu_i_axi_rvalid),
    .cpu_i_axi_rresp                (cpu_i_axi_rresp),
    .cpu_i_axi_rlast                ( ), // open. CPU does not support multi-beat transactions
    .cpu_i_axi_rdata                (cpu_i_axi_rdata),
    .cpu_i_axi_rdata_p              (cpu_i_axi_rdata_p),
    .cpu_i_axi_fence_rd_flush        (cpu_i_axi_fence_rd_flush),
    .cpu_i_axi_fence_rd_os          (cpu_i_axi_fence_rd_os),
    .cpu_i_axi_raw_hzd              (axi_raw_hzd_i),
    .cpu_d_axi_araddr               (cpu_d_axi_araddr),
    .cpu_d_axi_arlen                (cpu_d_axi_arlen),
    .cpu_d_axi_arsize               (cpu_d_axi_arsize),
    .cpu_d_axi_arready              (cpu_d_axi_arready),
    .cpu_d_axi_arvalid              (cpu_d_axi_arvalid),
    .cpu_d_axi_rready               (cpu_d_axi_rready),
    .cpu_d_axi_rvalid               (cpu_d_axi_rvalid),
    .cpu_d_axi_rresp                (cpu_d_axi_rresp),
    .cpu_d_axi_rlast                ( ), // open. CPU does not support multi-beat transactions
    .cpu_d_axi_rdata                (cpu_d_axi_rdata),
    .cpu_d_axi_rdata_p              (cpu_d_axi_rdata_p),
    .cpu_d_axi_fence_rd_flush       (cpu_d_axi_fence_rd_flush),
    .cpu_d_axi_fence_rd_os          (cpu_d_axi_fence_rd_os),
    .cpu_d_axi_raw_hzd              (axi_raw_hzd_d),
    .udma_axi_araddr                (udma_axi_araddr),
    .udma_axi_arlen                 (udma_axi_arlen),
    .udma_axi_arsize                (udma_axi_arsize),
    .udma_axi_arready               (udma_axi_arready),
    .udma_axi_arvalid               (udma_axi_arvalid),
    .udma_axi_rready                (udma_axi_rready),
    .udma_axi_rvalid                (udma_axi_rvalid),
    .udma_axi_rresp                 (udma_axi_rresp),
    .udma_axi_rlast                 (udma_axi_rlast),
    .udma_axi_rdata                 (udma_axi_rdata),
    .udma_axi_rdata_p               (udma_axi_rdata_p),
    .udma_axi_fence_rd_flush        (udma_axi_fence_rd_flush),
    .udma_axi_fence_rd_os           (udma_axi_fence_rd_os),
    .udma_axi_raw_hzd               (1'b0 ), // REVISIT add when UDMA implemented
    .os_read_addr_pkd               (os_read_addr_pkd),
    .os_read_valid_pkd              (os_read_valid_pkd),
    .os_read_cpu_d_valid_pkd        (os_read_cpu_d_valid_pkd)
  ); 
  


  MIV_RV32IMC_strb_to_addr
  #(
    .NUM_BYTES          (4)
  )
  u_strb_to_addr_cpu_d_wr
  (
    .clk                (clk),
    .resetn             (resetn),
    .strb               (cpu_d_req_wr_byte_en),
    .cfg_min_size       (axi_wr_cfg_min_size),
    .addr               (cpu_d_req_wr_addr_strb),
    .size               (cpu_d_wr_size)
  ); 
  
  
    assign cpu_axi_awaddr         = {cpu_d_req_addr[AXI_MSTR_ADDR_WIDTH-1:2],cpu_d_req_wr_addr_strb[1:0]};
    assign cpu_axi_awsize         = {1'b0,cpu_d_wr_size};
    assign cpu_axi_awvalid        = cpu_d_req_valid & cpu_d_req_write;
    assign cpu_axi_wdata          = cpu_d_req_wr_data;
    assign cpu_axi_wdata_p        = cpu_d_req_wr_data_p;
    assign cpu_axi_wlast          = 1'b1;  
    assign cpu_axi_wstrb          = cpu_d_req_wr_byte_en;
    assign cpu_axi_wvalid         = cpu_d_req_valid & cpu_d_req_write;      
    assign cpu_axi_fence_wr_flush = 1'b0; // REVISIT


  MIV_RV32IMC_strb_to_addr
  #(
    .NUM_BYTES          (4)
  )
  u_strb_to_addr_udma_wr
  (
    .clk                (clk),
    .resetn             (resetn),
    .strb               (udma_req_wr_byte_en),
    .cfg_min_size       (axi_wr_cfg_min_size),
    .addr               (udma_req_wr_addr_strb),
    .size               (udma_wr_size)
  );  
  
    assign udma_axi_awaddr         = {udma_req_addr[AXI_MSTR_ADDR_WIDTH-1:2],udma_req_wr_addr_strb[1:0]};
    assign udma_axi_awsize         = {1'b0,udma_wr_size};
    assign udma_axi_awlen          = udma_req_len;
    assign udma_axi_awvalid        = udma_req_valid & udma_req_write;
    assign udma_axi_wdata          = udma_req_wr_data;
    assign udma_axi_wdata_p        = udma_req_wr_data_p;
    assign udma_axi_wlast          = udma_req_wr_data_last;  
    assign udma_axi_wstrb          = udma_req_wr_byte_en;
    assign udma_axi_wvalid         = udma_req_valid & udma_req_write;      
    assign udma_axi_fence_wr_flush = 1'b0; // REVISIT

      
  // write side
  // contains AW, W, and B channels
  
  MIV_RV32IMC_axi_wchan
  //***************************************************************
  // Parameter description
  #(
    .AXI_MSTR_WADDR_WIDTH           (AXI_MSTR_ADDR_WIDTH),             
    .NUM_OS_WRITES                  (NUM_OS_WRITES),  
    .NUM_REQUESTERS                 (NUM_WRITE_REQUESTERS),    
    .LOG2_NUM_OS_WRITES             (LOG2_NUM_OS_WRITES)                 
   )
  u_axi_wchan
  //***************************************************************
  // Signal description
  (
    .resetn                         (resetn),
    .clk                            (clk),
    .aclk_en                        (aclk_en),
    .mstr_w_idle                    ( ),  // open. not currently used
    .opsrv_parity_en                (opsrv_parity_en),
    .cfg_fence_all                  (cfg_fence_all_src),
    .write_response_error           (write_response_error),  
    .cfg_aw_cache                   (cfg_aw_cache),
    .aximstr_awid                   (aximstr_awid),
    .aximstr_awaddr                 (aximstr_awaddr),
    .aximstr_awlen                  (aximstr_awlen),
    .aximstr_awsize                 (aximstr_awsize),
    .aximstr_awburst                (aximstr_awburst),
    .aximstr_awlock                 (aximstr_awlock),
    .aximstr_awcache                (aximstr_awcache),
    .aximstr_awprot                 (aximstr_awprot),
    .aximstr_aw_addr_p              (aximstr_aw_addr_p),
    .aximstr_awready                (aximstr_awready),
    .aximstr_awvalid                (aximstr_awvalid),
    .aximstr_wdata                  (aximstr_wdata),
    .aximstr_wstrb                  (aximstr_wstrb),
    .aximstr_wlast                  (aximstr_wlast),
    .aximstr_wid                    (aximstr_wid),  // not used in AXI4 - same wchan ID output for AXI3 or AXI4 because single fixed ID
    .aximstr_wready                 (aximstr_wready),
    .aximstr_wvalid                 (aximstr_wvalid),
    .aximstr_w_data_p               (aximstr_w_data_p),
    .aximstr_bresp                  (aximstr_bresp),
    .aximstr_bid                    (aximstr_bid),
    .aximstr_bready                 (aximstr_bready),
    .aximstr_bvalid                 (aximstr_bvalid),
    .cpu_axi_awaddr                 (cpu_axi_awaddr),
    .cpu_axi_awsize                 (cpu_axi_awsize),
    .cpu_axi_awready                (cpu_axi_awready),
    .cpu_axi_awvalid                (cpu_axi_awvalid),
    .cpu_axi_wdata                  (cpu_axi_wdata),
    .cpu_axi_wdata_p                (cpu_axi_wdata_p),
    .cpu_axi_wlast                  (cpu_axi_wlast),
    .cpu_axi_wstrb                  (cpu_axi_wstrb),
    .cpu_axi_wready                 (cpu_axi_wready),
    .cpu_axi_wvalid                 (cpu_axi_wvalid),
    .cpu_axi_fence_wr_flush         (cpu_axi_fence_wr_flush),
    .cpu_axi_fence_wr_os            (cpu_axi_fence_wr_os),
    .cpu_axi_war_hzd                (axi_war_hzd_d),
    .udma_axi_awaddr                (udma_axi_awaddr),
    .udma_axi_awlen                 (udma_axi_awlen),
    .udma_axi_awsize                (udma_axi_awsize),
    .udma_axi_awready               (udma_axi_awready),
    .udma_axi_awvalid               (udma_axi_awvalid),
    .udma_axi_wdata                 (udma_axi_wdata),
    .udma_axi_wdata_p               (udma_axi_wdata_p),
    .udma_axi_wlast                 (udma_axi_wlast),
    .udma_axi_wstrb                 (udma_axi_wstrb),
    .udma_axi_wready                (udma_axi_wready),
    .udma_axi_wvalid                (udma_axi_wvalid),
    .udma_axi_fence_wr_flush        (udma_axi_fence_wr_flush),
    .udma_axi_fence_wr_os           (udma_axi_fence_wr_os),
    .udma_axi_war_hzd               (1'b0), // REVISIT add when UDMA implemented
    .os_write_addr_pkd              (os_write_addr_pkd),
    .os_write_valid_pkd             (os_write_valid_pkd)
    
  );
  
  assign cpu_d_wr_resp_err = write_response_error[0];
  
  generate 
  if(l_opsrv_cfg_udma_present) begin : gen_udma_assign  
    assign udma_wr_resp_err  = write_response_error[1];
  end
  else begin : ngen_udma_assign 
    assign udma_wr_resp_err = 1'b0;
  end
  endgenerate

  // manage RAW and WAR hazards if enabled  
  
  always @*
  begin
    integer i;
    for(i=0; i<NUM_OS_WRITES; i=i+1)
    begin
      raw_hzd_i[i] =  ((os_write_addr_pkd[(i*AXI_MSTR_ADDR_WIDTH)+:AXI_MSTR_ADDR_WIDTH] & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000}) == 
                       (cpu_i_axi_araddr & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000})) & 
                       os_write_valid_pkd[i] &
                       cpu_i_axi_arvalid & 
                       cfg_raw_hzd_check;
                       
      raw_hzd_d[i] =  ((os_write_addr_pkd[(i*AXI_MSTR_ADDR_WIDTH)+:AXI_MSTR_ADDR_WIDTH] & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000}) == 
                       (cpu_d_axi_araddr & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000})) & 
                       os_write_valid_pkd[i] &
                       cpu_d_axi_arvalid &
                       cfg_raw_hzd_check;                      
    end
  end
  
  assign axi_raw_hzd_i = |raw_hzd_i;
  assign axi_raw_hzd_d = |raw_hzd_d;
  
  
  
  always @*
  begin
    integer i;
    for(i=0; i<NUM_OS_WRITES; i=i+1)
    begin                       
      war_hzd_d[i] =  ((os_read_addr_pkd[(i*AXI_MSTR_ADDR_WIDTH)+:AXI_MSTR_ADDR_WIDTH] & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000}) == 
                       (cpu_axi_awaddr & {{AXI_MSTR_ADDR_WIDTH-4{1'b1}},4'b0000})) & 
                       os_read_valid_pkd[i] &
                       cpu_axi_awvalid &
                       cfg_war_hzd_check;                       
    end
  end
  
  assign axi_war_hzd_d = |war_hzd_d;
  
  
  
  // indicate to interconnect if outstanding requests for fence completion (hence don't need current request)
  assign trx_os_d_wr = |os_write_valid_pkd[NUM_OS_WRITES-1:0];
  assign trx_os_d_rd = |os_read_cpu_d_valid_pkd[NUM_OS_READS-1:0];
 

endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_interconnect.sv
//
//   Purpose:
//    opsrv subsystem memory interconnect
//    Connects all memories, master interfaces and the CPU core
//    Also manages ordering/fences, contains OPSRV configuration, and the dummy slave
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv_interconnect
//********************************************************************************
// Parameter description

  #(   
    parameter CPU_ADDR_WIDTH        = 32,
    parameter AXI_MSTR_ADDR_WIDTH   = 16,
    parameter APB_MSTR_ADDR_WIDTH   = 16,
    parameter AHB_MSTR_ADDR_WIDTH   = 16,
    parameter UDMA_CTRL_ADDR_WIDTH  = 12, 
    parameter LMEM0_ADDR_WIDTH      = 16,
    parameter LMEM1_ADDR_WIDTH      = 16,
	parameter ECC_ENABLE            = 0,
	parameter l_opsrv_cfg_lmem0_present = 1,
	parameter l_opsrv_cfg_axi_mstr_present = 1,
	parameter l_opsrv_cfg_ahb_mstr_present = 1
   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,
    
    // config/control
    output logic [1:0]                           axi_rd_cfg_min_size,
    output logic [1:0]                           axi_wr_cfg_min_size,
    output logic                                 opsrv_parity_en,
    input wire  logic                            sys_parity_disable, 
    output logic                                 cfg_fence_all_src,
    output logic [3:0]                           cfg_ar_cache,
    output logic [3:0]                           cfg_aw_cache,  
    output logic                                 cfg_raw_hzd_check,
    output logic                                 cfg_war_hzd_check,
     
    output logic                                 lmem0_uncorrectable_ecc_error,
    output logic                                 lmem1_uncorrectable_ecc_error,
    output logic [1:0]                           opsrv_irq,
    
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_axi_mstr_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_axi_mstr_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_apb_mstr_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_apb_mstr_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_ahb_mstr_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_ahb_mstr_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_udma_ctrl_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_udma_ctrl_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_opsrv_cfg_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_opsrv_cfg_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem0_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem0_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem1_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem1_end_addr,            
    
    // CPU interface    
    input wire  logic                            cpu_i_req_valid,
    output      logic                            cpu_i_req_ready, 
    input wire  logic [3:0]                      cpu_i_req_rd_byte_en,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cpu_i_req_addr,
    input wire  logic                            cpu_i_req_addr_p,
    output      logic                            cpu_i_resp_valid,
    input wire  logic                            cpu_i_resp_ready,
    output      logic                            cpu_i_resp_error,
    output      logic [31:0]                     cpu_i_resp_rd_data, 
    output      logic [3:0]                      cpu_i_resp_rd_data_p,
    input wire  logic                            cpu_d_req_valid,
    output      logic                            cpu_d_req_ready, 
    input wire  logic [3:0]                      cpu_d_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_d_req_wr_byte_en,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cpu_d_req_addr,    
    input wire  logic                            cpu_d_req_addr_p,    
    input wire  logic                            cpu_d_req_fence,
    input wire  logic                            cpu_d_req_read,
    input wire  logic                            cpu_d_req_write,
    input wire  logic [31:0]                     cpu_d_req_wr_data,   
    input wire  logic [3:0]                      cpu_d_req_wr_data_p,
    output      logic                            cpu_d_resp_valid,
    input wire  logic                            cpu_d_resp_ready,
    output      logic                            cpu_d_resp_error,
    output      logic [31:0]                     cpu_d_resp_rd_data,  
    output      logic [3:0]                      cpu_d_resp_rd_data_p,
    
    // Debug unit interface
    input wire  logic                            debug_mode,
    output      logic                            debug_trx_os,
    input wire  logic                            debug_sysbus_req_valid,
    output      logic                            debug_sysbus_req_ready, 
    input wire  logic [3:0]                      debug_sysbus_req_rd_byte_en,  
    input wire  logic [3:0]                      debug_sysbus_req_wr_byte_en,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       debug_sysbus_req_addr,  
    input wire  logic [31:0]                     debug_sysbus_req_wr_data,  
    output      logic                            debug_sysbus_resp_valid,
    input wire  logic                            debug_sysbus_resp_ready,
    output      logic                            debug_sysbus_resp_error,
    output      logic [31:0]                     debug_sysbus_resp_rd_data,  
    
    // APB Master interface 
    output      logic                            apb_mstr_i_req_valid,
    input wire  logic                            apb_mstr_i_req_ready, 
    output      logic [3:0]                      apb_mstr_i_req_rd_byte_en,
    output      logic [APB_MSTR_ADDR_WIDTH-1:0]  apb_mstr_i_req_addr,
    output      logic                            apb_mstr_i_req_addr_p,
    input wire  logic                            apb_mstr_i_resp_valid,
    output      logic                            apb_mstr_i_resp_ready,
    input wire  logic                            apb_mstr_i_resp_error,
    input wire  logic [31:0]                     apb_mstr_i_resp_rd_data, 
    input wire  logic [3:0]                      apb_mstr_i_resp_rd_data_p,
    output      logic                            apb_mstr_d_req_valid,
    input wire  logic                            apb_mstr_d_req_ready, 
    output      logic [3:0]                      apb_mstr_d_req_rd_byte_en,  
    output      logic [3:0]                      apb_mstr_d_req_wr_byte_en,
    //output      logic                            apb_mstr_d_req_read,
    //output      logic                            apb_mstr_d_req_write,
    output      logic [APB_MSTR_ADDR_WIDTH-1:0]  apb_mstr_d_req_addr,
    output      logic                            apb_mstr_d_req_addr_p,
    output      logic [31:0]                     apb_mstr_d_req_wr_data,
    output      logic [3:0]                      apb_mstr_d_req_wr_data_p,
    input wire  logic                            apb_mstr_d_resp_valid,
    output      logic                            apb_mstr_d_resp_ready,
    input wire  logic                            apb_mstr_d_resp_error,
    input wire  logic [31:0]                     apb_mstr_d_resp_rd_data,   
    input wire  logic [3:0]                      apb_mstr_d_resp_rd_data_p,     
    input wire  logic                            apb_mstr_trx_os_d_rd,
    input wire  logic                            apb_mstr_trx_os_d_wr, 
    
    // Local memory 0 interface
    output      logic                            lmem0_i_req_valid,
    input wire  logic                            lmem0_i_req_ready, 
    output      logic [3:0]                      lmem0_i_req_rd_byte_en, 
    output      logic [LMEM0_ADDR_WIDTH-1:0]     lmem0_i_req_addr,
    output      logic                            lmem0_i_req_addr_p,
    input wire  logic                            lmem0_i_resp_valid,
    output      logic                            lmem0_i_resp_ready,
    input wire  logic                            lmem0_i_resp_error,
    input wire  logic [31:0]                     lmem0_i_resp_rd_data, 
    input wire  logic [3:0]                      lmem0_i_resp_rd_data_p, 
    output      logic                            lmem0_d_req_valid,
    input wire  logic                            lmem0_d_req_ready, 
    output      logic [3:0]                      lmem0_d_req_rd_byte_en,   
    output      logic [3:0]                      lmem0_d_req_wr_byte_en,
    output      logic                            lmem0_d_req_read,
    output      logic                            lmem0_d_req_write,
    output      logic [LMEM0_ADDR_WIDTH-1:0]     lmem0_d_req_addr,
    output      logic                            lmem0_d_req_addr_p,
    output      logic [31:0]                     lmem0_d_req_wr_data,
    output      logic [3:0]                      lmem0_d_req_wr_data_p,
    input wire  logic                            lmem0_d_resp_valid,
    output      logic                            lmem0_d_resp_ready,
    input wire  logic                            lmem0_d_resp_error,
    input wire  logic [31:0]                     lmem0_d_resp_rd_data, 
    input wire  logic [3:0]                      lmem0_d_resp_rd_data_p,    
    input wire  logic                            lmem0_trx_os_d_rd,
    input wire  logic                            lmem0_trx_os_d_wr, 
    input wire  logic                            lmem0_ecc_err_correctable,  
    input wire  logic                            lmem0_ecc_err_uncorrectable,
    
    // Local memory 1 interface
    output      logic                            lmem1_i_req_valid,
    input wire  logic                            lmem1_i_req_ready, 
    output      logic [3:0]                      lmem1_i_req_rd_byte_en, 
    output      logic [LMEM1_ADDR_WIDTH-1:0]     lmem1_i_req_addr,
    output      logic                            lmem1_i_req_addr_p,
    input wire  logic                            lmem1_i_resp_valid,
    output      logic                            lmem1_i_resp_ready,
    input wire  logic                            lmem1_i_resp_error,
    input wire  logic [31:0]                     lmem1_i_resp_rd_data, 
    input wire  logic [3:0]                      lmem1_i_resp_rd_data_p, 
    output      logic                            lmem1_d_req_valid,
    input wire  logic                            lmem1_d_req_ready, 
    output      logic [3:0]                      lmem1_d_req_rd_byte_en,   
    output      logic [3:0]                      lmem1_d_req_wr_byte_en,
    output      logic                            lmem1_d_req_read,
    output      logic                            lmem1_d_req_write,
    output      logic [LMEM1_ADDR_WIDTH-1:0]     lmem1_d_req_addr,
    output      logic                            lmem1_d_req_addr_p,
    output      logic [31:0]                     lmem1_d_req_wr_data,
    output      logic [3:0]                      lmem1_d_req_wr_data_p,
    input wire  logic                            lmem1_d_resp_valid,
    output      logic                            lmem1_d_resp_ready,
    input wire  logic                            lmem1_d_resp_error,
    input wire  logic [31:0]                     lmem1_d_resp_rd_data, 
    input wire  logic [3:0]                      lmem1_d_resp_rd_data_p,     
    input wire  logic                            lmem1_trx_os_d_rd,
    input wire  logic                            lmem1_trx_os_d_wr,
    input wire  logic                            lmem1_ecc_err_correctable,  
    input wire  logic                            lmem1_ecc_err_uncorrectable,
    
    // AXI Master interface 
    output      logic                            axi_mstr_i_req_valid,
    input wire  logic                            axi_mstr_i_req_ready, 
    output      logic [3:0]                      axi_mstr_i_req_rd_byte_en,  
    output      logic [AXI_MSTR_ADDR_WIDTH-1:0]  axi_mstr_i_req_addr,
    output      logic                            axi_mstr_i_req_addr_p,
    input wire  logic                            axi_mstr_i_resp_valid,
    output      logic                            axi_mstr_i_resp_ready,
    input wire  logic                            axi_mstr_i_resp_error,
    input wire  logic [31:0]                     axi_mstr_i_resp_rd_data, 
    input wire  logic [3:0]                      axi_mstr_i_resp_rd_data_p, 
    output      logic                            axi_mstr_d_req_valid,
    input wire  logic                            axi_mstr_d_req_ready, 
    output      logic [3:0]                      axi_mstr_d_req_rd_byte_en,  
    output      logic [3:0]                      axi_mstr_d_req_wr_byte_en,
    output      logic                            axi_mstr_d_req_read,
    output      logic                            axi_mstr_d_req_write,
    output      logic [AXI_MSTR_ADDR_WIDTH-1:0]  axi_mstr_d_req_addr,
    output      logic                            axi_mstr_d_req_addr_p,
    output      logic [31:0]                     axi_mstr_d_req_wr_data,
    output      logic [3:0]                      axi_mstr_d_req_wr_data_p,
    input wire  logic                            axi_mstr_d_resp_valid,
    output      logic                            axi_mstr_d_resp_ready,
    input wire  logic                            axi_mstr_d_resp_rd_error,
    input wire  logic [31:0]                     axi_mstr_d_resp_rd_data,  
    input wire  logic [3:0]                      axi_mstr_d_resp_rd_data_p,
    input wire  logic                            axi_mstr_d_wr_resp_err,   
    input wire  logic                            axi_mstr_trx_os_d_rd,
    input wire  logic                            axi_mstr_trx_os_d_wr, 
    
    // AHB-Lite Master interface 
    output      logic                            ahb_mstr_i_req_valid,
    input wire  logic                            ahb_mstr_i_req_ready, 
    output      logic [3:0]                      ahb_mstr_i_req_rd_byte_en,  
    output      logic [AHB_MSTR_ADDR_WIDTH-1:0]  ahb_mstr_i_req_addr,
    output      logic                            ahb_mstr_i_req_addr_p,
    input wire  logic                            ahb_mstr_i_resp_valid,
    output      logic                            ahb_mstr_i_resp_ready,
    input wire  logic                            ahb_mstr_i_resp_error,
    input wire  logic [31:0]                     ahb_mstr_i_resp_rd_data, 
    input wire  logic [3:0]                      ahb_mstr_i_resp_rd_data_p, 
    output      logic                            ahb_mstr_d_req_valid,
    input wire  logic                            ahb_mstr_d_req_ready, 
    output      logic [3:0]                      ahb_mstr_d_req_rd_byte_en,  
    output      logic [3:0]                      ahb_mstr_d_req_wr_byte_en,
    output      logic                            ahb_mstr_d_req_read,
    output      logic                            ahb_mstr_d_req_write,
    output      logic [AHB_MSTR_ADDR_WIDTH-1:0]  ahb_mstr_d_req_addr,
    output      logic                            ahb_mstr_d_req_addr_p,
    output      logic [31:0]                     ahb_mstr_d_req_wr_data,
    output      logic [3:0]                      ahb_mstr_d_req_wr_data_p,
    input wire  logic                            ahb_mstr_d_resp_valid,
    output      logic                            ahb_mstr_d_resp_ready,
    input wire  logic                            ahb_mstr_d_resp_rd_error,
    input wire  logic [31:0]                     ahb_mstr_d_resp_rd_data,  
    input wire  logic [3:0]                      ahb_mstr_d_resp_rd_data_p,   
    input wire  logic                            ahb_mstr_trx_os_d_rd,
    input wire  logic                            ahb_mstr_trx_os_d_wr,  
       
    // uDMA control interface 
    output      logic                            udma_ctrl_d_req_valid,
    input wire  logic                            udma_ctrl_d_req_ready, 
    output      logic [3:0]                      udma_ctrl_d_req_rd_byte_en,  
    output      logic [3:0]                      udma_ctrl_d_req_wr_byte_en,
    output      logic                            udma_ctrl_d_req_read,
    output      logic                            udma_ctrl_d_req_write,
    output      logic [UDMA_CTRL_ADDR_WIDTH-1:0] udma_ctrl_d_req_addr,
    output      logic                            udma_ctrl_d_req_addr_p,
    output      logic [31:0]                     udma_ctrl_d_req_wr_data,
    output      logic [3:0]                      udma_ctrl_d_req_wr_data_p,
    input wire  logic                            udma_ctrl_d_resp_valid,
    output      logic                            udma_ctrl_d_resp_ready,
    input wire  logic                            udma_ctrl_d_resp_error,
    input wire  logic [31:0]                     udma_ctrl_d_resp_rd_data,
    input wire  logic [3:0]                      udma_ctrl_d_resp_rd_data_p,     
    input wire  logic                            udma_ctrl_irq,
    input wire  logic                            udma_trx_os_d_rd,
    input wire  logic                            udma_trx_os_d_wr,
    
    output wire logic                            core_soft_reset, //core_soft_reset module output
    output wire logic                            core_soft_irq,    //core_soft_irq module output
    
    input wire logic                             gpr_ded_soft_reset //input to connect gpr ded signal from sumbicron to the interconnect
  );

//********************************************************************************
// Declarations

  typedef enum logic [1:0] {opsrv_mem_req_rd,
                            opsrv_mem_req_wr,
                            opsrv_mem_req_fence,
                            opsrv_mem_req_invalid} t_opsrv_mem_req;

// localparams
  
  localparam MAX_OS_I_TRX = 2;
  localparam LOG2_MAX_OS_I_TRX = 1;
  localparam MAX_OS_D_TRX = 2;
  localparam LOG2_MAX_OS_D_TRX = 1;


// Internal nets

  logic                                        cpu_i_req_accepted; 
  logic                                        cpu_i_resp_accepted;

  logic                                        cpu_i_req_is_apb_mstr;
  logic                                        cpu_i_req_is_ahb_mstr;
  logic                                        cpu_i_req_is_axi_mstr;
  logic                                        cpu_i_req_is_lmem0;
  logic                                        cpu_i_req_is_lmem1;
  logic                                        cpu_i_req_is_dummy_slave;
  
  logic                                        cpu_i_resp_is_apb_mstr;
  logic                                        cpu_i_resp_is_ahb_mstr;
  logic                                        cpu_i_resp_is_axi_mstr;
  logic                                        cpu_i_resp_is_lmem0;
  logic                                        cpu_i_resp_is_lmem1;
  logic                                        cpu_i_resp_is_dummy_slave;
  
  logic                                        cpu_i_req_addr_parity_error;
  logic                                        cpu_d_req_valid_mux;
  logic [3:0]                                  cpu_d_req_rd_byte_en_mux;  
  logic [3:0]                                  cpu_d_req_wr_byte_en_mux;
  logic                                        cpu_d_req_read_mux;  
  logic                                        cpu_d_req_write_mux;
  logic [CPU_ADDR_WIDTH-1:0]                   cpu_d_req_addr_mux;    
  logic                                        cpu_d_req_addr_p_mux;    
  logic                                        cpu_d_req_fence_mux;
  logic [31:0]                                 cpu_d_req_wr_data_mux;   
  logic [3:0]                                  cpu_d_req_wr_data_p_mux;
  logic                                        cpu_d_resp_ready_mux;  
  
  logic                                        cpu_d_req_ready_sig;
  logic                                        cpu_d_resp_valid_sig;
  logic                                        cpu_d_resp_error_sig;
  logic [31:0]                                 cpu_d_resp_rd_data_sig;  
  logic [3:0]                                  cpu_d_resp_rd_data_p_sig;
  logic                                        cpu_d_req_accepted; 
  logic                                        cpu_d_resp_accepted;
   
  logic                                        cpu_d_req_is_apb_mstr;
  logic                                        cpu_d_req_is_ahb_mstr;
  logic                                        cpu_d_req_is_axi_mstr;
  logic                                        cpu_d_req_is_lmem0;
  logic                                        cpu_d_req_is_lmem1;
  logic                                        cpu_d_req_is_udma_ctrl;
  logic                                        cpu_d_req_is_opsrv_cfg;
  logic                                        cpu_d_req_is_dummy_slave;
  logic                                        cpu_d_req_is_fence;
  
  logic                                        cpu_d_req_addr_parity_error;
  
  logic                                        cpu_d_resp_is_apb_mstr;
  logic                                        cpu_d_resp_is_ahb_mstr;
  logic                                        cpu_d_resp_is_axi_mstr;
  logic                                        cpu_d_resp_is_lmem0;
  logic                                        cpu_d_resp_is_lmem1;
  logic                                        cpu_d_resp_is_udma_ctrl;
  logic                                        cpu_d_resp_is_opsrv_cfg;
  logic                                        cpu_d_resp_is_dummy_slave;
  logic                                        cpu_d_resp_is_fence;

  logic                                        dummy_slave_i_req_valid;
  logic                                        dummy_slave_i_req_ready; 
  logic [3:0]                                  dummy_slave_i_req_rd_byte_en;
  logic [CPU_ADDR_WIDTH-1:0]                   dummy_slave_i_req_addr;
  logic                                        dummy_slave_i_req_addr_p;
  logic                                        dummy_slave_i_resp_valid;
  logic                                        dummy_slave_i_resp_ready;
  logic                                        dummy_slave_i_resp_error;
  logic [31:0]                                 dummy_slave_i_resp_rd_data;
  logic [3:0]                                  dummy_slave_i_resp_rd_data_p;
   
  logic                                        dummy_slave_d_req_valid;
  logic                                        dummy_slave_d_req_ready; 
  logic [3:0]                                  dummy_slave_d_req_rd_byte_en;  
  logic [3:0]                                  dummy_slave_d_req_wr_byte_en;
  logic [CPU_ADDR_WIDTH-1:0]                   dummy_slave_d_req_addr;
  logic                                        dummy_slave_d_req_addr_p;
  logic [31:0]                                 dummy_slave_d_req_wr_data;
  logic [3:0]                                  dummy_slave_d_req_wr_data_p;
  logic                                        dummy_slave_d_resp_valid;
  logic                                        dummy_slave_d_resp_ready;
  logic                                        dummy_slave_d_resp_error;
  logic [31:0]                                 dummy_slave_d_resp_rd_data;
  logic [3:0]                                  dummy_slave_d_resp_rd_data_p;
  
  logic                                        fence_d_req_valid;
  logic                                        fence_d_req_ready; 
  logic [3:0]                                  fence_d_req_rd_byte_en;  
  logic [3:0]                                  fence_d_req_wr_byte_en;
  logic [CPU_ADDR_WIDTH-1:0]                   fence_d_req_addr;
  logic                                        fence_d_req_addr_p;
  logic [31:0]                                 fence_d_req_wr_data;
  logic [3:0]                                  fence_d_req_wr_data_p;
  logic                                        fence_d_resp_ready;
  logic [31:0]                                 fence_d_resp_rd_data;
  logic [3:0]                                  fence_d_resp_rd_data_p;
  
  logic                                        d_trx_os;
  logic                                        write_op_d_resp_valid;
  logic                                        fence_op_d_resp_valid;
  logic                                        fence_op_d_resp_error;  

  logic                                        opsrv_cfg_d_resp_valid;
  logic                                        opsrv_cfg_d_resp_ready;
  logic                                        opsrv_cfg_d_resp_error;
  logic [31:0]                                 opsrv_cfg_d_resp_rd_data; 
  logic [3:0]                                  opsrv_cfg_d_resp_rd_data_p;
  logic                                        opsrv_cfg_d_req_valid;
  logic                                        opsrv_cfg_d_req_ready; 
  logic [3:0]                                  opsrv_cfg_d_req_rd_byte_en;  
  logic [3:0]                                  opsrv_cfg_d_req_wr_byte_en;
  logic                                        opsrv_cfg_d_req_read;
  logic                                        opsrv_cfg_d_req_write;
  logic [31:0]                                 opsrv_cfg_d_req_wr_data;
  logic [3:0]                                  opsrv_cfg_d_req_wr_data_p;
  logic [l_opsrv_cfg_opsrv_cfg_addr_width-1:0] opsrv_cfg_d_req_addr;
  logic                                        opsrv_cfg_d_req_addr_p;
                                              
  logic                                        apb_mstr_i_os_other;
  logic                                        lmem0_i_os_other;
  logic                                        lmem1_i_os_other;
  logic                                        dummy_slave_i_os_other;
  logic                                        i_trx_os_buff_ready;
  logic [5:0]                                  i_trx_req;
  logic [5:0]                                  i_trx_resp;
  logic                                        i_trx_resp_valid;
  logic [5:0]                                  req_os_i_src;
  logic [(MAX_OS_I_TRX*6)-1:0]                 i_trx_resp_pkd;
  logic [MAX_OS_I_TRX-1:0]                     i_trx_resp_valid_pkd;
  logic                                        req_os_i_apb_mstr;
  logic                                        req_os_i_ahb_mstr;
  logic                                        req_os_i_axi_mstr;
  logic                                        req_os_i_lmem0;
  logic                                        req_os_i_lmem1;
  logic                                        req_os_i_dummy_slave;
                                              
  logic                                        apb_mstr_d_os_other;
  logic                                        opsrv_cfg_d_os_other;
  logic                                        lmem0_d_os_other;
  logic                                        lmem1_d_os_other;
  logic                                        udma_ctrl_d_os_other;
  logic                                        dummy_slave_d_os_other;
  logic                                        fence_d_os_other;
  logic                                        d_trx_os_buff_ready;
  logic [10:0]                                 d_trx_req;
  logic [10:0]                                 d_trx_resp;
  logic                                        d_trx_resp_valid;
  logic [8:0]                                  req_os_d_src;
  logic [(MAX_OS_D_TRX*11)-1:0]                d_trx_resp_pkd;
  logic [MAX_OS_D_TRX-1:0]                     d_trx_resp_valid_pkd;
  logic                                        req_os_d_apb_mstr;
  logic                                        req_os_d_ahb_mstr;
  logic                                        req_os_d_axi_mstr;
  logic                                        req_os_d_lmem0;
  logic                                        req_os_d_lmem1;
  logic                                        req_os_d_dummy_slave;
  logic                                        req_os_d_fence;
  logic                                        req_os_d_opsrv_cfg;
  logic                                        req_os_d_udma_ctrl;
  t_opsrv_mem_req                              cpu_d_req_type; 
  t_opsrv_mem_req                              cpu_d_resp_type;  
                                              
  logic                                        cpu_d_resp_valid_rd;  
  logic                                        cpu_d_resp_valid_wr; 
  logic                                        cpu_d_resp_valid_fence;         
  logic                                        cpu_d_resp_error_rd;  
  logic                                        cpu_d_resp_error_wr; 
  logic                                        cpu_d_resp_error_fence;
                                              
  logic                                        opsrv_parity_en_reg;
                                              


//********************************************************************************
// Main code
//********************************************************************************

  // address decoder
  // Minimum region size is 4K, this allows less bits to be used in the address compare and therfore be faster/smaller at expense of address space for 
  // small regions (eg config regs)
  

  
  // All responses to the CPU must be returned at least one cycle after the request
  // Keep a list of the request destination to route the response appropriately (in order)
  // REVISIT Could encode the response destination to save bits rather than being onehot
  
  // CPU I-side
  // Read only  
  
  // Need to regenerate parity for all address buses as width varies. if it is already incorrect make generated parity incorrect  
  assign cpu_i_req_addr_parity_error = (cpu_i_req_addr_p != ^cpu_i_req_addr) & opsrv_parity_en_reg;
  
  assign i_trx_req  = {cpu_i_req_is_apb_mstr,
                       cpu_i_req_is_ahb_mstr,
                       cpu_i_req_is_axi_mstr,
                       cpu_i_req_is_lmem0,
                       cpu_i_req_is_lmem1,
                       cpu_i_req_is_dummy_slave};
  
  
  MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         (6), 
    .BUFF_SIZE          (MAX_OS_I_TRX),
    .PTR_SIZE           (LOG2_MAX_OS_I_TRX)
  )
  u_i_trx_os_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (cpu_i_req_accepted),
    .ready_in           (i_trx_os_buff_ready),
    .data_in            (i_trx_req),
    .data_out           (i_trx_resp),     
    .valid_out          (i_trx_resp_valid),     
    .ready_out          (cpu_i_resp_accepted),
    .data_out_pkd       (i_trx_resp_pkd), 
    .valid_out_pkd      (i_trx_resp_valid_pkd),
    .nearly_full        ()
  );
  
  assign {cpu_i_resp_is_apb_mstr,
          cpu_i_resp_is_ahb_mstr,
          cpu_i_resp_is_axi_mstr,
          cpu_i_resp_is_lmem0,
          cpu_i_resp_is_lmem1,
          cpu_i_resp_is_dummy_slave} = i_trx_resp;
          
  // because the RAM and AHB master do not buffer responses, need to prevent the request unless it can be guaranteed the response will be
  // returned directly. This may not be the case if there is anything else ahead outstanding that is not coming from the same source.
  
  always @*
  begin :extract_os_i_loop
    integer i;
    
    req_os_i_src = {6{1'b0}};
    for(i=0; i<MAX_OS_I_TRX; i=i+1)
    begin
      req_os_i_src = req_os_i_src | ({6{i_trx_resp_valid_pkd[i]}} & i_trx_resp_pkd[(i*6)+:6]);
    end
  end
  
  assign {req_os_i_apb_mstr,
          req_os_i_ahb_mstr,
          req_os_i_axi_mstr,
          req_os_i_lmem0,
          req_os_i_lmem1,
          req_os_i_dummy_slave} = req_os_i_src;
  
  assign cpu_i_req_accepted  = cpu_i_req_valid & cpu_i_req_ready;
  assign cpu_i_resp_accepted = cpu_i_resp_valid & cpu_i_resp_ready; 
  
  
  assign cpu_i_req_is_apb_mstr      = ((cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] >= cfg_apb_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                       (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] <= cfg_apb_mstr_end_addr[CPU_ADDR_WIDTH-1:12])) |
                                       (cpu_i_req_addr[CPU_ADDR_WIDTH-1:3] == l_mtime_addr_base[CPU_ADDR_WIDTH-1:3]) |  
                                       (cpu_i_req_addr[CPU_ADDR_WIDTH-1:3] == l_mtimecmp_addr_base[CPU_ADDR_WIDTH-1:3]) |
                                       (cpu_i_req_addr[CPU_ADDR_WIDTH-1:3] == l_mtime_prescaler_addr[CPU_ADDR_WIDTH-1:3]) ;   
  assign apb_mstr_i_os_other        = req_os_i_ahb_mstr | 
                                      req_os_i_axi_mstr |
                                      req_os_i_lmem0 |
                                      req_os_i_lmem1 |
                                      req_os_i_dummy_slave;                                                           
  assign apb_mstr_i_req_valid       = cpu_i_req_is_apb_mstr & cpu_i_req_valid & i_trx_os_buff_ready & ~apb_mstr_i_os_other;
  assign apb_mstr_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
  assign apb_mstr_i_req_addr        = cpu_i_req_addr[APB_MSTR_ADDR_WIDTH-1:0];
  assign apb_mstr_i_req_addr_p      = ((^cpu_i_req_addr[APB_MSTR_ADDR_WIDTH-1:0]) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;
  assign apb_mstr_i_resp_ready      = cpu_i_resp_is_apb_mstr & cpu_i_resp_ready;
  
                                                            
  
  generate
  if(l_opsrv_cfg_ahb_mstr_present) begin: gen_ahb_i_decode
    assign cpu_i_req_is_ahb_mstr    = (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] >= cfg_ahb_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                    (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] <= cfg_ahb_mstr_end_addr[CPU_ADDR_WIDTH-1:12]);  
    // ahb buffers responses, so no need to block for others outstanding                                                      
    assign ahb_mstr_i_req_valid       = cpu_i_req_is_ahb_mstr & cpu_i_req_valid & i_trx_os_buff_ready;
    assign ahb_mstr_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
    assign ahb_mstr_i_req_addr        = cpu_i_req_addr[AHB_MSTR_ADDR_WIDTH-1:0];
    assign ahb_mstr_i_req_addr_p      = ((^cpu_i_req_addr[AHB_MSTR_ADDR_WIDTH-1:0]) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;
    assign ahb_mstr_i_resp_ready      = cpu_i_resp_is_ahb_mstr & cpu_i_resp_ready;                                  
                                    
  end
  else begin : ngen_ahb_i_decode
    assign cpu_i_req_is_ahb_mstr      = 1'b0;    
    assign ahb_mstr_i_req_valid       = 1'b0;
    assign ahb_mstr_i_req_rd_byte_en  = {4{1'b0}};
    assign ahb_mstr_i_req_addr        = {AHB_MSTR_ADDR_WIDTH{1'b0}};
    assign ahb_mstr_i_req_addr_p      = 1'b0;
    assign ahb_mstr_i_resp_ready      = 1'b0;
  end   
  endgenerate
  
  generate
  if(l_opsrv_cfg_axi_mstr_present) begin: gen_axi_i_decode
    assign cpu_i_req_is_axi_mstr    = (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] >= cfg_axi_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                      (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] <= cfg_axi_mstr_end_addr[CPU_ADDR_WIDTH-1:12]); 
    // axi buffers responses, so no need to block for others outstanding                                                                                                            
    assign axi_mstr_i_req_valid       = cpu_i_req_is_axi_mstr & cpu_i_req_valid & i_trx_os_buff_ready;
    assign axi_mstr_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
    assign axi_mstr_i_req_addr        = cpu_i_req_addr[AXI_MSTR_ADDR_WIDTH-1:0];
    assign axi_mstr_i_req_addr_p      = ((^cpu_i_req_addr[AXI_MSTR_ADDR_WIDTH-1:0]) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;
    assign axi_mstr_i_resp_ready      = cpu_i_resp_is_axi_mstr & cpu_i_resp_ready;                                        
  end
  else begin : ngen_axi_i_decode
    assign cpu_i_req_is_axi_mstr    = 1'b0;  
    assign axi_mstr_i_req_valid       = 1'b0;
    assign axi_mstr_i_req_rd_byte_en  = {4{1'b0}};
    assign axi_mstr_i_req_addr        = {AXI_MSTR_ADDR_WIDTH{1'b0}};
    assign axi_mstr_i_req_addr_p      = 1'b0;
    assign axi_mstr_i_resp_ready      = 1'b0;
  end   
  endgenerate
  
  generate
  if(l_opsrv_cfg_lmem0_present) begin: gen_lmem0_i_decode
    assign cpu_i_req_is_lmem0      = (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] >= cfg_lmem0_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                    (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] <= cfg_lmem0_end_addr[CPU_ADDR_WIDTH-1:12]);  
    assign lmem0_i_os_other        = req_os_i_apb_mstr | 
                                      req_os_i_ahb_mstr |
                                      req_os_i_axi_mstr |
                                      req_os_i_lmem1 |
                                      req_os_i_dummy_slave;                                                                                                         
    assign lmem0_i_req_valid       = cpu_i_req_is_lmem0 & cpu_i_req_valid & i_trx_os_buff_ready & ~lmem0_i_os_other;
    assign lmem0_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
    assign lmem0_i_req_addr        = cpu_i_req_addr[LMEM0_ADDR_WIDTH-1:0];
    assign lmem0_i_req_addr_p      = ((^cpu_i_req_addr[LMEM0_ADDR_WIDTH-1:0]) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;
    assign lmem0_i_resp_ready      = cpu_i_resp_is_lmem0 & cpu_i_resp_ready;                                    
  end
  else begin : ngen_lmem0_i_decode
    assign cpu_i_req_is_lmem0      = 1'b0; 
    assign lmem0_i_os_other        = 1'b0;
    assign lmem0_i_req_valid       = 1'b0;
    assign lmem0_i_req_rd_byte_en  = {4{1'b0}};
    assign lmem0_i_req_addr        = {LMEM0_ADDR_WIDTH{1'b0}};
    assign lmem0_i_req_addr_p      = 1'b0;
    assign lmem0_i_resp_ready      = 1'b0;
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_lmem1_present) begin: gen_lmem1_i_decode
    assign cpu_i_req_is_lmem1      = (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] >= cfg_lmem1_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                    (cpu_i_req_addr[CPU_ADDR_WIDTH-1:12] <= cfg_lmem1_end_addr[CPU_ADDR_WIDTH-1:12]);    
    assign lmem1_i_os_other        = req_os_i_apb_mstr | 
                                      req_os_i_ahb_mstr |
                                      req_os_i_axi_mstr |
                                      req_os_i_lmem0 |
                                      req_os_i_dummy_slave;                                                                                                           
    assign lmem1_i_req_valid       = cpu_i_req_is_lmem1 & cpu_i_req_valid & i_trx_os_buff_ready & ~lmem1_i_os_other;
    assign lmem1_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
    assign lmem1_i_req_addr        = cpu_i_req_addr[LMEM1_ADDR_WIDTH-1:0];
    assign lmem1_i_req_addr_p      = ((^cpu_i_req_addr[LMEM1_ADDR_WIDTH-1:0]) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;    
    assign lmem1_i_resp_ready      = cpu_i_resp_is_lmem1 & cpu_i_resp_ready;                                
  end
  else begin : ngen_lmem1_id_ecode
    assign cpu_i_req_is_lmem1      = 1'b0; 
    assign lmem1_i_os_other        = 1'b0;
    assign lmem1_i_req_valid       = 1'b0;
    assign lmem1_i_req_rd_byte_en  = {4{1'b0}};
    assign lmem1_i_req_addr        = {LMEM1_ADDR_WIDTH{1'b0}};
    assign lmem1_i_req_addr_p      = 1'b0;
    assign lmem1_i_resp_ready      = 1'b0;
  end   
  endgenerate  
  
  
  // dummy slave cleans up any read request to undefined address space and returns an error to the cpu
  
  assign cpu_i_req_is_dummy_slave      = !cpu_i_req_is_apb_mstr  &
                                         !cpu_i_req_is_ahb_mstr  &
                                         !cpu_i_req_is_axi_mstr  &
                                         !cpu_i_req_is_lmem0     &
                                         !cpu_i_req_is_lmem1;                                 
  assign dummy_slave_i_os_other        = req_os_i_apb_mstr | 
                                         req_os_i_ahb_mstr |
                                         req_os_i_axi_mstr |
                                         req_os_i_lmem0 | 
                                         req_os_i_lmem1;                                
  assign dummy_slave_i_req_valid       = cpu_i_req_is_dummy_slave & cpu_i_req_valid & i_trx_os_buff_ready & ~dummy_slave_i_os_other;
  assign dummy_slave_i_req_rd_byte_en  = cpu_i_req_rd_byte_en;
  assign dummy_slave_i_req_addr        = cpu_i_req_addr;
  assign dummy_slave_i_req_addr_p      = ((^cpu_i_req_addr) ^ cpu_i_req_addr_parity_error) & opsrv_parity_en_reg;
  assign dummy_slave_i_resp_ready      = cpu_i_resp_is_dummy_slave & cpu_i_resp_ready;                                       

  
    // response mux
  
  assign cpu_i_req_ready      = ((cpu_i_req_is_apb_mstr    & apb_mstr_i_req_ready) |
                                 (cpu_i_req_is_ahb_mstr    & ahb_mstr_i_req_ready) |
                                 (cpu_i_req_is_axi_mstr    & axi_mstr_i_req_ready) |
                                 (cpu_i_req_is_lmem0       & lmem0_i_req_ready) |
                                 (cpu_i_req_is_lmem1       & lmem1_i_req_ready) |
                                 (cpu_i_req_is_dummy_slave & dummy_slave_i_req_ready)) & i_trx_os_buff_ready;
  
  assign cpu_i_resp_valid     = (cpu_i_resp_is_apb_mstr    & apb_mstr_i_resp_valid) |
                                (cpu_i_resp_is_ahb_mstr    & ahb_mstr_i_resp_valid) |
                                (cpu_i_resp_is_axi_mstr    & axi_mstr_i_resp_valid) |
                                (cpu_i_resp_is_lmem0       & lmem0_i_resp_valid) |
                                (cpu_i_resp_is_lmem1       & lmem1_i_resp_valid) |
                                (cpu_i_resp_is_dummy_slave & dummy_slave_i_resp_valid);
  
  assign cpu_i_resp_error     = (cpu_i_resp_is_apb_mstr    & apb_mstr_i_resp_error) |
                                (cpu_i_resp_is_ahb_mstr    & ahb_mstr_i_resp_error) |
                                (cpu_i_resp_is_axi_mstr    & axi_mstr_i_resp_error) |
                                (cpu_i_resp_is_lmem0       & lmem0_i_resp_error) |
                                (cpu_i_resp_is_lmem1       & lmem1_i_resp_error) |
                                (cpu_i_resp_is_dummy_slave & dummy_slave_i_resp_error);
  
  assign cpu_i_resp_rd_data   = ({32{cpu_i_resp_is_apb_mstr}}    & apb_mstr_i_resp_rd_data) |
                                ({32{cpu_i_resp_is_ahb_mstr}}    & ahb_mstr_i_resp_rd_data) |
                                ({32{cpu_i_resp_is_axi_mstr}}    & axi_mstr_i_resp_rd_data) |
                                ({32{cpu_i_resp_is_lmem0}}       & lmem0_i_resp_rd_data) |
                                ({32{cpu_i_resp_is_lmem1}}       & lmem1_i_resp_rd_data) |
                                ({32{cpu_i_resp_is_dummy_slave}} & dummy_slave_i_resp_rd_data);
                                

  assign cpu_i_resp_rd_data_p = (({4{cpu_i_resp_is_apb_mstr}}    & apb_mstr_i_resp_rd_data_p) |
                                 ({4{cpu_i_resp_is_ahb_mstr}}    & ahb_mstr_i_resp_rd_data_p) |
                                 ({4{cpu_i_resp_is_axi_mstr}}    & axi_mstr_i_resp_rd_data_p) |
                                 ({4{cpu_i_resp_is_lmem0}}       & lmem0_i_resp_rd_data_p) |
                                 ({4{cpu_i_resp_is_lmem1}}       & lmem1_i_resp_rd_data_p) |
                                 ({4{cpu_i_resp_is_dummy_slave}} & dummy_slave_i_resp_rd_data_p) & {4{opsrv_parity_en_reg}});                               
  
  // CPU D-side
  // Read/write     
  
  // Mux in debug read/write paths to d-side.
  // Do not need to track source and destination, since debug unit and cpu requests are mutually exclusive 
  // CPU requests cannot be made in debug mode, and debug requests cannot be made when not in debug mode. No 
  // outstanding requests should be in flight when debug mode changes.
  // Limit number of outstanding debug requests to 1 to ensure no re-ordering issues until debug spec can support abstract fence commands

  
  assign cpu_d_req_valid_mux       =  debug_mode ? (debug_sysbus_req_valid & ~(|d_trx_resp_valid_pkd)) : cpu_d_req_valid;
  assign cpu_d_req_rd_byte_en_mux  =  debug_mode ? debug_sysbus_req_rd_byte_en                         : cpu_d_req_rd_byte_en;  
  assign cpu_d_req_wr_byte_en_mux  =  debug_mode ? debug_sysbus_req_wr_byte_en                         : cpu_d_req_wr_byte_en;
  assign cpu_d_req_read_mux        =  debug_mode ? |debug_sysbus_req_rd_byte_en                        : cpu_d_req_read;
  assign cpu_d_req_write_mux       =  debug_mode ? |debug_sysbus_req_wr_byte_en                        : cpu_d_req_write;
  assign cpu_d_req_addr_mux        =  debug_mode ? debug_sysbus_req_addr                               : cpu_d_req_addr;    
  assign cpu_d_req_addr_p_mux      =  debug_mode ? ^debug_sysbus_req_addr                              : cpu_d_req_addr_p;    
  assign cpu_d_req_fence_mux       =  debug_mode ? 1'b0                                                : cpu_d_req_fence;
  assign cpu_d_req_wr_data_mux     =  debug_mode ? debug_sysbus_req_wr_data                            : cpu_d_req_wr_data;   
  assign cpu_d_req_wr_data_p_mux   =  debug_mode ? {(^debug_sysbus_req_wr_data[31:24]),                           
                                                    (^debug_sysbus_req_wr_data[23:16]),
                                                    (^debug_sysbus_req_wr_data[15:8]),
                                                    (^debug_sysbus_req_wr_data[7:0])}                  : cpu_d_req_wr_data_p;
  assign cpu_d_resp_ready_mux      =  debug_mode ? debug_sysbus_resp_ready                             : cpu_d_resp_ready;
  
  
  
    // Need to regenerate parity for all address buses as width varies. if it is already incorrect make generated parity incorrect  
  assign cpu_d_req_addr_parity_error = (cpu_d_req_addr_p_mux != ^cpu_d_req_addr_mux) & opsrv_parity_en_reg;   
  
  assign cpu_d_req_type = cpu_d_req_read_mux  ? opsrv_mem_req_rd :
                          cpu_d_req_write_mux ? opsrv_mem_req_wr :
                          cpu_d_req_fence_mux ? opsrv_mem_req_fence : opsrv_mem_req_invalid;
  
  assign d_trx_req  = {cpu_d_req_is_apb_mstr,
                       cpu_d_req_is_opsrv_cfg,
                       cpu_d_req_is_ahb_mstr,
                       cpu_d_req_is_axi_mstr,
                       cpu_d_req_is_lmem0,
                       cpu_d_req_is_lmem1,
                       cpu_d_req_is_udma_ctrl,
                       cpu_d_req_is_dummy_slave,
                       cpu_d_req_is_fence,
                       cpu_d_req_type};
  
  
  MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         (11), 
    .BUFF_SIZE          (MAX_OS_D_TRX),
    .PTR_SIZE           (LOG2_MAX_OS_D_TRX)
  )
  u_d_trx_os_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (cpu_d_req_accepted),
    .ready_in           (d_trx_os_buff_ready),
    .data_in            (d_trx_req),
    .data_out           (d_trx_resp),     
    .valid_out          (d_trx_resp_valid),     
    .ready_out          (cpu_d_resp_accepted),
    .data_out_pkd       (d_trx_resp_pkd), 
    .valid_out_pkd      (d_trx_resp_valid_pkd),
    .nearly_full        ()
  );
  
  assign {cpu_d_resp_is_apb_mstr,
          cpu_d_resp_is_opsrv_cfg,
          cpu_d_resp_is_ahb_mstr,
          cpu_d_resp_is_axi_mstr,
          cpu_d_resp_is_lmem0,
          cpu_d_resp_is_lmem1,
          cpu_d_resp_is_udma_ctrl,
          cpu_d_resp_is_dummy_slave,
          cpu_d_resp_is_fence,
          cpu_d_resp_type} = d_trx_resp_valid ? d_trx_resp : {{9{1'b0}},opsrv_mem_req_invalid};
          
  // because the RAM and AHB master do not buffer responses, need to prevent the request unless it can be guaranteed the response will be
  // returned directly. This may not be the case if there is anything else ahead outstanding that is not coming from the same source.
  
  always @*
  begin :extract_os_d_loop
    integer i;
    logic [10:0] tmp_curr_trx_entry;
    req_os_d_src = {9{1'b0}};
    for(i=0; i<MAX_OS_D_TRX; i=i+1)
    begin
      tmp_curr_trx_entry  = d_trx_resp_pkd[(i*11)+:11];
      req_os_d_src        = req_os_d_src | ({9{d_trx_resp_valid_pkd[i]}} & tmp_curr_trx_entry[10:2]);
    end
  end
  
  
  assign {req_os_d_apb_mstr,
          req_os_d_opsrv_cfg,
          req_os_d_ahb_mstr,
          req_os_d_axi_mstr,
          req_os_d_lmem0,
          req_os_d_lmem1,
          req_os_d_udma_ctrl,
          req_os_d_dummy_slave,
          req_os_d_fence} = req_os_d_src;

        
                                      
  assign cpu_d_req_accepted  = cpu_d_req_valid_mux & cpu_d_req_ready_sig & ((|cpu_d_req_rd_byte_en_mux) | 
                                                                            (|cpu_d_req_wr_byte_en_mux) | 
                                                                            cpu_d_req_fence_mux);
  assign cpu_d_resp_accepted = cpu_d_resp_valid_sig & cpu_d_resp_ready_mux;                       
  
  
  assign cpu_d_req_is_apb_mstr      = ((cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_apb_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                      (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_apb_mstr_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                      (cpu_d_req_read_mux | cpu_d_req_write_mux)) |
								      (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:3] == l_mtime_addr_base[CPU_ADDR_WIDTH-1:3]) |   
								      (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:3] == l_mtimecmp_addr_base[CPU_ADDR_WIDTH-1:3]);
                                        
  assign apb_mstr_d_os_other        = req_os_d_ahb_mstr | 
                                      req_os_d_opsrv_cfg |
                                      req_os_d_axi_mstr |
                                      req_os_d_lmem0 |
                                      req_os_d_lmem1 |
                                      req_os_d_udma_ctrl |
                                      req_os_d_dummy_slave;                                 
                                    
  assign apb_mstr_d_req_valid       = cpu_d_req_is_apb_mstr & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~apb_mstr_d_os_other & ~req_os_d_fence;
  assign apb_mstr_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
  assign apb_mstr_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
  //assign apb_mstr_d_req_read        = cpu_d_req_read_mux;
  //assign apb_mstr_d_req_write       = cpu_d_req_write_mux;
  assign apb_mstr_d_req_wr_data     = cpu_d_req_wr_data_mux;
  assign apb_mstr_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
  assign apb_mstr_d_req_addr        = cpu_d_req_addr_mux[APB_MSTR_ADDR_WIDTH-1:0];
  assign apb_mstr_d_req_addr_p      = ((^cpu_d_req_addr_mux[APB_MSTR_ADDR_WIDTH-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
  assign apb_mstr_d_resp_ready      = cpu_d_resp_is_apb_mstr & cpu_d_resp_ready_mux;
                                  
  
  assign cpu_d_req_is_opsrv_cfg     = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_opsrv_cfg_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                    (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_opsrv_cfg_end_addr[CPU_ADDR_WIDTH-1:12]);   
                                    
  assign opsrv_cfg_d_os_other       = req_os_d_apb_mstr |
                                      req_os_d_ahb_mstr | 
                                      req_os_d_axi_mstr |
                                      req_os_d_lmem0 |
                                      req_os_d_lmem1 |
                                      req_os_d_udma_ctrl |
                                      req_os_d_dummy_slave;                                                                                                             
                                    
  assign opsrv_cfg_d_req_valid       = cpu_d_req_is_opsrv_cfg & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~opsrv_cfg_d_os_other & ~req_os_d_fence;
  assign opsrv_cfg_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
  assign opsrv_cfg_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
  assign opsrv_cfg_d_req_read        = cpu_d_req_read_mux;
  assign opsrv_cfg_d_req_write       = cpu_d_req_write_mux;
  assign opsrv_cfg_d_req_wr_data     = cpu_d_req_wr_data_mux;
  assign opsrv_cfg_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
  assign opsrv_cfg_d_req_addr        = cpu_d_req_addr_mux[l_opsrv_cfg_opsrv_cfg_addr_width-1:0];
  assign opsrv_cfg_d_req_addr_p      = ((^cpu_d_req_addr_mux[l_opsrv_cfg_opsrv_cfg_addr_width-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
  assign opsrv_cfg_d_resp_ready      = cpu_d_resp_is_opsrv_cfg & cpu_d_resp_ready_mux;
    
  
  MIV_RV32IMC_opsrv_regs
  #(
    .REGS_ADDR_WIDTH                         (l_opsrv_cfg_opsrv_cfg_addr_width),
	.ECC_ENABLE                              (ECC_ENABLE                      ),
    .l_opsrv_cfg_lmem0_present               (l_opsrv_cfg_lmem0_present       ),
	.l_opsrv_cfg_axi_mstr_present            (l_opsrv_cfg_axi_mstr_present    )
  )
  u_opsrv_regs
  (
    .clk                                     (clk                         ),
    .resetn                                  (resetn                      ),
    .sys_parity_disable                      (sys_parity_disable          ),
    .cpu_regs_req_valid                      (opsrv_cfg_d_req_valid       ),
    .cpu_regs_req_ready                      (opsrv_cfg_d_req_ready       ),
    .cpu_regs_req_rd_byte_en                 (opsrv_cfg_d_req_rd_byte_en  ),
    .cpu_regs_req_wr_byte_en                 (opsrv_cfg_d_req_wr_byte_en  ),
    .cpu_regs_req_read                       (opsrv_cfg_d_req_read        ),
    .cpu_regs_req_write                      (opsrv_cfg_d_req_write       ),
    .cpu_regs_req_addr                       (opsrv_cfg_d_req_addr        ),
    .cpu_regs_req_addr_p                     (opsrv_cfg_d_req_addr_p      ),
    .cpu_regs_req_wr_data                    (opsrv_cfg_d_req_wr_data     ),
    .cpu_regs_req_wr_data_p                  (opsrv_cfg_d_req_wr_data_p   ),
    .cpu_regs_resp_valid                     (opsrv_cfg_d_resp_valid      ),
    .cpu_regs_resp_ready                     (opsrv_cfg_d_resp_ready      ),
    .cpu_regs_resp_error                     (opsrv_cfg_d_resp_error      ),
    .cpu_regs_resp_rd_data                   (opsrv_cfg_d_resp_rd_data    ),
    .cpu_regs_resp_rd_data_p                 (opsrv_cfg_d_resp_rd_data_p  ),
    
    .cpu_regs_lmem0_ecc_err_correctable      (lmem0_ecc_err_correctable   ),
    .cpu_regs_lmem0_ecc_err_uncorrectable    (lmem0_ecc_err_uncorrectable ),
    .cpu_regs_lmem1_ecc_err_correctable      (lmem1_ecc_err_correctable   ),
    .cpu_regs_lmem1_ecc_err_uncorrectable    (lmem1_ecc_err_uncorrectable ),
    .cpu_regs_axi_mstr_wr_resp_err           (axi_mstr_d_wr_resp_err      ),
    .cpu_regs_udma_ctrl_irq                  (udma_ctrl_irq               ),
    .cpu_regs_opsrv_irq                      (opsrv_irq                   ),
    .cpu_regs_axi_rd_cfg_min_size            (axi_rd_cfg_min_size         ),
    .cpu_regs_axi_wr_cfg_min_size            (axi_wr_cfg_min_size         ),
    .cpu_regs_opsrv_parity_en                (opsrv_parity_en_reg         ),
    .cpu_regs_cfg_fence_all_src              (cfg_fence_all_src           ),
    .cpu_regs_cfg_ar_cache                   (cfg_ar_cache                ),
    .cpu_regs_cfg_aw_cache                   (cfg_aw_cache                ),
    .cpu_regs_cfg_raw_hzd_check              (cfg_raw_hzd_check           ),
    .cpu_regs_cfg_war_hzd_check              (cfg_war_hzd_check           ),
    
    .cpu_regs_core_soft_reset                (core_soft_reset),  //connected the core_soft_reset output from the opsrv_regs to the interconnect
    .cpu_regs_core_soft_irq                  (core_soft_irq),     //connected the core_soft_irq output from the opsrv_regs to the interconnect  
    
    .gpr_ded_soft_reset                      (gpr_ded_soft_reset) //connected gpr ded soft reset from interconnect to regs file
  
  );
  
  assign opsrv_parity_en = opsrv_parity_en_reg;

  
  assign lmem0_uncorrectable_ecc_error = lmem0_ecc_err_uncorrectable;
  assign lmem1_uncorrectable_ecc_error = lmem1_ecc_err_uncorrectable;
                                                                       
  
  generate
  if(l_opsrv_cfg_ahb_mstr_present) begin: gen_ahb_d_decode
    assign cpu_d_req_is_ahb_mstr    = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_ahb_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                      (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_ahb_mstr_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                      (cpu_d_req_read_mux | cpu_d_req_write_mux);                           
    assign ahb_mstr_d_req_valid       = cpu_d_req_is_ahb_mstr & cpu_d_req_valid_mux & d_trx_os_buff_ready &  ~req_os_d_fence;
    assign ahb_mstr_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
    assign ahb_mstr_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
    assign ahb_mstr_d_req_read        = cpu_d_req_read_mux;
    assign ahb_mstr_d_req_write       = cpu_d_req_write_mux;
    assign ahb_mstr_d_req_wr_data     = cpu_d_req_wr_data_mux;
    assign ahb_mstr_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
    assign ahb_mstr_d_req_addr        = cpu_d_req_addr_mux[AHB_MSTR_ADDR_WIDTH-1:0];
    assign ahb_mstr_d_req_addr_p      = ((^cpu_d_req_addr_mux[AHB_MSTR_ADDR_WIDTH-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
    assign ahb_mstr_d_resp_ready      = cpu_d_resp_is_ahb_mstr & cpu_d_resp_ready_mux;                                  
                                    
  end
  else begin : ngen_ahb_d_decode
    assign cpu_d_req_is_ahb_mstr      = 1'b0;
    assign ahb_mstr_d_req_valid       = 1'b0;
    assign ahb_mstr_d_req_rd_byte_en  = {4{1'b0}};
    assign ahb_mstr_d_req_wr_byte_en  = {4{1'b0}};
    assign ahb_mstr_d_req_read        = 1'b0;
    assign ahb_mstr_d_req_write       = 1'b0;
    assign ahb_mstr_d_req_wr_data     = {32{1'b0}};
    assign ahb_mstr_d_req_wr_data_p   = {4{1'b0}};
    assign ahb_mstr_d_req_addr        = {AHB_MSTR_ADDR_WIDTH{1'b0}};
    assign ahb_mstr_d_req_addr_p      = 1'b0;
    assign ahb_mstr_d_resp_ready      = 1'b0;
  end   
  endgenerate
  
  generate
  if(l_opsrv_cfg_axi_mstr_present) begin: gen_axi_d_decode
    assign cpu_d_req_is_axi_mstr    = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_axi_mstr_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                      (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_axi_mstr_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                      (cpu_d_req_read_mux | cpu_d_req_write_mux);                                 
    assign axi_mstr_d_req_valid       = cpu_d_req_is_axi_mstr & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~req_os_d_fence;
    assign axi_mstr_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
    assign axi_mstr_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
    assign axi_mstr_d_req_read        = cpu_d_req_read_mux;
    assign axi_mstr_d_req_write       = cpu_d_req_write_mux;
    assign axi_mstr_d_req_wr_data     = cpu_d_req_wr_data_mux;
    assign axi_mstr_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
    assign axi_mstr_d_req_addr        = cpu_d_req_addr_mux[AXI_MSTR_ADDR_WIDTH-1:0];
    assign axi_mstr_d_req_addr_p      = ((^cpu_d_req_addr_mux[AXI_MSTR_ADDR_WIDTH-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
    assign axi_mstr_d_resp_ready      = cpu_d_resp_is_axi_mstr & cpu_d_resp_ready_mux;                                        
  end
  else begin : ngen_axi_d_decode
    assign cpu_d_req_is_axi_mstr      = 1'b0;  
    assign axi_mstr_d_req_valid       = 1'b0;
    assign axi_mstr_d_req_rd_byte_en  = {4{1'b0}};
    assign axi_mstr_d_req_wr_byte_en  = {4{1'b0}};
    assign axi_mstr_d_req_read        = 1'b0;
    assign axi_mstr_d_req_write       = 1'b0;
    assign axi_mstr_d_req_wr_data     = {32{1'b0}};
    assign axi_mstr_d_req_wr_data_p   = {4{1'b0}};
    assign axi_mstr_d_req_addr        = {AXI_MSTR_ADDR_WIDTH{1'b0}};
    assign axi_mstr_d_req_addr_p      = 1'b0;
    assign axi_mstr_d_resp_ready      = 1'b0;
  end   
  endgenerate
  
  generate
  if(l_opsrv_cfg_lmem0_present) begin: gen_lmem0_d_decode
    assign cpu_d_req_is_lmem0      = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_lmem0_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                     (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_lmem0_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                     (cpu_d_req_read_mux | cpu_d_req_write_mux);
                                         
    assign lmem0_d_os_other        = req_os_d_apb_mstr |
                                     req_os_d_opsrv_cfg |
                                     req_os_d_ahb_mstr | 
                                     req_os_d_axi_mstr |
                                     req_os_d_lmem1 |
                                     req_os_d_udma_ctrl |
                                     req_os_d_dummy_slave;                                     
                                      
    assign lmem0_d_req_valid       = cpu_d_req_is_lmem0 & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~lmem0_d_os_other & ~req_os_d_fence;
    assign lmem0_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
    assign lmem0_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
    assign lmem0_d_req_read        = cpu_d_req_read_mux;
    assign lmem0_d_req_write       = cpu_d_req_write_mux;
    assign lmem0_d_req_wr_data     = cpu_d_req_wr_data_mux;
    assign lmem0_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
    assign lmem0_d_req_addr        = cpu_d_req_addr_mux[LMEM0_ADDR_WIDTH-1:0];
    assign lmem0_d_req_addr_p      = ((^cpu_d_req_addr_mux[LMEM0_ADDR_WIDTH-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
    assign lmem0_d_resp_ready      = cpu_d_resp_is_lmem0 & cpu_d_resp_ready_mux;                                    
  end
  else begin : ngen_lmem0_d_decode
    assign cpu_d_req_is_lmem0      = 1'b0; 
    assign lmem0_d_req_valid       = 1'b0;
    assign lmem0_d_req_rd_byte_en  = {4{1'b0}};
    assign lmem0_d_req_wr_byte_en  = {4{1'b0}};
    assign lmem0_d_req_read        = 1'b0;
    assign lmem0_d_req_write       = 1'b0;
    assign lmem0_d_req_wr_data     = {32{1'b0}};
    assign lmem0_d_req_wr_data_p   = {4{1'b0}};
    assign lmem0_d_req_addr        = {LMEM0_ADDR_WIDTH{1'b0}};
    assign lmem0_d_req_addr_p      = 1'b0;
    assign lmem0_d_resp_ready      = 1'b0;
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_lmem1_present) begin: gen_lmem1_d_decode
    assign cpu_d_req_is_lmem1      = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_lmem1_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                     (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_lmem1_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                     (cpu_d_req_read_mux | cpu_d_req_write_mux);
                                    
    assign lmem1_d_os_other        = req_os_d_apb_mstr |
                                     req_os_d_opsrv_cfg |
                                     req_os_d_ahb_mstr | 
                                     req_os_d_axi_mstr |
                                     req_os_d_lmem0 |
                                     req_os_d_udma_ctrl |
                                     req_os_d_dummy_slave;                                     
                                      
    assign lmem1_d_req_valid       = cpu_d_req_is_lmem1 & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~lmem1_d_os_other & ~req_os_d_fence; 
    assign lmem1_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
    assign lmem1_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
    assign lmem1_d_req_read        = cpu_d_req_read_mux;
    assign lmem1_d_req_write       = cpu_d_req_write_mux;
    assign lmem1_d_req_wr_data     = cpu_d_req_wr_data_mux;
    assign lmem1_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
    assign lmem1_d_req_addr        = cpu_d_req_addr_mux[LMEM1_ADDR_WIDTH-1:0];
    assign lmem1_d_req_addr_p      = ((^cpu_d_req_addr_mux[LMEM1_ADDR_WIDTH-1:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
    assign lmem1_d_resp_ready      = cpu_d_resp_is_lmem1 & cpu_d_resp_ready_mux;                                
  end
  else begin : ngen_lmem1_d_decode
    assign cpu_d_req_is_lmem1      = 1'b0;
    assign lmem1_d_req_valid       = 1'b0;
    assign lmem1_d_req_rd_byte_en  = {4{1'b0}};
    assign lmem1_d_req_wr_byte_en  = {4{1'b0}};
    assign lmem1_d_req_read        = 1'b0;
    assign lmem1_d_req_write       = 1'b0;
    assign lmem1_d_req_wr_data     = {32{1'b0}};
    assign lmem1_d_req_wr_data_p   = {4{1'b0}};
    assign lmem1_d_req_addr        = {LMEM1_ADDR_WIDTH{1'b0}};
    assign lmem1_d_req_addr_p      = 1'b0;
    assign lmem1_d_resp_ready      = 1'b0;
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_udma_present) begin: gen_udma_decode
    assign cpu_d_req_is_udma_ctrl      = (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] >= cfg_udma_ctrl_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                         (cpu_d_req_addr_mux[CPU_ADDR_WIDTH-1:12] <= cfg_udma_ctrl_end_addr[CPU_ADDR_WIDTH-1:12]) &
                                         (cpu_d_req_read_mux | cpu_d_req_write_mux);    
    assign udma_ctrl_d_os_other        = req_os_d_apb_mstr |
                                         req_os_d_opsrv_cfg |
                                         req_os_d_ahb_mstr | 
                                         req_os_d_axi_mstr |
                                         req_os_d_lmem0 |
                                         req_os_d_lmem1 |
                                         req_os_d_dummy_slave;                                    
                                      
    assign udma_ctrl_d_req_valid       = cpu_d_req_is_udma_ctrl & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~udma_ctrl_d_os_other & ~req_os_d_fence;                                
    assign udma_ctrl_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
    assign udma_ctrl_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
    assign udma_ctrl_d_req_read        = cpu_d_req_read_mux;
    assign udma_ctrl_d_req_write       = cpu_d_req_write_mux;
    assign udma_ctrl_d_req_wr_data     = cpu_d_req_wr_data_mux;
    assign udma_ctrl_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
    assign udma_ctrl_d_req_addr        = cpu_d_req_addr_mux[UDMA_CTRL_ADDR_WIDTH-1:0];
    assign udma_ctrl_d_req_addr_p      = ((^cpu_d_req_addr_mux[UDMA_CTRL_ADDR_WIDTH:0]) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
    assign udma_ctrl_d_resp_ready      = cpu_d_resp_is_udma_ctrl & cpu_d_resp_ready_mux;                                
  end
  else begin : ngen_udma_ctrl_decode
    assign cpu_d_req_is_udma_ctrl      = 1'b0;  
    assign udma_ctrl_d_req_valid       = 1'b0;
    assign udma_ctrl_d_req_rd_byte_en  = {4{1'b0}};
    assign udma_ctrl_d_req_wr_byte_en  = {4{1'b0}};
    assign udma_ctrl_d_req_read        = 1'b0;
    assign udma_ctrl_d_req_write       = 1'b0;
    assign udma_ctrl_d_req_wr_data     = {32{1'b0}};
    assign udma_ctrl_d_req_wr_data_p   = {4{1'b0}};
    assign udma_ctrl_d_req_addr        = {UDMA_CTRL_ADDR_WIDTH{1'b0}};
    assign udma_ctrl_d_req_addr_p      = 1'b0;
    assign udma_ctrl_d_resp_ready      = 1'b0;
  end   
  endgenerate  
  
  // dummy slave cleans up any read request to undefined address space and returns an error to the cpu
  
  assign cpu_d_req_is_dummy_slave   = (!cpu_d_req_is_apb_mstr  &
                                       !cpu_d_req_is_ahb_mstr  &
                                       !cpu_d_req_is_axi_mstr  &
                                       !cpu_d_req_is_lmem0     &
                                       !cpu_d_req_is_lmem1     &
                                       !cpu_d_req_is_udma_ctrl &
                                       !cpu_d_req_is_opsrv_cfg)  &
                                      (cpu_d_req_read_mux | cpu_d_req_write_mux);
                                      
  assign dummy_slave_d_os_other        = req_os_d_apb_mstr |
                                         req_os_d_opsrv_cfg |
                                         req_os_d_ahb_mstr | 
                                         req_os_d_axi_mstr |
                                         req_os_d_lmem0 |
                                         req_os_d_lmem1 |
                                         req_os_d_udma_ctrl;                                                                         
                                    
  assign dummy_slave_d_req_valid       = cpu_d_req_is_dummy_slave & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~dummy_slave_d_os_other & ~req_os_d_fence;
  assign dummy_slave_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
  assign dummy_slave_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
  assign dummy_slave_d_req_wr_data     = cpu_d_req_wr_data_mux;
  assign dummy_slave_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
  assign dummy_slave_d_req_addr        = cpu_d_req_addr_mux;
  assign dummy_slave_d_req_addr_p      = ((^cpu_d_req_addr_mux) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
  assign dummy_slave_d_resp_ready      = cpu_d_resp_is_dummy_slave & cpu_d_resp_ready_mux;       
  
  // Fence
  // treat fence as an endpoint, attributes are not currently used, but may be in future revision of RISC-V ISA       
  
  
  assign cpu_d_req_is_fence   = cpu_d_req_fence_mux;
                                      
  assign fence_d_os_other        = req_os_d_apb_mstr |
                                   req_os_d_opsrv_cfg |
                                   req_os_d_ahb_mstr | 
                                   req_os_d_axi_mstr |
                                   req_os_d_lmem0 |
                                   req_os_d_lmem1 |
                                   req_os_d_udma_ctrl |
                                   req_os_d_dummy_slave;                                                                         
                                    
  assign fence_d_req_valid       = cpu_d_req_is_fence & cpu_d_req_valid_mux & d_trx_os_buff_ready & ~req_os_d_fence;
  assign fence_d_req_rd_byte_en  = cpu_d_req_rd_byte_en_mux;
  assign fence_d_req_wr_byte_en  = cpu_d_req_wr_byte_en_mux;
  assign fence_d_req_wr_data     = cpu_d_req_wr_data_mux;
  assign fence_d_req_wr_data_p   = cpu_d_req_wr_data_p_mux & {4{opsrv_parity_en_reg}};
  assign fence_d_req_addr        = cpu_d_req_addr_mux;
  assign fence_d_req_addr_p      = ((^cpu_d_req_addr_mux) ^ cpu_d_req_addr_parity_error) & opsrv_parity_en_reg;
  assign fence_d_resp_ready      = cpu_d_resp_is_fence & cpu_d_resp_ready_mux;                      
  
    // response mux
  
  assign cpu_d_req_ready_sig      = (cpu_d_req_is_apb_mstr    & apb_mstr_d_req_ready) |
                                    (cpu_d_req_is_ahb_mstr    & ahb_mstr_d_req_ready) |
                                    (cpu_d_req_is_axi_mstr    & axi_mstr_d_req_ready) |
                                    (cpu_d_req_is_lmem0       & lmem0_d_req_ready) |
                                    (cpu_d_req_is_lmem1       & lmem1_d_req_ready) |
                                    (cpu_d_req_is_udma_ctrl   & udma_ctrl_d_req_ready) |
                                    (cpu_d_req_is_opsrv_cfg   & opsrv_cfg_d_req_ready) |
                                    (cpu_d_req_is_dummy_slave & dummy_slave_d_req_ready) |
                                    (cpu_d_req_is_fence       & fence_d_req_ready);
  
  // Limit number of outstanding debug requests to 1 to ensure no re-ordering issues until debug spec can support abstract fence commands                              
  assign cpu_d_req_ready          = cpu_d_req_ready_sig & ~debug_mode;    
  assign debug_sysbus_req_ready   = cpu_d_req_ready_sig & debug_mode & ~(|d_trx_resp_valid_pkd) ;                      
                                

  assign cpu_d_resp_valid_rd     = (cpu_d_resp_is_apb_mstr    & apb_mstr_d_resp_valid) |
                                   (cpu_d_resp_is_ahb_mstr    & ahb_mstr_d_resp_valid) |
                                   (cpu_d_resp_is_axi_mstr    & axi_mstr_d_resp_valid) |
                                   (cpu_d_resp_is_lmem0       & lmem0_d_resp_valid) |
                                   (cpu_d_resp_is_lmem1       & lmem1_d_resp_valid) |
                                   (cpu_d_resp_is_udma_ctrl   & udma_ctrl_d_resp_valid) |
                                   (cpu_d_resp_is_opsrv_cfg   & opsrv_cfg_d_resp_valid) |
                                   (cpu_d_resp_is_dummy_slave & dummy_slave_d_resp_valid);
                                   
  assign cpu_d_resp_valid_wr     = write_op_d_resp_valid;
  
  assign cpu_d_resp_valid_fence  = fence_op_d_resp_valid;   
  
  assign cpu_d_resp_valid_sig    = ((cpu_d_resp_type == opsrv_mem_req_rd) & cpu_d_resp_valid_rd) |  
                                   ((cpu_d_resp_type == opsrv_mem_req_wr) & cpu_d_resp_valid_wr) |
                                   ((cpu_d_resp_type == opsrv_mem_req_fence) & cpu_d_resp_valid_fence);     
                                   
  assign cpu_d_resp_valid        = cpu_d_resp_valid_sig & ~debug_mode; 
  assign debug_sysbus_resp_valid = cpu_d_resp_valid_sig & debug_mode;                                                    
  
  assign cpu_d_resp_error_rd     = (cpu_d_resp_is_apb_mstr    & apb_mstr_d_resp_error) |
                                   (cpu_d_resp_is_ahb_mstr    & ahb_mstr_d_resp_rd_error) |
                                   (cpu_d_resp_is_axi_mstr    & axi_mstr_d_resp_rd_error) |
                                   (cpu_d_resp_is_lmem0       & lmem0_d_resp_error) |
                                   (cpu_d_resp_is_lmem1       & lmem1_d_resp_error) |
                                   (cpu_d_resp_is_udma_ctrl   & udma_ctrl_d_resp_error) |
                                   (cpu_d_resp_is_opsrv_cfg   & opsrv_cfg_d_resp_error) |
                                   (cpu_d_resp_is_dummy_slave & dummy_slave_d_resp_error);
                                   
  assign cpu_d_resp_error_wr     = (cpu_d_resp_is_apb_mstr    & apb_mstr_d_resp_error) |
                                   (cpu_d_resp_is_ahb_mstr    & 1'b0) | // AXI and AHB errors are delayed and imprecise so cause interrupt
                                   (cpu_d_resp_is_axi_mstr    & 1'b0) |
                                   (cpu_d_resp_is_lmem0       & lmem0_d_resp_error) |
                                   (cpu_d_resp_is_lmem1       & lmem1_d_resp_error) |
                                   (cpu_d_resp_is_udma_ctrl   & udma_ctrl_d_resp_error) |
                                   (cpu_d_resp_is_opsrv_cfg   & opsrv_cfg_d_resp_error) |
                                   (cpu_d_resp_is_dummy_slave & dummy_slave_d_resp_error);
  
  assign cpu_d_resp_error_fence  = fence_op_d_resp_error;   
  
  assign cpu_d_resp_error_sig    = ((cpu_d_resp_type == opsrv_mem_req_rd) & cpu_d_resp_error_rd) |  
                                   ((cpu_d_resp_type == opsrv_mem_req_wr) & cpu_d_resp_error_wr) |
                                   ((cpu_d_resp_type == opsrv_mem_req_fence) & cpu_d_resp_error_fence);     
                                       
  assign cpu_d_resp_error        = cpu_d_resp_error_sig & ~debug_mode;
  assign debug_sysbus_resp_error = cpu_d_resp_error_sig & debug_mode;
                                
  
  assign cpu_d_resp_rd_data_sig  = ({32{cpu_d_resp_is_apb_mstr}}    & apb_mstr_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_ahb_mstr}}    & ahb_mstr_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_axi_mstr}}    & axi_mstr_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_lmem0}}       & lmem0_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_lmem1}}       & lmem1_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_udma_ctrl}}   & udma_ctrl_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_opsrv_cfg}}   & opsrv_cfg_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_dummy_slave}} & dummy_slave_d_resp_rd_data) |
                                   ({32{cpu_d_resp_is_fence}}       & fence_d_resp_rd_data);                                                                      
  
  assign cpu_d_resp_rd_data         =  cpu_d_resp_rd_data_sig;        
  assign debug_sysbus_resp_rd_data  =  cpu_d_resp_rd_data_sig;                      
                                
  assign cpu_d_resp_rd_data_p_sig   = (({4{cpu_d_resp_is_apb_mstr}}    & apb_mstr_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_ahb_mstr}}    & ahb_mstr_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_axi_mstr}}    & axi_mstr_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_lmem0}}       & lmem0_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_lmem1}}       & lmem1_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_udma_ctrl}}   & udma_ctrl_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_opsrv_cfg}}   & opsrv_cfg_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_dummy_slave}} & dummy_slave_d_resp_rd_data_p) |
                                       ({4{cpu_d_resp_is_fence}}       & fence_d_resp_rd_data_p)) & {4{opsrv_parity_en_reg}}; 
                                       
  assign cpu_d_resp_rd_data_p       = cpu_d_resp_rd_data_p_sig;                                                             
                                
  // Dummy slave
  //-------------------------------
  // Dummy slave returns an error response 1 cycle after a request
  // Deal with I and D seperately
  
  assign dummy_slave_i_req_ready      = 1'b1; 
  assign dummy_slave_i_resp_valid     = cpu_i_resp_is_dummy_slave & i_trx_resp_valid;
  assign dummy_slave_i_resp_error     = 1'b1;
  assign dummy_slave_i_resp_rd_data   = {32{1'b0}};
  assign dummy_slave_i_resp_rd_data_p = {4{1'b0}};
  
  assign dummy_slave_d_req_ready      = 1'b1; 
  assign dummy_slave_d_resp_valid     = cpu_d_resp_is_dummy_slave & d_trx_resp_valid;
  assign dummy_slave_d_resp_error     = 1'b1;
  assign dummy_slave_d_resp_rd_data   = {32{1'b0}};
  assign dummy_slave_d_resp_rd_data_p = {4{1'b0}};
  
  // Write response
  // OPSRV returns write response immediately to the Submicron core as no requests to the same location can be
  // reordered except by AXI which enforce RAW ordering in the master
  
  assign write_op_d_resp_valid     = d_trx_resp_valid;
  
  // Ordering/Fence control
  //-------------------------------
  // When a fence request is accepted all subsequent request will be blocked until the fence completes
  // The fence completes when all masters indicate they have no outstanding requests
  
  assign d_trx_os = req_os_d_apb_mstr |
                    req_os_d_opsrv_cfg |
                    req_os_d_ahb_mstr |
                    req_os_d_axi_mstr |
                    req_os_d_lmem0 |
                    req_os_d_lmem1 |
                    req_os_d_udma_ctrl;

// assign d_trx_os = (axi_mstr_trx_os_d_rd |
//                    axi_mstr_trx_os_d_wr |
//                    ahb_mstr_trx_os_d_rd |
//                    ahb_mstr_trx_os_d_wr |
//                    apb_mstr_trx_os_d_rd |
//                    apb_mstr_trx_os_d_wr |
//                    lmem0_trx_os_d_rd    |
//                    lmem0_trx_os_d_wr    |
//                    lmem1_trx_os_d_rd    |
//                    lmem1_trx_os_d_wr    |
//                    udma_trx_os_d_rd     |
//                    udma_trx_os_d_wr);         
  
  assign fence_op_d_resp_valid    = cpu_d_resp_is_fence & d_trx_resp_valid & ~d_trx_os;                                                                                                                         
  assign fence_op_d_resp_error    = 1'b0;
  
  assign fence_d_req_ready      = 1'b1; 
  assign fence_d_resp_rd_data   = {32{1'b0}};
  assign fence_d_resp_rd_data_p = {4{1'b0}};
  
  // Need to ensure a response has been received for all transactions made before allowing debug mode to be left,
  // therefore indicate to debug module when all transactions are complete (from the perspective of the OPSRV)
  // only need to deal with d-side outstanding as all debug requests are made to the d-side.
  assign debug_trx_os = |d_trx_resp_valid_pkd;
  

                                                                                                       

//******************************************************************************
// properties
//********************************************************************************
`ifdef OPSRV_RTL_PROPS

  assert_opsrv_cpu_i_req_is_onehot: assert property (@(posedge clk) disable iff (~resetn)
                                                     cpu_i_req_valid |-> $onehot({cpu_i_req_is_apb_mstr,
                                                                                  cpu_i_req_is_ahb_mstr,
                                                                                  cpu_i_req_is_axi_mstr,
                                                                                  cpu_i_req_is_lmem0,
                                                                                  cpu_i_req_is_lmem1,
                                                                                  cpu_i_req_is_dummy_slave}));

  assert_opsrv_cpu_i_resp_is_onehot: assert property (@(posedge clk) disable iff (~resetn)
                                                     cpu_i_resp_valid |-> $onehot({cpu_i_resp_is_apb_mstr,
                                                                                   cpu_i_resp_is_ahb_mstr,
                                                                                   cpu_i_resp_is_axi_mstr,
                                                                                   cpu_i_resp_is_lmem0,
                                                                                   cpu_i_resp_is_lmem1,
                                                                                   cpu_i_resp_is_dummy_slave}));
                                                                                   
                                                                                   
  assert_opsrv_cpu_d_req_is_onehot: assert property (@(posedge clk) disable iff (~resetn)
                                                     cpu_d_req_valid_mux |-> $onehot({cpu_d_req_is_apb_mstr,
                                                                                  cpu_d_req_is_ahb_mstr,
                                                                                  cpu_d_req_is_axi_mstr,
                                                                                  cpu_d_req_is_lmem0,
                                                                                  cpu_d_req_is_lmem1,
                                                                                  cpu_d_req_is_udma_ctrl,
                                                                                  cpu_d_req_is_opsrv_cfg,
                                                                                  cpu_d_req_is_dummy_slave,
                                                                                  cpu_d_req_is_fence}));

  assert_opsrv_cpu_d_resp_is_onehot: assert property (@(posedge clk) disable iff (~resetn)
                                                     cpu_d_resp_valid_sig |-> $onehot({cpu_d_resp_is_apb_mstr,
                                                                                   cpu_d_resp_is_ahb_mstr,
                                                                                   cpu_d_resp_is_axi_mstr,
                                                                                   cpu_d_resp_is_lmem0,
                                                                                   cpu_d_resp_is_lmem1,
                                                                                   cpu_d_resp_is_udma_ctrl,
                                                                                   cpu_d_resp_is_opsrv_cfg,
                                                                                   cpu_d_resp_is_dummy_slave,
                                                                                   cpu_d_resp_is_fence}));   
                                                                                   
   //-------------                                                              
   // covers
   //------------
   
   sequence seq_opsrv_ic_cpu_i_any_req_consec(cycles);
      (cpu_i_req_accepted)[*cycles] ;
   endsequence 
   
   sequence seq_opsrv_ic_cpu_i_any_resp_consec(cycles);
      (cpu_i_resp_accepted)[*cycles] ;
   endsequence 

   // cpu i apb master request and response   
   sequence seq_opsrv_ic_cpu_i_apb_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_apb_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_apb_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_apb_mstr)[*cycles] ;
   endsequence       
   
   // cpu i ahb master request and response   
   sequence seq_opsrv_ic_cpu_i_ahb_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_ahb_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_ahb_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_ahb_mstr)[*cycles] ;
   endsequence      
   
   // cpu i axi master request and response   
   sequence seq_opsrv_ic_cpu_i_axi_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_axi_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_axi_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_axi_mstr)[*cycles] ;
   endsequence       
   
   // cpu i lmem0 request and response   
   sequence seq_opsrv_ic_cpu_i_lmem0_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_lmem0)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_lmem0_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_lmem0)[*cycles] ;
   endsequence  
   
   // cpu i lmem1 request and response   
   sequence seq_opsrv_ic_cpu_i_lmem1_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_lmem1)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_lmem1_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_lmem1)[*cycles] ;
   endsequence   
   
   // cpu i dummy_slave (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_i_dummy_slave_req_consec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_dummy_slave)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_dummy_slave_resp_consec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_dummy_slave)[*cycles] ;
   endsequence            
   
   sequence seq_opsrv_ic_cpu_d_any_req_consec(cycles);
      (cpu_d_req_accepted)[*cycles] ;
   endsequence 
   
   sequence seq_opsrv_ic_cpu_d_any_resp_consec(cycles);
      (cpu_d_resp_accepted)[*cycles] ;
   endsequence 

   // cpu d apb master request and response   
   sequence seq_opsrv_ic_cpu_d_apb_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_apb_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_apb_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_apb_mstr)[*cycles] ;
   endsequence       
   
   // cpu d ahb master request and response   
   sequence seq_opsrv_ic_cpu_d_ahb_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_ahb_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_ahb_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_ahb_mstr)[*cycles] ;
   endsequence      
   
   // cpu d axi master request and response   
   sequence seq_opsrv_ic_cpu_d_axi_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_axi_mstr)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_axi_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_axi_mstr)[*cycles] ;
   endsequence       
   
   // cpu d lmem0 request and response   
   sequence seq_opsrv_ic_cpu_d_lmem0_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_lmem0)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_lmem0_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_lmem0)[*cycles] ;
   endsequence  
   
   // cpu d lmem1 request and response   
   sequence seq_opsrv_ic_cpu_d_lmem1_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_lmem1)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_lmem1_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_lmem1)[*cycles] ;
   endsequence 
     
   // cpu d udma_ctrl (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_udma_ctrl_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_udma_ctrl)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_udma_ctrl_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_udma_ctrl)[*cycles] ;
   endsequence  
   
   // cpu d opsrv_cfg request and response   
   sequence seq_opsrv_ic_cpu_d_opsrv_cfg_d_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_opsrv_cfg)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_opsrv_cfg_d_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_opsrv_cfg)[*cycles] ;
   endsequence  
      
   // cpu d dummy_slave (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_dummy_slave_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_dummy_slave)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_dummy_slave_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_dummy_slave)[*cycles] ;
   endsequence                                                              
      
   // cpu d fence (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_fence_req_consec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_fence)[*cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_fence_resp_consec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_fence)[*cycles] ;
   endsequence  
      
   sequence seq_opsrv_ic_cpu_i_any_req_nonconsec(cycles);
      (cpu_i_req_accepted)[->cycles] ;
   endsequence 
   
   sequence seq_opsrv_ic_cpu_i_any_resp_nonconsec(cycles);
      (cpu_i_resp_accepted)[->cycles] ;
   endsequence 

   // cpu i apb master request and response   
   sequence seq_opsrv_ic_cpu_i_apb_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_apb_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_apb_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_apb_mstr)[->cycles] ;
   endsequence       
   
   // cpu i ahb master request and response   
   sequence seq_opsrv_ic_cpu_i_ahb_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_ahb_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_ahb_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_ahb_mstr)[->cycles] ;
   endsequence      
   
   // cpu i axi master request and response   
   sequence seq_opsrv_ic_cpu_i_axi_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_axi_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_axi_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_axi_mstr)[->cycles] ;
   endsequence       
   
   // cpu i lmem0 request and response   
   sequence seq_opsrv_ic_cpu_i_lmem0_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_lmem0)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_lmem0_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_lmem0)[->cycles] ;
   endsequence  
   
   // cpu i lmem1 request and response   
   sequence seq_opsrv_ic_cpu_i_lmem1_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_lmem1)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_lmem1_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_lmem1)[->cycles] ;
   endsequence   
   
   // cpu i dummy_slave (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_i_dummy_slave_req_nonconsec(cycles);
      (cpu_i_req_accepted & cpu_i_req_is_dummy_slave)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_i_dummy_slave_resp_nonconsec(cycles);
      (cpu_i_resp_accepted & cpu_i_resp_is_dummy_slave)[->cycles] ;
   endsequence            
   
   sequence seq_opsrv_ic_cpu_d_any_req_nonconsec(cycles);
      (cpu_d_req_accepted)[->cycles] ;
   endsequence 
   
   sequence seq_opsrv_ic_cpu_d_any_resp_nonconsec(cycles);
      (cpu_d_resp_accepted)[->cycles] ;
   endsequence 

   // cpu d apb master request and response   
   sequence seq_opsrv_ic_cpu_d_apb_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_apb_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_apb_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_apb_mstr)[->cycles] ;
   endsequence       
   
   // cpu d ahb master request and response   
   sequence seq_opsrv_ic_cpu_d_ahb_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_ahb_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_ahb_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_ahb_mstr)[->cycles] ;
   endsequence      
   
   // cpu d axi master request and response   
   sequence seq_opsrv_ic_cpu_d_axi_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_axi_mstr)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_axi_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_axi_mstr)[->cycles] ;
   endsequence       
   
   // cpu d lmem0 request and response   
   sequence seq_opsrv_ic_cpu_d_lmem0_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_lmem0)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_lmem0_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_lmem0)[->cycles] ;
   endsequence  
   
   // cpu d lmem1 request and response   
   sequence seq_opsrv_ic_cpu_d_lmem1_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_lmem1)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_lmem1_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_lmem1)[->cycles] ;
   endsequence 
     
   // cpu d udma_ctrl (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_udma_ctrl_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_udma_ctrl)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_udma_ctrl_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_udma_ctrl)[->cycles] ;
   endsequence  
   
   // cpu d opsrv_cfg (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_opsrv_cfg_d_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_opsrv_cfg)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_opsrv_cfg_d_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_opsrv_cfg)[->cycles] ;
   endsequence  
      
   // cpu d dummy_slave (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_dummy_slave_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_dummy_slave)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_dummy_slave_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_dummy_slave)[->cycles] ;
   endsequence                                                              
      
   // cpu d fence (illegal address) request and response   
   sequence seq_opsrv_ic_cpu_d_fence_req_nonconsec(cycles);
      (cpu_d_req_accepted & cpu_d_req_is_fence)[->cycles] ;
   endsequence      
   
   sequence seq_opsrv_ic_cpu_d_fence_resp_nonconsec(cycles);
      (cpu_d_resp_accepted & cpu_d_resp_is_fence)[->cycles] ;
   endsequence    
   
  genvar i_cover_seq;
  generate
  for (i_cover_seq = 1; i_cover_seq <= 5; i_cover_seq++) begin : gen_cover_req_resp_seq
  
    cover_opsrv_ic_cpu_i_any_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_any_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_any_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_any_resp_consec(i_cover_seq));                                                       
                                                         
    cover_opsrv_ic_cpu_i_apb_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_apb_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_apb_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_apb_resp_consec(i_cover_seq)); 
                                                         
    cover_opsrv_ic_cpu_i_ahb_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_ahb_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_ahb_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_ahb_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_axi_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_axi_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_axi_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_axi_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_lmem0_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem0_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_lmem0_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem0_resp_consec(i_cover_seq));  
                                                                                                                  
    cover_opsrv_ic_cpu_i_lmem1_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem1_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_lmem1_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem1_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_dummy_slave_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_dummy_slave_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_dummy_slave_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_dummy_slave_resp_consec(i_cover_seq));         
                                                         
    cover_opsrv_ic_cpu_d_any_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_any_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_any_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_any_resp_consec(i_cover_seq));                                                       
                                                         
    cover_opsrv_ic_cpu_d_apb_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_apb_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_apb_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_apb_resp_consec(i_cover_seq)); 
                                                         
    cover_opsrv_ic_cpu_d_ahb_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_ahb_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_ahb_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_ahb_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_axi_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_axi_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_axi_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_axi_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_lmem0_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem0_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_lmem0_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem0_resp_consec(i_cover_seq));  
                                                                                                                  
    cover_opsrv_ic_cpu_d_lmem1_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem1_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_lmem1_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem1_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_dummy_slave_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_dummy_slave_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_dummy_slave_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_dummy_slave_resp_consec(i_cover_seq));   
                                                         
    cover_opsrv_ic_cpu_d_udma_ctrl_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_udma_ctrl_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_udma_ctrl_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_udma_ctrl_resp_consec(i_cover_seq));   
                                                         
    cover_opsrv_ic_cpu_d_opsrv_cfg_d_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_opsrv_cfg_d_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_opsrv_cfg_d_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_opsrv_cfg_d_resp_consec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_fence_req_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_fence_req_consec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_fence_resp_consec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_fence_resp_consec(i_cover_seq));  
                                                         
                                                         
                                                         
                                                         
                                                         
    
    cover_opsrv_ic_cpu_i_any_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_any_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_any_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_any_resp_nonconsec(i_cover_seq));                                                       
                                                         
    cover_opsrv_ic_cpu_i_apb_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_apb_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_apb_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_apb_resp_nonconsec(i_cover_seq)); 
                                                         
    cover_opsrv_ic_cpu_i_ahb_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_ahb_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_ahb_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_ahb_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_axi_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_axi_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_axi_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_axi_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_lmem0_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem0_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_lmem0_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem0_resp_nonconsec(i_cover_seq));  
                                                                                                                  
    cover_opsrv_ic_cpu_i_lmem1_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem1_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_lmem1_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_lmem1_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_i_dummy_slave_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_dummy_slave_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_i_dummy_slave_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_i_dummy_slave_resp_nonconsec(i_cover_seq));         
                                                         
    cover_opsrv_ic_cpu_d_any_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_any_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_any_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_any_resp_nonconsec(i_cover_seq));                                                       
                                                         
    cover_opsrv_ic_cpu_d_apb_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_apb_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_apb_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_apb_resp_nonconsec(i_cover_seq)); 
                                                         
    cover_opsrv_ic_cpu_d_ahb_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_ahb_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_ahb_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_ahb_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_axi_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_axi_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_axi_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_axi_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_lmem0_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem0_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_lmem0_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem0_resp_nonconsec(i_cover_seq));  
                                                                                                                  
    cover_opsrv_ic_cpu_d_lmem1_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem1_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_lmem1_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_lmem1_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_dummy_slave_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_dummy_slave_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_dummy_slave_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_dummy_slave_resp_nonconsec(i_cover_seq));   
                                                         
    cover_opsrv_ic_cpu_d_udma_ctrl_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_udma_ctrl_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_udma_ctrl_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_udma_ctrl_resp_nonconsec(i_cover_seq));   
                                                         
    cover_opsrv_ic_cpu_d_opsrv_cfg_d_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_opsrv_cfg_d_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_opsrv_cfg_d_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_opsrv_cfg_d_resp_nonconsec(i_cover_seq));  
                                                         
    cover_opsrv_ic_cpu_d_fence_req_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_fence_req_nonconsec(i_cover_seq));
  
    cover_opsrv_ic_cpu_d_fence_resp_nonconsec: cover property (@(posedge clk) disable iff (~resetn)
                                                         seq_opsrv_ic_cpu_d_fence_resp_nonconsec(i_cover_seq));                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                           
                                                                                                                
                                                         
  end
  endgenerate                                                                                    
                                                                                                                                                                   

`endif

endmodule


`default_nettype wire


// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_lmem.sv
//
//   Purpose:
//    opsrv local memory
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv_lmem
//********************************************************************************
// Parameter description

  #(   
    parameter LMEM_ADDR_WIDTH     = 16,
    parameter UDMA_PRESENT        = 0,
    parameter LMEM_DAP_PRESENT    = 0,
    parameter DEBUG_PRESENT       = 0,
    parameter CPU_I_PRESENT       = 0,
    parameter CPU_D_PRESENT       = 0,
    parameter USE_RAM_PARITY_BITS = 0,
    parameter RAM_SB_IN_WIDTH     = 4,
    parameter RAM_SB_OUT_WIDTH    = 4,
    parameter RAM_DEPTH           = 4096,
	parameter ECC_ENABLE          = 0
   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,

    // Control/status/config    
    input wire logic                             opsrv_parity_en,  
    output     logic                             trx_os_d_rd,
    output     logic                             trx_os_d_wr,
    output     logic                             ecc_err_correctable,
    output     logic                             ecc_err_uncorrectable,

    // CPU interface    
    input wire  logic                            cpu_i_req_valid,
    output      logic                            cpu_i_req_ready, 
    input wire  logic [3:0]                      cpu_i_req_rd_byte_en,
    input wire  logic [LMEM_ADDR_WIDTH-1:0]      cpu_i_req_addr,
    input wire  logic                            cpu_i_req_addr_p,
    output      logic                            cpu_i_resp_valid,
    input wire  logic                            cpu_i_resp_ready,
    output      logic                            cpu_i_resp_error,
    output      logic [31:0]                     cpu_i_resp_rd_data, 
    output      logic [3:0]                      cpu_i_resp_rd_data_p, 
    input wire  logic                            cpu_d_req_valid,
    output      logic                            cpu_d_req_ready, 
    input wire  logic [3:0]                      cpu_d_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_d_req_wr_byte_en,
    input wire  logic                            cpu_d_req_read, 
    input wire  logic                            cpu_d_req_write,
    input wire  logic [LMEM_ADDR_WIDTH-1:0]      cpu_d_req_addr,
    input wire  logic                            cpu_d_req_addr_p,
    input wire  logic [31:0]                     cpu_d_req_wr_data,
    input wire  logic [3:0]                      cpu_d_req_wr_data_p,
    output      logic                            cpu_d_resp_valid,
    input wire  logic                            cpu_d_resp_ready,
    output      logic                            cpu_d_resp_error,
    output      logic [31:0]                     cpu_d_resp_rd_data,  
    output      logic [3:0]                      cpu_d_resp_rd_data_p,   
    
    // uDMA interface 
    input wire logic                             udma_req_valid,
    output     logic                             udma_req_ready, 
    input wire logic [3:0]                       udma_req_rd_byte_en,  
    input wire logic [3:0]                       udma_req_wr_byte_en,
    input wire logic                             udma_req_read, 
    input wire logic                             udma_req_write,
    input wire logic [LMEM_ADDR_WIDTH-1:0]       udma_req_addr,
    input wire logic                             udma_req_addr_p,
    input wire logic [3:0]                       udma_req_len,
    input wire logic [31:0]                      udma_req_wr_data,
    input wire logic [3:0]                       udma_req_wr_data_p,
    output     logic                             udma_resp_valid,
    input wire logic                             udma_resp_ready,
    output     logic                             udma_resp_rd_error,
    output     logic [31:0]                      udma_resp_rd_data, 
    output     logic [3:0]                       udma_resp_rd_data_p,    

    // local memory direct access port
    input wire logic                             lmem_cpu_access_disable,  
    input wire logic                             lmem_dma_access_disable, 
    input wire logic                             lmem_dap_access_disable, 
    input wire logic                             lmem_dap_req_valid,
    output     logic                             lmem_dap_req_ready, 
    input wire logic [3:0]                       lmem_dap_req_rd_byte_en,  
    input wire logic [3:0]                       lmem_dap_req_wr_byte_en,
    input wire logic [LMEM_ADDR_WIDTH-1:0]       lmem_dap_req_addr,
    input wire logic                             lmem_dap_req_addr_p,
    input wire logic [31:0]                      lmem_dap_req_wr_data,
    input wire logic [3:0]                       lmem_dap_req_wr_data_p,
    output     logic                             lmem_dap_resp_valid,
    input wire logic                             lmem_dap_resp_ready,
    output     logic                             lmem_dap_resp_rd_error,
    output     logic [31:0]                      lmem_dap_resp_rd_data,  
    output     logic [3:0]                       lmem_dap_resp_rd_data_p,
    output     logic [RAM_SB_OUT_WIDTH-1:0]      lmem_ram_sb_out,         
    input wire logic [RAM_SB_IN_WIDTH-1:0]       lmem_ram_sb_in           
  );

//********************************************************************************
// Declarations

// localparams
  localparam l_opsrv_cfg_lmem_byte_shim = 1;
  localparam RAM_DATA_WIDTH       = 32 + (USE_RAM_PARITY_BITS*4);
  localparam CPU_D_DEBUG_PRESENT  = (DEBUG_PRESENT[0] | CPU_D_PRESENT[0]) ? 1 : 0;
  localparam NUM_REQUESTERS       = UDMA_PRESENT + LMEM_DAP_PRESENT + CPU_I_PRESENT + CPU_D_DEBUG_PRESENT;  
  localparam RAM_WEN_WIDTH        = l_opsrv_cfg_lmem_byte_shim ? 1 : 4; 
  localparam UDMA_DAP_PRESENT     = (UDMA_PRESENT[0] | LMEM_DAP_PRESENT[0]) ? 1 : 0;
  
  
  logic [2:0]                      req_valid;                         
  //35logic [3:0]                      req_rd_byte_en [2:0];          
  logic [3:0]                      req_wr_byte_en [2:0];  
  logic [2:0]                      req_read;
  logic [2:0]                      req_write; 
  logic [LMEM_ADDR_WIDTH-1:0]      req_addr [2:0];                
  //logic [2:0]                      req_addr_p;                    
  logic [31:0]                     req_wr_data [2:0];             
  logic [3:0]                      req_wr_data_p [2:0];           

// Internal nets

  logic                             lmem_cpu_access_disable_reg;
  logic                             lmem_dma_access_disable_reg;
  logic                             lmem_dap_access_disable_reg;
                             
  logic                             udma_dap_req_valid;
  logic [3:0]                       udma_dap_req_wr_byte_en;
  logic [3:0]                       udma_dap_req_rd_byte_en;  
  logic                             udma_dap_write;
  logic                             udma_dap_read;
  logic [LMEM_ADDR_WIDTH-1:0]       udma_dap_req_addr;
  logic                             udma_dap_req_addr_p;
  logic [31:0]                      udma_dap_req_wr_data;
  logic [3:0]                       udma_dap_req_wr_data_p;
  logic                             udma_dap_resp_valid;    
  logic                             udma_dap_resp_rd_error; 
  logic [31:0]                      udma_dap_resp_rd_data;  
  logic [3:0]                       udma_dap_resp_rd_data_p;
  logic                             udma_dap_req_ready;
    
  logic [2:0]                       lmem_src_req;
  logic [2:0]                       lmem_src_gnt;
  
  logic                             req_valid_mux;
  logic [3:0]                       req_wr_byte_en_mux;
  //logic [3:0]                       req_rd_byte_en_mux;
  //logic                             req_read_mux;
  //logic                             req_write_mux;
  logic [LMEM_ADDR_WIDTH-1:0]       req_addr_mux;
  //logic                             req_addr_p_mux;
  logic [31:0]                      req_wr_data_mux;
  logic [3:0]                       req_wr_data_p_mux;
  
  logic [31:0]                      resp_rd_data; 
  logic [3:0]                       resp_rd_data_p;
  logic [2:0]                       resp_dest; // REVISIT add extra bit to differentiate udma and dap when UDAM added
  
  logic [RAM_DATA_WIDTH-1:0]        wr_data_comb;
  logic [RAM_DATA_WIDTH-1:0]        rd_data_comb;




//********************************************************************************
// Main code
//********************************************************************************

// ram arbitration is critical path so register external controls
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
    begin
      lmem_cpu_access_disable_reg <= 1'b0;
      lmem_dma_access_disable_reg <= 1'b0;
      lmem_dap_access_disable_reg <= 1'b0;
    end
    else
      begin
        lmem_cpu_access_disable_reg <= lmem_cpu_access_disable;
        lmem_dma_access_disable_reg <= lmem_dma_access_disable;
        lmem_dap_access_disable_reg <= lmem_dap_access_disable;
      end       
  end 


// Request Arbiter
// Round robin arbitration between CPU I, CPU D, and memory dma/dap ports
// The RAM timing is on the critical path for core performance so dma/dap port arbitration/multiplexing is performed seperately
// All requests are single beat


// uDMA-DAP arbiter/mux

  // REVISIT add first stage arbiter/mux here when uDMA and LMEM DAP support added
  // For now only LMEM DAP may possibly exist, so connect directly
  //******************
  
  assign udma_dap_req_valid       = lmem_dap_req_valid & ~lmem_dap_access_disable_reg;
  assign udma_dap_req_wr_byte_en  = lmem_dap_req_rd_byte_en; 
  assign udma_dap_req_rd_byte_en  = lmem_dap_req_wr_byte_en; 
  assign udma_dap_write           = |lmem_dap_req_wr_byte_en;
  assign udma_dap_read            = |lmem_dap_req_rd_byte_en;
  assign udma_dap_req_addr        = lmem_dap_req_addr;     
  assign udma_dap_req_addr_p      = lmem_dap_req_addr_p;   
  assign udma_dap_req_wr_data     = lmem_dap_req_wr_data;  
  assign udma_dap_req_wr_data_p   = lmem_dap_req_wr_data_p;
  
  assign lmem_dap_req_ready       = udma_dap_req_ready; 
  assign lmem_dap_resp_valid      = udma_dap_resp_valid;    
  assign lmem_dap_resp_rd_error   = udma_dap_resp_rd_error; 
  assign lmem_dap_resp_rd_data    = udma_dap_resp_rd_data;  
  assign lmem_dap_resp_rd_data_p  = udma_dap_resp_rd_data_p;
  
 // REVISIT Temporary tie-offs UDMA npot currently implemented

  assign udma_req_ready       = 1'b0; 
  assign udma_resp_valid      = 1'b0;
  assign udma_resp_rd_error   = 1'b0;
  assign udma_resp_rd_data    = {32{1'b0}}; 
  assign udma_resp_rd_data_p  = {4{1'b0}};  
  
//////////////////////////////////////////////////////////////////////////////////////////
// SHIM SB SH FSM
   
  localparam BH_INIT = 2'd0, BH_READ = 2'd1, BH_WRITE = 2'd2;
  
  logic [1:0]                      cpu_d_wr_rd_state;
  
  logic [LMEM_ADDR_WIDTH-1:0]      cpu_d_req_addr_reg;
  logic [31:0]                     cpu_d_req_wr_data_reg;
 
  logic [3:0]                      cpu_d_req_rd_byte_en_int;  
  logic [3:0]                      cpu_d_req_wr_byte_en_int;
  logic [3:0]                      cpu_d_req_wr_byte_en_reg;
	 
  logic [LMEM_ADDR_WIDTH-1:0]      cpu_d_req_addr_sel;
  logic [31:0]                     cpu_d_req_wr_data_sel;
  logic [3:0]                      cpu_d_req_rd_byte_en_sel;  
  logic [3:0]                      cpu_d_req_wr_byte_en_sel;
  logic [RAM_WEN_WIDTH-1:0]        req_wr_byte_en_mux_sel;
  
  logic [1:0]                      ecc_err;
  logic [1:0]                      ecc_err_reg;
	  

  generate if(l_opsrv_cfg_lmem_byte_shim) begin : gen_lmem_byte_shim
	  assign req_wr_byte_en_mux_sel      = |req_wr_byte_en_mux;
      assign cpu_d_req_wr_byte_en_sel    = (cpu_d_wr_rd_state == BH_INIT) & ((&cpu_d_req_wr_byte_en) | (~|cpu_d_req_wr_byte_en)) ? cpu_d_req_wr_byte_en :  cpu_d_req_wr_byte_en_int;
      assign cpu_d_req_rd_byte_en_sel    = (cpu_d_wr_rd_state == BH_INIT) & ((&cpu_d_req_wr_byte_en) | (~|cpu_d_req_wr_byte_en)) ? cpu_d_req_rd_byte_en :  cpu_d_req_rd_byte_en_int;    
      assign cpu_d_req_wr_data_sel       = (cpu_d_wr_rd_state == BH_INIT) & ((&cpu_d_req_wr_byte_en) | (~|cpu_d_req_wr_byte_en)) ? cpu_d_req_wr_data    :  cpu_d_req_wr_data_reg;       
      assign cpu_d_req_addr_sel          = (cpu_d_wr_rd_state == BH_INIT)                                                        ? cpu_d_req_addr       :  cpu_d_req_addr_reg;
  end else begin : ngen_lmem_byte_shim
	  assign req_wr_byte_en_mux_sel      = req_wr_byte_en_mux;
      assign cpu_d_req_wr_byte_en_sel    = cpu_d_req_wr_byte_en;
      assign cpu_d_req_rd_byte_en_sel    = cpu_d_req_rd_byte_en;    
      assign cpu_d_req_wr_data_sel       = cpu_d_req_wr_data;                
      assign cpu_d_req_addr_sel          = cpu_d_req_addr;
  end
  endgenerate
  
  assign cpu_d_req_ready             =  (cpu_d_req_wr_byte_en == 4'b1111 | cpu_d_req_wr_byte_en == 4'b0000 ) & (cpu_d_wr_rd_state == BH_INIT)   ? lmem_src_gnt[1]  : (cpu_d_wr_rd_state == BH_WRITE) ? resp_dest[1] : 1'b0; 
  assign cpu_d_resp_valid            =                                                                         (cpu_d_wr_rd_state == BH_INIT)   ? resp_dest[1]     : (cpu_d_wr_rd_state == BH_WRITE) ? resp_dest[1] : 1'b0; 
  assign cpu_d_req_rd_byte_en_int    = ((cpu_d_req_wr_byte_en != 4'b1111 & cpu_d_req_wr_byte_en != 4'b0000 ) & (cpu_d_wr_rd_state == BH_INIT))  ? 4'b1111          : 4'b0000;

  always @(posedge clk or negedge resetn)
    begin
      if(~resetn) begin
          cpu_d_req_addr_reg       <= {LMEM_ADDR_WIDTH{1'b0}};
          cpu_d_req_wr_data_reg    <= {32{1'b0}};
          cpu_d_req_wr_byte_en_reg <= 4'b0000;
          cpu_d_req_wr_byte_en_int <= 4'b0000;
          cpu_d_wr_rd_state        <= BH_INIT;
      end else begin
          case (cpu_d_wr_rd_state)
               BH_INIT : begin
                          if((cpu_d_req_wr_byte_en != 4'b1111 & cpu_d_req_wr_byte_en != 4'b0000 ) & (cpu_d_req_valid)) begin
                              cpu_d_req_addr_reg       <= cpu_d_req_addr;
                              cpu_d_req_wr_data_reg    <= cpu_d_req_wr_data;
                              cpu_d_req_wr_byte_en_reg <= cpu_d_req_wr_byte_en;
                              cpu_d_req_wr_byte_en_int <= 4'b0000;
                              cpu_d_wr_rd_state        <= BH_READ;
                          end else begin
                              cpu_d_wr_rd_state <= BH_INIT;
                          end
                        end
               BH_READ : begin
                          if(resp_dest[1]) begin
                              cpu_d_req_wr_data_reg[31:24] <= (cpu_d_req_wr_byte_en_reg[3]) ? cpu_d_req_wr_data_reg[31:24] : cpu_d_resp_rd_data[31:24];
                              cpu_d_req_wr_data_reg[23:16] <= (cpu_d_req_wr_byte_en_reg[2]) ? cpu_d_req_wr_data_reg[23:16] : cpu_d_resp_rd_data[23:16];
                              cpu_d_req_wr_data_reg[15:8 ] <= (cpu_d_req_wr_byte_en_reg[1]) ? cpu_d_req_wr_data_reg[15:8 ] : cpu_d_resp_rd_data[15:8 ];
                              cpu_d_req_wr_data_reg[ 7:0 ] <= (cpu_d_req_wr_byte_en_reg[0]) ? cpu_d_req_wr_data_reg[ 7:0 ] : cpu_d_resp_rd_data[ 7:0 ];
                              cpu_d_req_wr_byte_en_int     <= 4'b1111;
                              cpu_d_wr_rd_state            <= BH_WRITE;
                          end else begin
                              cpu_d_wr_rd_state <= BH_READ;
                          end
                        end
             BH_WRITE : begin
                          if(resp_dest[1]) begin
                              cpu_d_req_wr_byte_en_int <= 4'b0000;
                              cpu_d_wr_rd_state        <= BH_INIT;
                          end else begin
                              cpu_d_wr_rd_state <= BH_WRITE;
                          end
                        end
              default : begin
                          cpu_d_req_addr_reg       <= {LMEM_ADDR_WIDTH{1'b0}};
                          cpu_d_req_wr_data_reg    <= {32{1'b0}};
                          cpu_d_req_wr_byte_en_reg <= 4'b0000;
                          cpu_d_req_wr_byte_en_int <= 4'b0000;
                          cpu_d_wr_rd_state        <= BH_INIT;
                        end
          endcase
      end
    end
////////////////////////////////////////////////////////////////////////////////////////// 

// CPU I
  generate if(CPU_I_PRESENT) begin : gen_cpu_i_req
    assign req_valid[0]         = cpu_i_req_valid & ~lmem_cpu_access_disable_reg;
    assign cpu_i_req_ready      = lmem_src_gnt[0];
    //assign req_rd_byte_en[0]    = cpu_i_req_rd_byte_en;
    assign req_wr_byte_en[0]    = {4{1'b0}};
    assign req_read[0]          = 1'b1;
    assign req_write[0]         = 1'b0;
    assign req_addr[0]          = cpu_i_req_addr;
    //assign req_addr_p[0]        = cpu_i_req_addr_p;
    assign req_wr_data[0]       = {32{1'b0}};
    assign req_wr_data_p[0]     = {4{1'b0}};
    assign cpu_i_resp_valid     = resp_dest[0];
    assign cpu_i_resp_error     = 1'b0;  // REVISIT
    assign cpu_i_resp_rd_data   = resp_rd_data;  
    assign cpu_i_resp_rd_data_p = resp_rd_data_p;   
  end else begin :ngen_cpu_i_req
    assign req_valid[0]         = 1'b0;
    assign cpu_i_req_ready      = 1'b0;
    //assign req_rd_byte_en[0]    = {4{1'b0}};
    assign req_wr_byte_en[0]    = {4{1'b0}};
    assign req_read[0]          = 1'b0;
    assign req_write[0]         = 1'b0;
    assign req_addr[0]          = {LMEM_ADDR_WIDTH{1'b0}};
    //assign req_addr_p[0]        = 1'b0;
    assign req_wr_data[0]       = {32{1'b0}};
    assign req_wr_data_p[0]     = {4{1'b0}};
    assign cpu_i_resp_valid     = 1'b0;
    assign cpu_i_resp_error     = 1'b0;  
    assign cpu_i_resp_rd_data   = {32{1'b0}};
    assign cpu_i_resp_rd_data_p = {4{1'b0}};
  end
  endgenerate
// CPU D
  generate if(CPU_D_DEBUG_PRESENT) begin : gen_cpu_d_req
	  assign req_valid[1]         = cpu_d_req_valid & ~lmem_cpu_access_disable_reg;
	//assign cpu_d_req_ready       = lmem_src_gnt[1];
    //assign req_rd_byte_en[1]    = cpu_d_req_rd_byte_en_sel;
    assign req_wr_byte_en[1]    = cpu_d_req_wr_byte_en_sel;
    assign req_read[1]          = |cpu_d_req_rd_byte_en_sel; // REVISIT replace these with term generated directly from cpu_d_req_read via shim 
    assign req_write[1]         = |cpu_d_req_wr_byte_en_sel; // REVISIT replace these with term generated directly from cpu_d_req_write via shim 
    assign req_addr[1]          = cpu_d_req_addr_sel;
    //assign req_addr_p[1]        = cpu_d_req_addr_p;  
    assign req_wr_data[1]       = cpu_d_req_wr_data_sel;
    assign req_wr_data_p[1]     = cpu_d_req_wr_data_p;  
    //assign cpu_d_resp_valid     = resp_dest[1];
    assign cpu_d_resp_error     = 1'b0;  
    assign cpu_d_resp_rd_data   = resp_rd_data;  
    assign cpu_d_resp_rd_data_p = resp_rd_data_p; 
  end else begin :ngen_cpu_d_req
    assign req_valid[1]         = 1'b0;
    //assign cpu_d_req_ready      = 1'b0;
    //assign req_rd_byte_en[1]    = {4{1'b0}};
    assign req_wr_byte_en[1]    = {4{1'b0}};
    assign req_read[1]          = 1'b0;
    assign req_write[1]         = 1'b0;
    assign req_addr[1]          = {LMEM_ADDR_WIDTH{1'b0}};
    //assign req_addr_p[1]        = 1'b0;
    assign req_wr_data[1]       = {32{1'b0}};
    assign req_wr_data_p[1]     = {4{1'b0}};
    //assign cpu_d_resp_valid     = 1'b0;
    assign cpu_d_resp_error     = 1'b0;  
    assign cpu_d_resp_rd_data   = {32{1'b0}};
    assign cpu_d_resp_rd_data_p = {4{1'b0}};
  end
  endgenerate
// DAP
  generate if(UDMA_DAP_PRESENT) begin : gen_lmem_dap_req                                     
    assign req_valid[2]            = udma_dap_req_valid;                                     
    assign udma_dap_req_ready      = lmem_src_gnt[2];                                        
    //assign req_rd_byte_en[2]       = udma_dap_req_wr_byte_en;                              
    assign req_wr_byte_en[2]       = udma_dap_req_rd_byte_en;
    assign req_read[2]             = udma_dap_read;
    assign req_write[2]            = udma_dap_write;                              
    assign req_addr[2]             = udma_dap_req_addr;                                    
    //assign req_addr_p[2]           = udma_dap_req_addr_p;                                  
    assign req_wr_data[2]          = udma_dap_req_wr_data;                                 
    assign req_wr_data_p[2]        = udma_dap_req_wr_data_p;                               
    assign udma_dap_resp_valid     = resp_dest[2];                            
    assign udma_dap_resp_rd_error  = 1'b0;              // REVISIT No error possible for now                                      
    assign udma_dap_resp_rd_data   = resp_rd_data;                                           
    assign udma_dap_resp_rd_data_p = resp_rd_data_p;                                         
  end else begin :ngen_lmem_dap_req                                                          
    assign req_valid[2]            = 1'b0;                                                   
    assign udma_dap_req_ready      = 1'b0;                                               
    //assign req_rd_byte_en[2]       = {4{1'b0}};
    assign req_wr_byte_en[2]       = {4{1'b0}};
    assign req_read[2]             = 1'b0;
    assign req_write[2]            = 1'b0;
    assign req_addr[2]             = {LMEM_ADDR_WIDTH{1'b0}};
    //assign req_addr_p[2]           = 1'b0;
    assign req_wr_data[2]          = {32{1'b0}};
    assign req_wr_data_p[2]        = {4{1'b0}};
    assign udma_dap_resp_valid     = 1'b0;
    assign udma_dap_resp_rd_error  = 1'b0;  
    assign udma_dap_resp_rd_data   = {32{1'b0}};
    assign udma_dap_resp_rd_data_p = {4{1'b0}};
  end
  endgenerate
  
  assign lmem_src_req = req_valid;

  MIV_RV32IMC_rr_pri_arb
  //***************************************************************
  // Parameter description
  #(
    .NUM_REQS                  (3),
    .USE_FORMAL                (1),
    .USE_SIM                   (1)
   )

  u_lmem_req_arb
  //***************************************************************
  // Signal description
  (
    .resetn              (resetn),
    .clk                 (clk),
    .unlock              (1'b1),
    .req                 (lmem_src_req),
    .gnt                 (lmem_src_gnt),
    .sel_seq             (),                  //open
    .sel_early           ()                   //open
  );
  
  always @*
  begin : raddr_mux_loop
    integer i;
    req_wr_byte_en_mux   = {4{1'b0}};
    //req_rd_byte_en_mux   = {4{1'b0}};
    //req_write_mux        = 1'b0;
    //req_read_mux         = 1'b0;
    req_addr_mux         = {LMEM_ADDR_WIDTH{1'b0}};
    //req_addr_p_mux       = 1'b0;
    req_wr_data_mux      = {32{1'b0}};
    req_wr_data_p_mux    = {4{1'b0}};
    for(i=0; i<3; i=i+1)
    begin                                                                                      
      req_wr_byte_en_mux   = req_wr_byte_en_mux | ({4{lmem_src_gnt[i]}} & req_wr_byte_en[i]);   
      //req_rd_byte_en_mux   = req_rd_byte_en_mux | ({4{lmem_src_gnt[i]}} & req_rd_byte_en[i]); 
      //req_write_mux        = req_write_mux      | lmem_src_gnt[i] & req_write[i];
      //req_read_mux         = req_read_mux       | lmem_src_gnt[i] & req_read[i];
      req_addr_mux         = req_addr_mux       | ({LMEM_ADDR_WIDTH{lmem_src_gnt[i]}} & req_addr[i]);       
      //req_addr_p_mux       = req_addr_p_mux     | (lmem_src_gnt[i] & req_addr_p[i]);     
      req_wr_data_mux      = req_wr_data_mux    | ({32{lmem_src_gnt[i]}} & req_wr_data[i]);    
      req_wr_data_p_mux    = req_wr_data_p_mux  | ({4{lmem_src_gnt[i]}} & req_wr_data_p[i]);  
    end
  end
  
  assign req_valid_mux = |lmem_src_gnt; 
  
  // keep a list of requests to RAM so know where to send response
  // only one request outstanding for sysnchronous RAM with a single pipeline delay.
  // Requester must be able to accept the response immediately (no buffering here)
  // REVIST add source bit for uDMA/DAP
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
    begin
      resp_dest        <= 3'b000;
    end
    else
    begin
      resp_dest        <= lmem_src_gnt;
    end
  end   
  
  assign trx_os_d_rd = 1'b0; // REVISIT
  assign trx_os_d_wr = 1'b0; // REVISIT 
  
  
  // RAM
  //-----------
  
  generate if(USE_RAM_PARITY_BITS) begin : gen_ram_data_parity
    assign wr_data_comb                   = {req_wr_data_p_mux,req_wr_data_mux};
    assign {resp_rd_data_p,resp_rd_data}  = rd_data_comb;
  end
  else begin : gen_ram_data_no_parity
    assign wr_data_comb   = req_wr_data_mux;
    assign resp_rd_data   = rd_data_comb;
    assign resp_rd_data_p = {4{1'b0}};
  end
  endgenerate
  
  generate
  if(ECC_ENABLE)
    begin : lmem_ram_ecc
      MIV_RV32IMC_dpr_hqa_dual_storage_rbcw
      //******************************************************************
      // Parameter description
      #(
        .RAM_DEPTH                     (RAM_DEPTH),
        .ADDR_WIDTH                    (LMEM_ADDR_WIDTH),
        .DATA_WIDTH                    (RAM_DATA_WIDTH)
       )
      u_lmem_ecc_0
      //******************************************************************
      // Signal description
      (
        .arstb                          (resetn),
        .aclk                           (clk),
        .aaddr                          (req_addr_mux),
        .aceb                           (req_valid_mux),
        .aweb                           (req_wr_byte_en_mux_sel),
        .brstb                          (1'b0),
        .bclk                           (1'b0),
        .baddr                          (0),
        .bceb                           (1'b0),
        .bweb                           (1'b0),
        .ret1n                          (1'b1),
        .pg_override                    (1'b0),
        .ecc_bypass                     (1'b0),
        .ram_err_inject                 (2'b00),
        .adin                           (wr_data_comb),
        .adout                          (rd_data_comb),
        .bdin                           (32'b0),
        .bdout                          (),
        .ecc_aerr                       (), // open
        .ecc_aerr_int                   (ecc_err),  // open
        .ecc_berr                       (), // open
        .ecc_berr_int                   ()  // open
      );  
      
      always @ (*) begin
        if (!resetn) begin
            ecc_err_reg[0] <= 0;
            ecc_err_reg[1] <= 0;
        end else begin
            if (ecc_err[0] && (cpu_i_resp_valid || cpu_d_resp_valid) && req_read) begin
                ecc_err_reg[0] <= 1;
            end else begin
                ecc_err_reg[0] <= 0;
            end
           if (ecc_err[1] && (cpu_i_resp_valid || cpu_d_resp_valid) && req_read) begin
                ecc_err_reg[1] <= 1;
            end else begin
                ecc_err_reg[1] <= 0;
            end  
        end
      end
       
      assign ecc_err_correctable    = ecc_err[0];
      assign ecc_err_uncorrectable  = ecc_err[1];
	  
	  
      assign lmem_ram_sb_out = {RAM_SB_OUT_WIDTH{1'b0}};
    end else begin : lmem_ram
      // *******************************************************
      // Instantiate technology/implementation specific RAM here
      // *******************************************************
    
      MIV_RV32IMC_ram_singleport_addreg
      //******************************************************************
      // Parameter description
      #(
        .RAM_DEPTH                     (RAM_DEPTH),
        .ADDR_WIDTH                    (LMEM_ADDR_WIDTH-4),
        .DATA_WIDTH                    (RAM_DATA_WIDTH),
    	.WEN_WIDTH                     (RAM_WEN_WIDTH),
        .RAM_SB_IN_WIDTH               (RAM_SB_IN_WIDTH),
        .RAM_SB_OUT_WIDTH              (RAM_SB_OUT_WIDTH)
       )
    
      u_ram_0
      //******************************************************************
      // Signal description
      (
        .rstb                          (resetn),
        .clk                           (clk),
        .addr                          (req_addr_mux[LMEM_ADDR_WIDTH-5:0]),
        .ce                            (req_valid_mux),
        .we                            (req_wr_byte_en_mux_sel),
        .ret1n                         (1'b1),
        .pg_override                   (1'b0),
        .ecc_bypass                    (1'b0),
        .ram_err_inject                (2'b00),
        .din                           (wr_data_comb),
        .dout                          (rd_data_comb),
        .ecc_err                       (), // open
        .ecc_err_int                   (),  // open
        .ram_sb_out                    (lmem_ram_sb_out),
        .ram_sb_in                     (lmem_ram_sb_in)
      );
      
      assign ecc_err_correctable    = 1'b0;
      assign ecc_err_uncorrectable  = 1'b0;
      assign ecc_err                = 1'b0;
      assign ecc_err_reg            = 2'b0;
	end
  endgenerate
//******************************************************************************
// properties
`ifdef OPSRV_RTL_PROPS

  // requester must be able to accept a response
                                                     
                                                    
  // a request will eventually be granted (unless access disabled)                                                 

`endif 

endmodule


`default_nettype wire
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_lmem_dap_apb_slv.sv
//
//   Purpose:
//    opsrv APB slave for local memory direct access.
//    Also provides access to the uDMA control registers to allow
//    External use without OPSRV CPU.  
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module MIV_RV32IMC_opsrv_lmem_dap_apb_slv
//********************************************************************************
// Parameter description

  #(   
    parameter CPU_ADDR_WIDTH        = 32,
    parameter LMEM_DAP_ADDR_WIDTH   = 32,
    parameter LMEM0_ADDR_WIDTH      = 16,
    parameter LMEM1_ADDR_WIDTH      = 16,
    parameter UDMA_CTRL_ADDR_WIDTH  = 12

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,

    // Control/status/config    
    input wire logic                             opsrv_parity_en,   
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_udma_ctrl_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_udma_ctrl_end_addr, 
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_lmem0_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_lmem0_end_addr,  
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_lmem1_start_addr,
    input wire  logic [CPU_ADDR_WIDTH-1:0]       cfg_lmem_dap_lmem1_end_addr, 
    
    // APB Slave interface
    input wire  logic [LMEM_DAP_ADDR_WIDTH-1:0]  paddr, 
    input wire  logic                            paddr_p,
    input wire  logic [2:0]                      pprot,     //unsused
    input wire  logic                            psel,
    input wire  logic                            penable, 
    input wire  logic                            pwrite, 
    input wire  logic [31:0]                     pwdata,
    input wire  logic [3:0]                      pwdata_p,    
    output      logic                            pready, 
    output      logic [31:0]                     prdata,
    output      logic [3:0]                      prdata_p, 
    output      logic                            pslverr,
    
        // local memory 0 direct access port
      
    output     logic                             lmem0_dap_req_valid,
    input wire logic                             lmem0_dap_req_ready, 
    output     logic [3:0]                       lmem0_dap_req_rd_byte_en,  
    output     logic [3:0]                       lmem0_dap_req_wr_byte_en,
    output     logic [LMEM0_ADDR_WIDTH-1:0]      lmem0_dap_req_addr,
    output     logic                             lmem0_dap_req_addr_p,
    output     logic [31:0]                      lmem0_dap_req_wr_data,
    output     logic [3:0]                       lmem0_dap_req_wr_data_p,
    input wire logic                             lmem0_dap_resp_valid,
    output     logic                             lmem0_dap_resp_ready,
    input wire logic                             lmem0_dap_resp_rd_error,
    input wire logic [31:0]                      lmem0_dap_resp_rd_data,  
    input wire logic [3:0]                       lmem0_dap_resp_rd_data_p,
    
        // local memory  1 direct access port
 
    output     logic                             lmem1_dap_req_valid,
    input wire logic                             lmem1_dap_req_ready, 
    output     logic [3:0]                       lmem1_dap_req_rd_byte_en,  
    output     logic [3:0]                       lmem1_dap_req_wr_byte_en,
    output     logic [LMEM1_ADDR_WIDTH-1:0]      lmem1_dap_req_addr,
    output     logic                             lmem1_dap_req_addr_p,
    output     logic [31:0]                      lmem1_dap_req_wr_data,
    output     logic [3:0]                       lmem1_dap_req_wr_data_p,
    input wire logic                             lmem1_dap_resp_valid,
    output     logic                             lmem1_dap_resp_ready,
    input wire logic                             lmem1_dap_resp_rd_error,
    input wire logic [31:0]                      lmem1_dap_resp_rd_data,  
    input wire logic [3:0]                       lmem1_dap_resp_rd_data_p,
    
        // uDMA control interface
    output      logic                            udma_ctrl_req_valid,
    input wire  logic                            udma_ctrl_req_ready, 
    output      logic [3:0]                      udma_ctrl_req_rd_byte_en,  
    output      logic [3:0]                      udma_ctrl_req_wr_byte_en,
    output      logic [UDMA_CTRL_ADDR_WIDTH-1:0] udma_ctrl_req_addr,
    output      logic                            udma_ctrl_req_addr_p,
    output      logic [31:0]                     udma_ctrl_req_wr_data,
    output      logic [3:0]                      udma_ctrl_req_wr_data_p,
    input wire  logic                            udma_ctrl_resp_valid,
    output      logic                            udma_ctrl_resp_ready,
    input wire  logic                            udma_ctrl_resp_rd_error,
    input wire  logic [31:0]                     udma_ctrl_resp_rd_data,
    input wire  logic [3:0]                      udma_ctrl_resp_rd_data_p
    
  );

//********************************************************************************
// Declarations

// localparams



// Internal nets

  logic                            dap_req_is_lmem0_slv;
  logic                            dap_req_is_lmem1_slv;
  logic                            dap_req_is_udma_slv;
  

//********************************************************************************
// Main code
//********************************************************************************

// REVISIT
	
// APB Outputs
    assign pready =   (dap_req_is_lmem0_slv) ? lmem0_dap_resp_valid     : 
                      (dap_req_is_lmem1_slv) ? lmem1_dap_resp_valid     : 
                      (dap_req_is_udma_slv ) ? udma_ctrl_resp_valid     : 1'b0;
    assign prdata =   (dap_req_is_lmem0_slv) ? lmem0_dap_resp_rd_data   : 
                      (dap_req_is_lmem1_slv) ? lmem1_dap_resp_rd_data   : 
                      (dap_req_is_udma_slv ) ? udma_ctrl_resp_rd_data   : 32'b0;
    assign prdata_p = (dap_req_is_lmem0_slv) ? lmem0_dap_resp_rd_data_p : 
                      (dap_req_is_lmem1_slv) ? lmem1_dap_resp_rd_data_p : 
                      (dap_req_is_udma_slv ) ? udma_ctrl_resp_rd_data_p : 4'b0;
    assign pslverr =  (dap_req_is_lmem0_slv) ? lmem0_dap_resp_rd_error  : 
                      (dap_req_is_lmem1_slv) ? lmem1_dap_resp_rd_error  : 
                      (dap_req_is_udma_slv ) ? udma_ctrl_resp_rd_error  : 4'b0;

// LMEM0
    assign dap_req_is_lmem0_slv     = (paddr[LMEM_DAP_ADDR_WIDTH-1:12] >= cfg_lmem_dap_lmem0_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                      (paddr[LMEM_DAP_ADDR_WIDTH-1:12] <= cfg_lmem_dap_lmem0_end_addr[CPU_ADDR_WIDTH-1:12]);  

    assign lmem0_dap_req_valid      = (dap_req_is_lmem0_slv) ? penable & psel              : 1'b0;
    assign lmem0_dap_req_rd_byte_en = (dap_req_is_lmem0_slv) ? {4{!pwrite}}                : 4'b0;  
    assign lmem0_dap_req_wr_byte_en = (dap_req_is_lmem0_slv) ? {4{pwrite}}                 : 4'b0;  
    assign lmem0_dap_req_addr       = (dap_req_is_lmem0_slv) ? paddr[LMEM_DAP_ADDR_WIDTH-1:0] : {LMEM0_ADDR_WIDTH{1'b0}};
    assign lmem0_dap_req_addr_p     = (dap_req_is_lmem0_slv) ? paddr_p                     : 1'b0;
    assign lmem0_dap_req_wr_data    = (dap_req_is_lmem0_slv) ? pwdata                      : 32'b0;
    assign lmem0_dap_req_wr_data_p  = (dap_req_is_lmem0_slv) ? pwdata_p                    : 32'b0;
    assign lmem0_dap_resp_ready     = (dap_req_is_lmem0_slv) ? 1'b1                        : 1'b0;
      

// LMEM1
    assign dap_req_is_lmem1_slv       = (paddr[LMEM_DAP_ADDR_WIDTH-1:12] >= cfg_lmem_dap_lmem1_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                        (paddr[LMEM_DAP_ADDR_WIDTH-1:12] <= cfg_lmem_dap_lmem1_end_addr[CPU_ADDR_WIDTH-1:12]);  

    assign lmem1_dap_req_valid      = (dap_req_is_lmem1_slv) ? penable & psel              : 1'b0;
    assign lmem1_dap_req_rd_byte_en = (dap_req_is_lmem1_slv) ? {4{!pwrite}}                : 4'b0;  
    assign lmem1_dap_req_wr_byte_en = (dap_req_is_lmem1_slv) ? {4{pwrite}}                 : 4'b0;  
    assign lmem1_dap_req_addr       = (dap_req_is_lmem1_slv) ? paddr[LMEM_DAP_ADDR_WIDTH-1:0] : {LMEM1_ADDR_WIDTH{1'b0}};
    assign lmem1_dap_req_addr_p     = (dap_req_is_lmem1_slv) ? paddr_p                     : 1'b0;
    assign lmem1_dap_req_wr_data    = (dap_req_is_lmem1_slv) ? pwdata                      : 32'b0;
    assign lmem1_dap_req_wr_data_p  = (dap_req_is_lmem1_slv) ? pwdata_p                    : 32'b0;
    assign lmem1_dap_resp_ready     = (dap_req_is_lmem1_slv) ? 1'b1                        : 1'b0;


// UDMA
    assign dap_req_is_udma_slv       = (paddr[LMEM_DAP_ADDR_WIDTH-1:12] >= cfg_lmem_dap_udma_ctrl_start_addr[CPU_ADDR_WIDTH-1:12]) &  
                                       (paddr[LMEM_DAP_ADDR_WIDTH-1:12] <= cfg_lmem_dap_udma_ctrl_end_addr[CPU_ADDR_WIDTH-1:12]);  

    assign udma_ctrl_req_valid       = (dap_req_is_udma_slv) ? penable & psel                  : 1'b0;
    assign udma_ctrl_req_rd_byte_en  = (dap_req_is_udma_slv) ? {4{!pwrite}}                    : 4'b0;  
    assign udma_ctrl_req_wr_byte_en  = (dap_req_is_udma_slv) ? {4{pwrite}}                     : 4'b0;  
    assign udma_ctrl_req_addr        = (dap_req_is_udma_slv) ? paddr[LMEM_DAP_ADDR_WIDTH-1:0]  : {UDMA_CTRL_ADDR_WIDTH{1'b0}};
    assign udma_ctrl_req_addr_p      = (dap_req_is_udma_slv) ? paddr_p                         : 1'b0;
    assign udma_ctrl_req_wr_data     = (dap_req_is_udma_slv) ? pwdata                          : 32'b0;
    assign udma_ctrl_req_wr_data_p   = (dap_req_is_udma_slv) ? pwdata_p                        : 32'b0;
    assign udma_ctrl_resp_ready      = (dap_req_is_udma_slv) ? 1'b1                            : 1'b0;

endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_dummy_ram.sv
//
//   Purpose:
//    opsrv dummy RAM (placeholder)
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

`ifdef RAM_BIST_VIEW_BEHAV
`define RAM_BIST_VIEW 1
`elsif RAM_BIST_VIEW_FPGA
`define RAM_BIST_VIEW 2
`else
`define RAM_BIST_VIEW 0
`endif


module  MIV_RV32IMC_opsrv_dummy_ram
//********************************************************************************
// Parameter description

  #(
    parameter RAM_DEPTH            = 4096,
    parameter ADDR_WIDTH           = 12  ,
    parameter DATA_WIDTH           = 36,
    parameter WEN_WIDTH            = 4,
    parameter RAM_SB_IN_WIDTH      = 4,
    parameter RAM_SB_OUT_WIDTH      = 4
  )

//********************************************************************************
// Port description

  (
    input  wire logic                           rstb,
    input  wire logic                           clk,
    input  wire logic [ADDR_WIDTH-1:0]          addr,
    input  wire logic                           ce,
    input  wire logic [WEN_WIDTH-1:0]           we,
    input  wire logic                           ret1n,
    input  wire logic                           pg_override,
    input  wire logic                           ecc_bypass,
    input  wire logic [2-1:0]                   ram_err_inject,
    input  wire logic [DATA_WIDTH-1:0]          din,
    output      logic [DATA_WIDTH-1:0]          dout,
    output      logic [2-1:0]                   ecc_err,
    output      logic [2-1:0]                   ecc_err_int,
    input  wire logic [RAM_SB_IN_WIDTH-1: 0]    ram_sb_in,
    output      logic [RAM_SB_OUT_WIDTH-1: 0]   ram_sb_out

  );
//********************************************************************************
// Declarations

// localparams



// Internal nets
   reg [ADDR_WIDTH-1:0] addr_reg;
   reg [DATA_WIDTH - 1:0] mem [65536:0] ;
   //wire ECC_LMEM_0_ERR_NET;



//********************************************************************************
// Main code
//********************************************************************************


  //  assign ecc_err = ECC_LMEM_0_ERR_NET;
  assign ecc_err = 2'b0; // tied to 0
  assign ecc_err_int = 2'b0;// tied to 0
  assign ram_sb_out = {RAM_SB_OUT_WIDTH{1'b0}}; // Signal temp tied to 0, DCS to assign registered o/p.

  generate
  if(WEN_WIDTH == 1) begin
    always@(posedge clk)
    begin
        addr_reg <= addr;
        if(we[0]) mem[addr[ADDR_WIDTH-1:0] >> 2][31:0] <= din[31:0];
    end
  end else begin 
    always@(posedge clk)
    begin
        addr_reg <= addr;
        if(we[3]) mem[addr[ADDR_WIDTH-1:0] >> 2][31:24] <= din[31:24];
        if(we[2]) mem[addr[ADDR_WIDTH-1:0] >> 2][23:16] <= din[23:16];
        if(we[1]) mem[addr[ADDR_WIDTH-1:0] >> 2][15:8 ] <= din[15:8 ];
        if(we[0]) mem[addr[ADDR_WIDTH-1:0] >> 2][ 7:0 ] <= din[ 7:0 ];
    end
  end
  endgenerate
    assign dout = mem[addr_reg[ADDR_WIDTH-1:0] >> 2];

endmodule


`default_nettype wire

////////////////////////////////////////////////////////////////////////////////
//                              PMC-Sierra, Inc.                              //
//                                                                            //
//                               Copyright 2010                               //
//                            All Rights Reserved                             //
//                         CONFIDENTIAL & PROPRIETARY                         //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_macros.sv
//
//   Purpose:
//    Macros for OPSrv
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`ifdef LW10_62_60_OPSRV_MACROS
`else
  `define LW10_62_60_OPSRV_MACROS 1
  `define LW10_62_60_OPSRV_MACRO_MAX(a,b) (a)>(b)?(a):(b)
`endif

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug.sv
//
//   Purpose:
//    opsrv debug unit
//    Contains :
//      - OPSRV debug module
//      - OPSRV debug interface
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none
//localparam L_XLEN =32;
//`include "MIV_RV32IMC_opsrv_debug_pkg.sv"
import MIV_RV32IMC_opsrv_debug_pkg::*;

module  MIV_RV32IMC_opsrv_debug
//********************************************************************************
// Parameter description
   #( parameter l_opsrv_cfg_submicron_debug = 1)


//********************************************************************************
// Port description

  (
// clocks/resets
    input  wire logic                    clk,
    input  wire logic                    resetn,
// external jtag interface    
    input wire  logic                    jtag_trst,
    input wire  logic                    jtag_tck,
    input wire  logic                    jtag_tdi,
    input wire  logic                    jtag_tms,
    output      logic                    jtag_tdo,
    output      logic                    jtag_tdo_dr,
// core debug unit interface    
    output logic                         debug_reset, 
    output logic                         debug_core_reset,
    output logic                         debug_sys_reset,
    output logic                         debug_active,
    
    output logic [L_XLEN-1:0]            debug_op_wr_data, // muxed write o/p for CSR\GPR 
    
    output logic                         debug_csr_valid,          //***New***// assert this when debug_csr_wr_en | debug_csr_rd_en asserted          
    input  wire  logic                   debug_csr_ready, 
    output logic                         debug_csr_wr_en, 
    output logic                         debug_csr_rd_en, 
    output logic [11:0]                  debug_csr_addr,     
    input  wire  logic [L_XLEN-1:0]      debug_csr_rd_data, 
    input  wire  logic                   debug_csr_rd_data_valid,  //***New***// This is the data valid qualifier for CSR reads as requested 
    output logic                         debug_csr_rd_data_ready,  //***New***// Indicates read data can be accepted - doesn't do anything in the core 
                                                                                 // for now as the core always expects debuuger can accept data for requests 
                                                                                 // it makes, so tie to 1 or assert in debug mode, or something like that 
                                                                                      
    output logic                         debug_gpr_valid,          //***New***// assert this when debug_gpr_wr_en | debug_gpr_rd_en asserted        
    input  wire  logic                   debug_gpr_ready, 
    output logic                         debug_gpr_wr_en, 
    output logic                         debug_gpr_rd_en, 
    output logic [4:0]                   debug_gpr_addr,
    input  wire  logic [L_XLEN-1:0]      debug_gpr_rd_data, 
    input  wire  logic                   debug_gpr_rd_data_valid,  //***New***// This is the data valid qualifier for GPR reads as requested 
    output logic                         debug_gpr_rd_data_ready,  //***New***// Indicates read data can be accepted - doesn't do anything in the core 
                                                                                 // for now as the core always expects debuuger can accept data for requests 
                                                                                 // it makes, so tie to 1 or assert in debug mode, or something like that  
    output logic                         debug_halt_req,   
    input  wire  logic                   debug_halt_ack, 
    output logic                         debug_resethalt_req,   
    //input  wire  logic                   debug_resethalt_ack, 
    output logic                         debug_resume_req,   
    input  wire  logic                   debug_resume_ack,
    input  wire  logic                   debug_mode,
    input wire  logic                    debug_trx_os,
// system bus interface  
    output      logic                    debug_sysbus_req_valid,
    input wire  logic                    debug_sysbus_req_ready, 
    output      logic [3:0]              debug_sysbus_req_rd_byte_en,  
    output      logic [3:0]              debug_sysbus_req_wr_byte_en,
    output      logic [31:0]             debug_sysbus_req_addr,
    output      logic [31:0]             debug_sysbus_req_wr_data,
    input wire  logic                    debug_sysbus_resp_valid,
    output      logic                    debug_sysbus_resp_ready,
    input wire  logic                    debug_sysbus_resp_error,
    input wire  logic [31:0]             debug_sysbus_resp_rd_data 
    
  );

//********************************************************************************
// Declarations


//********************************************************************************
// Main code
//********************************************************************************

logic non_debug_reset;
logic resetb;

/*always_comb
  begin: DTM_reset // used for resethalt feature
     resetb = 1'b0;
    if (debug_resethalt_req)
        resetb = 1'b1;
    else
        resetb = resetn;
  end
*/
assign resetb = resetn;
assign debug_reset = ~debug_active;
assign debug_core_reset = non_debug_reset;
assign debug_sys_reset = non_debug_reset;


// TCK clk domain
//logic io_output_reset_tckd;   
logic io_dataChainOut_shift_tckd;   
logic io_dataChainOut_data_tckd;   
logic io_dataChainOut_capture_tckd;  
logic io_dataChainOut_update_tckd;  
logic io_dataChainIn_data_tckd ;

// DBG clk domain
//logic io_output_reset_dbgd;   
logic io_dataChainOut_shift_dbgd;   
logic io_dataChainOut_capture_dbgd;  
logic io_dataChainOut_update_dbgd;  
logic io_dataChainIn_data_out_dbgd;
logic io_dataChainOut_data_in_dbgd;

// DMI Signals
logic dmi_resp;
logic dmi_req;
logic dmi_wr;
logic [DBG_DMI_ADDR_WIDTH-1:0] dmi_addr;
logic [31:0] dmi_rdata;
logic [31:0] dmi_wdata;
logic dmi_ch_sel_in;
logic [1:0]dmi_ch_id_in;
logic dmi_ch_sel_out;    
logic [1:0]dmi_ch_id_out; 
// JTAG Tap instance

MIV_RV32IMC_opsrv_debug_jtag_tap #( .l_opsrv_cfg_submicron_debug(l_opsrv_cfg_submicron_debug)) 
    /*# (
    .IR_REG_WIDTH                (IR_REG_WIDTH),
    .DR_REG_WIDTH                (DR_REG_WIDTH),
    .ACTIVE_HIGH_RESET           (0)
   )*/ MIV_RV32IMC_opsrv_debug_jtag_tap_0 (
    // Inputs
    .TCLK                        (jtag_tck),
    .TRSTB                       (jtag_trst),
    .TMS                         (jtag_tms),
    .TDI                         (jtag_tdi),
      
    // Outputs 
    .TDO                         (jtag_tdo),
    .TDO_driven                  (jtag_tdo_dr),
    
    
    .io_dataChainOut_shift       (io_dataChainOut_shift_tckd),   
    .io_dataChainOut_data        (io_dataChainOut_data_tckd),    
    .io_dataChainOut_capture     (io_dataChainOut_capture_tckd),  
    .io_dataChainOut_update      (io_dataChainOut_update_tckd),  
    .io_dataChainIn_data         (io_dataChainIn_data_tckd),
    .dmi_ch_sel                  (dmi_ch_sel_in),
    .dmi_ch_id                   (dmi_ch_id_in));


// JTAG CDC instance

MIV_RV32IMC_opsrv_debug_cdc #(.l_opsrv_cfg_submicron_debug(l_opsrv_cfg_submicron_debug)) MIV_RV32IMC_opsrv_debug_cdc_0(   
    //Clocks & Resets                          
    .clk                         (clk),
    .resetb                      (resetb),
    .TCK                         (jtag_tck),
    .TRSTB                       (jtag_trst),
      
	// TCLK Domain 
    .io_dataChainIn_data_in      (io_dataChainOut_data_tckd ),      
    .io_dataChainOut_shift_in    (io_dataChainOut_shift_tckd),   
    .io_dataChainOut_data_out    (io_dataChainIn_data_tckd),    
    .io_dataChainOut_capture_in  (io_dataChainOut_capture_tckd),  
    .io_dataChainOut_update_in   (io_dataChainOut_update_tckd),   
    .dmi_ch_sel_in               (dmi_ch_sel_in),                
    .dmi_ch_id_in                (dmi_ch_id_in),                
	
	// clock Domain
    .io_dataChainIn_data_out     (io_dataChainIn_data_out_dbgd),      
    .io_dataChainOut_shift_out   (io_dataChainOut_shift_dbgd),   
    .io_dataChainOut_data_in     (io_dataChainOut_data_in_dbgd),     
    .io_dataChainOut_capture_out (io_dataChainOut_capture_dbgd), 
    .io_dataChainOut_update_out  (io_dataChainOut_update_dbgd),     
    .dmi_ch_sel_out              (dmi_ch_sel_out),    
    .dmi_ch_id_out               (dmi_ch_id_out));


// JTAG Debug Module Interface instance

MIV_RV32IMC_opsrv_debug_dmi MIV_RV32IMC_opsrv_debug_dmi_0 (
    .resetb                      (resetb),
    .clk                         (clk),
    .dtm_ch_sel                  (dmi_ch_sel_out),
    .dtm_ch_id                   (dmi_ch_id_out), 
    .io_dataChainOut_capture     (io_dataChainOut_capture_dbgd),// from synchronizer
    .io_dataChainOut_shift       (io_dataChainOut_shift_dbgd),// from synchronizer
    .io_dataChainOut_update      (io_dataChainOut_update_dbgd),// from synchronizer
    .io_dataChainOut_data        (io_dataChainIn_data_out_dbgd ),// from synchronizer
    .io_dataChainIn_data         (io_dataChainOut_data_in_dbgd),// from synchronizer
    .resp                        (dmi_resp), // to DM
    .rdata                       (dmi_rdata),// to DM
    .req                         (dmi_req),// to DM
    .wr                          (dmi_wr),// to DM
    .addr                        (dmi_addr),// to DM
    .wdata                       (dmi_wdata));// to DM



// JTAG Debug Module

MIV_RV32IMC_opsrv_debug_du MIV_RV32IMC_opsrv_debug_du_0(
    .clk                         (clk),
    .resetb                      (resetb),
    
    // DMI Signals
    .dmi_resp                    (dmi_resp),
    .dmi_req                     (dmi_req),
    .dmi_wr                      (dmi_wr),
    .dmi_addr                    (dmi_addr),
    .dmi_rdata                   (dmi_rdata),
    .dmi_wdata                   (dmi_wdata),
   

    .debug_op_wr_data           (debug_op_wr_data),
    
    .debug_csr_valid             (debug_csr_valid),
    .debug_csr_ready             (debug_csr_ready),
    .debug_csr_wr_en             (debug_csr_wr_en),
    .debug_csr_rd_en             (debug_csr_rd_en),
    .debug_csr_addr              (debug_csr_addr),
    .debug_csr_rd_data           (debug_csr_rd_data),
    .debug_csr_rd_data_valid     (debug_csr_rd_data_valid),
    .debug_csr_rd_data_ready     (debug_csr_rd_data_ready),
    
    .debug_gpr_valid             (debug_gpr_valid),
    .debug_gpr_ready             (debug_gpr_ready),
    .debug_gpr_wr_en             (debug_gpr_wr_en),
    .debug_gpr_rd_en             (debug_gpr_rd_en),
    .debug_gpr_addr              (debug_gpr_addr),
    .debug_gpr_rd_data           (debug_gpr_rd_data),
    .debug_gpr_rd_data_valid     (debug_gpr_rd_data_valid),
    .debug_gpr_rd_data_ready     (debug_gpr_rd_data_ready),


    // SBA Signals
    .sba_req_ready               (debug_sysbus_req_ready), 
    .sba_req_valid               (debug_sysbus_req_valid), 
    .sba_req_addr                (debug_sysbus_req_addr),
    .sba_req_wr_data             (debug_sysbus_req_wr_data),
    .sba_req_wr_byte_en          (debug_sysbus_req_wr_byte_en),
    .sba_req_rd_byte_en          (debug_sysbus_req_rd_byte_en),
    .sba_resp_valid              (debug_sysbus_resp_valid),
    .sba_resp_ready              (debug_sysbus_resp_ready),
    .sba_resp_error              (debug_sysbus_resp_error),
    .sba_resp_rd_data            (debug_sysbus_resp_rd_data),

    // Ext Pipe Signals
    .debug_trx_os                (debug_trx_os),
    .debug_active                (debug_active),
    .nondebug_reset              (non_debug_reset),
    .debug_mode                  (debug_mode),
    .debug_halt_req              (debug_halt_req),
    .debug_halt_ack              (debug_halt_ack), // HART -> DM
    .debug_resume_req            (debug_resume_req),    
    .debug_resume_ack            (debug_resume_ack),
    .debug_resethalt_req         (debug_resethalt_req)
    //.debug_resethalt_ack         (debug_resethalt_ack)
    );
    
endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug_cdc.sv
//
//   Purpose:
//    opsrv debug unit
//    Contains :
//      - OPSRV debug module clk domain crossing
//      
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none
import MIV_RV32IMC_opsrv_debug_pkg::*;

module MIV_RV32IMC_opsrv_debug_cdc #( parameter l_opsrv_cfg_submicron_debug = 1) (   
   input wire clk,
   input wire resetb,
   
   input wire TCK,
   input wire TRSTB,
   
   // TCK Domain
   input wire                   io_dataChainIn_data_in,
   input wire                   io_dataChainOut_shift_in,   
   input wire                   io_dataChainOut_capture_in,  
   input wire                   io_dataChainOut_update_in,   
   input wire                   dmi_ch_sel_in,                
   input wire[1:0]              dmi_ch_id_in,                 
   output    logic              io_dataChainOut_data_out,    
   
   // clk Domain Outputs
   output logic                    io_dataChainIn_data_out,  
   output logic                    io_dataChainOut_shift_out,   
   output logic                    io_dataChainOut_capture_out, 
   output logic                    io_dataChainOut_update_out,  
   output logic                    dmi_ch_sel_out,          
   output logic [1:0]              dmi_ch_id_out,           
   input  wire                     io_dataChainOut_data_in      
);


////////////////////////////////////////////////////////////////////////////////
// Parameters
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Port directions
////////////////////////////////////////////////////////////////////////////////
 


////////////////////////////////////////////////////////////////////////////////
// Internal signal declarations
////////////////////////////////////////////////////////////////////////////////


logic[2:0]              io_dataChainIn_data_reg     ;
logic[2:0]              io_dataChainOut_shift_reg   ;
logic[2:0]              io_dataChainOut_capture_reg ;

logic tap_rst;

logic[1:0] tck_reg;
logic tck_reg_last;

logic tck_posedge_pulse;
logic tck_negedge_pulse;

////////////////////////////////////////////////////////////////////////////////
// Assignments
////////////////////////////////////////////////////////////////////////////////

assign tck_posedge_pulse        = (&tck_reg) && !tck_reg_last;
assign tck_negedge_pulse        = (~|tck_reg) && tck_reg_last;

////////////////////////////////////////////////////////////////////////////////
// Logic
////////////////////////////////////////////////////////////////////////////////

generate if (l_opsrv_cfg_submicron_debug)
    if (ACTIVE_HIGH_RESET == 1)
      begin : active_high_TRST
           assign tap_rst = !TRSTB;
      end
    else
      begin : active_low_TRST
           assign tap_rst = TRSTB;
      end
endgenerate 
    

always_ff @(posedge clk) //, negedge resetb
  begin
    if(!resetb) begin
        tck_reg      <= 2'b0;
        tck_reg_last <= 1'b0;
    end else begin
        tck_reg      <= {tck_reg[0], TCK};
        tck_reg_last <= tck_reg[1]; 
    end
  end
  
always_ff @(negedge TCK or negedge tap_rst) //#k
  begin
    if(!tap_rst) begin        
        io_dataChainOut_shift_reg[0]   <= 1'b0;
        io_dataChainOut_capture_reg[0] <=  1'b0;
    end else begin
        io_dataChainOut_shift_reg[0]   <= io_dataChainOut_shift_in;
        io_dataChainOut_capture_reg[0] <= io_dataChainOut_capture_in;
    end
  end

always_ff @(posedge clk) //, negedge resetb
  begin
    if(!resetb) begin
        io_dataChainOut_shift_reg[2:1]   <= {1'b0, 1'b0};
        io_dataChainOut_capture_reg[2:1] <= {1'b0, 1'b0};
        io_dataChainIn_data_reg[2:0]     <= {1'b0, 1'b0, 1'b0};
    end else begin
        io_dataChainOut_shift_reg[2:1]   <= {io_dataChainOut_shift_reg[1],   io_dataChainOut_shift_reg[0]};
        io_dataChainOut_capture_reg[2:1] <= {io_dataChainOut_capture_reg[1], io_dataChainOut_capture_reg[0]};  
        io_dataChainIn_data_reg          <= {io_dataChainIn_data_reg[1],     io_dataChainIn_data_reg[0],     io_dataChainIn_data_in};
            
    end
  end
  
always_ff @(posedge clk, negedge tap_rst) //negedge resetb,
  begin
    if(!resetb) begin
        dmi_ch_sel_out                  <= 1'b0;
        dmi_ch_id_out                   <= 2'b0;

        end 
    else 
    if (!tap_rst) begin
        dmi_ch_sel_out                  <= 1'b0;
        dmi_ch_id_out                   <= 2'b0;

        end
    else 
    begin
         if(tck_posedge_pulse) begin
             dmi_ch_sel_out                  <= dmi_ch_sel_in;             
             dmi_ch_id_out                   <= dmi_ch_id_in;  

         end 
    end
  end
  
always_ff @(posedge clk, negedge resetb)
  begin
    if(!resetb) begin
        io_dataChainIn_data_out      <= 1'b0;
        io_dataChainOut_shift_out    <= 1'b0;
        io_dataChainOut_capture_out  <= 1'b0;
    end else begin
         if(tck_posedge_pulse) begin
             io_dataChainIn_data_out      <= io_dataChainIn_data_reg[2];    
             io_dataChainOut_shift_out    <= io_dataChainOut_shift_reg[2];  
             io_dataChainOut_capture_out  <= io_dataChainOut_capture_reg[2];
         end else begin
             io_dataChainIn_data_out      <= 1'b0;
             io_dataChainOut_shift_out    <= 1'b0;
             io_dataChainOut_capture_out  <= 1'b0;
         end
    end
  end

always_ff @(posedge clk, negedge resetb)
  begin
    if(!resetb) begin
        io_dataChainOut_update_out <= 1'b0;
        io_dataChainOut_data_out <= 1'b0;
    end else begin
         if(tck_negedge_pulse) begin
             io_dataChainOut_update_out <= io_dataChainOut_update_in; 
             io_dataChainOut_data_out <= io_dataChainOut_data_in;			 
         end else begin
             io_dataChainOut_update_out <= 1'b0;
             io_dataChainOut_data_out <= io_dataChainOut_data_out;
         end
    end
  end
endmodule// tiny_cdc
`default_nettype wire
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug_dmi.sv
//
//   Purpose:
//    opsrv debug unit
//    Contains :
//      - OPSRV debug module interface
//
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
`default_nettype none

//`include "MIV_RV32IMC_opsrv_debug_pkg.sv"
import MIV_RV32IMC_opsrv_debug_pkg::*;

module MIV_RV32IMC_opsrv_debug_dmi (
   input wire                                   resetb,
   input wire                                   clk,
   input wire                                   dtm_ch_sel,
   input wire        [1:0]                      dtm_ch_id, 
   input wire                                   io_dataChainOut_capture,
   input wire                                   io_dataChainOut_shift,
   input wire                                   io_dataChainOut_update,
   input wire                                   io_dataChainOut_data,
   input wire                                   resp,
   input wire        [DBG_DMI_DATA_WIDTH-1:0]   rdata,
   output    logic                              io_dataChainIn_data,
   output    logic                              req,
   output    logic                              wr,
   output    logic   [DBG_DMI_ADDR_WIDTH-1:0]   addr,
   output    logic   [DBG_DMI_DATA_WIDTH-1:0]   wdata
);



localparam  DBG_DMI_OP_WIDTH   = 6'd2;
localparam  DBG_DMI_DATA_WIDTH = 6'd32;
localparam  DBG_DMI_ADDR_WIDTH = 6'd7;


// DTMS
localparam                                          DTMCS_RESERVEDB_HI = 5'd31;
localparam                                          DTMCS_RESERVEDB_LO = 5'd18;
localparam                                          DTMCS_DMIHARDRESET = 5'd17;
localparam                                          DTMCS_DMIRESET     = 5'd16;
localparam                                          DTMCS_RESERVEDA    = 5'd15;
localparam                                          DTMCS_IDLE_HI      = 5'd14;
localparam                                          DTMCS_IDLE_LO      = 5'd12;
localparam                                          DTMCS_DMISTAT_HI   = 5'd11;
localparam                                          DTMCS_DMISTAT_LO   = 5'd10;
localparam                                          DTMCS_ABITS_HI     = 5'd9;
localparam                                          DTMCS_ABITS_LO     = 5'd4;
localparam                                          DTMCS_VERSION_HI   = 5'd3;
localparam                                          DTMCS_VERSION_LO   = 5'd0;

// DMI
localparam                                          DMI_OP_LO   = 5'd0;
localparam                                          DMI_OP_HI   = DMI_OP_LO + DBG_DMI_OP_WIDTH - 1;
localparam                                          DMI_DATA_LO = DMI_OP_HI + 1;
localparam                                          DMI_DATA_HI = DMI_DATA_LO + DBG_DMI_DATA_WIDTH - 1;
localparam                                          DMI_ADDR_LO = DMI_DATA_HI + 1;
localparam                                          DMI_ADDR_HI = DMI_ADDR_LO + DBG_DMI_ADDR_WIDTH - 1;


logic [DBG_DMI_DATA_WIDTH-1:0]                        dmi_rdata;

// TAP
logic  [40:0]                                         tap_dr_shift;
logic  [40:0]                                         tap_dr_rdata;
logic  [40:0]                                         tap_dr;

// clk enable
logic                                                clk_en_dmi_rdata;
logic                                                clk_en_tap_dr;

// *****************************************************************************
// TAP interface
// *****************************************************************************

always_comb
 begin
     io_dataChainIn_data = tap_dr[0];
 end


always_comb
 begin
    tap_dr_rdata = 41'b0;
    tap_dr_shift = 41'b0;  //ts

    if( dtm_ch_id == 2'd1 ) begin
        tap_dr_rdata[ DTMCS_RESERVEDB_HI : DTMCS_RESERVEDB_LO ] = 1'b0;
        tap_dr_rdata[ DTMCS_DMIHARDRESET ]                      = 1'b0;
        tap_dr_rdata[ DTMCS_DMIRESET ]                          = 1'b0;
        tap_dr_rdata[ DTMCS_RESERVEDA ]                         = 1'b0;
        tap_dr_rdata[ DTMCS_IDLE_HI    : DTMCS_IDLE_LO ]        = 3'd0;  //ts
        // Status of dmi operation is always success because of current DM implementation
        tap_dr_rdata[ DTMCS_DMISTAT_HI : DTMCS_DMISTAT_LO ]     = 1'b0;
        tap_dr_rdata[ DTMCS_ABITS_HI   : DTMCS_ABITS_LO ]       = 6'd7;
        tap_dr_rdata[ DTMCS_VERSION_HI : DTMCS_VERSION_LO ]     = 3'b1;  //ts

        tap_dr_shift =  {io_dataChainOut_data, 10'b0, tap_dr[30:1]}; 
    end else begin
        tap_dr_rdata[ DMI_ADDR_HI : DMI_ADDR_LO ] = 1'b0;
        tap_dr_rdata[ DMI_DATA_HI : DMI_DATA_LO ] = dmi_rdata;
        // Status of dmi operation is always success because of current DM implementation
        tap_dr_rdata[ DMI_OP_HI   : DMI_OP_LO ]   = 1'b0;

        tap_dr_shift =  { io_dataChainOut_data,
                              tap_dr[40:1] };
    end
 end

// clk enable logic
always_comb
 begin
    clk_en_tap_dr = io_dataChainOut_capture | io_dataChainOut_shift;
 end

// TAP data register
always_ff @(posedge clk, negedge resetb)
 begin
    if (~resetb) begin
        tap_dr <= 40'b0;
    end
    else begin
        if( clk_en_tap_dr ) begin
            if( io_dataChainOut_capture ) begin
                tap_dr <= tap_dr_rdata;
            end else if( io_dataChainOut_shift ) begin
                tap_dr <= tap_dr_shift;
            end
        end
    end
 end
 
// *****************************************************************************
// Debug Module Interface (DMI)
// *****************************************************************************

always_comb
 begin
    req           = 1'b0;
    wr            = 1'b0;
    addr          = 1'b0;
    wdata         = 1'b0;
    
    if( io_dataChainOut_update & dtm_ch_sel  &  dtm_ch_id == 2'd2 ) begin
        req           = tap_dr[ DMI_OP_HI   : DMI_OP_LO ] != 2'b00;
        wr            = tap_dr[ DMI_OP_HI   : DMI_OP_LO ] == 2'b10;
        addr          = tap_dr[DMI_ADDR_HI : DMI_ADDR_LO];
        wdata         = tap_dr[DMI_DATA_HI : DMI_DATA_LO];
    end
 end

// clk enable logic
always_comb
 begin
    clk_en_dmi_rdata = req & resp & ~wr;
 end
 
// DMI read data storage
always_ff @(posedge clk, negedge resetb)
 begin
    if (~resetb) 
     begin
        dmi_rdata <= 32'h0;
     end
    else
     begin
        if( clk_en_dmi_rdata )
         begin
            dmi_rdata <= rdata;
         end
     end
 end

endmodule // tiny_dmi

`default_nettype wire
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug_du.sv
//
//   Purpose:
//    opsrv debug unit
//    Contains :
//      - OPSRV debug module debug unit
//      - OPSRV debug module debug sba
//
//
//
//
//   Author:
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// default net type..
// include package (import)
// use seperate package for DU.
`default_nettype none

import MIV_RV32IMC_opsrv_debug_pkg::*;


module MIV_RV32IMC_opsrv_debug_du(
   input wire logic clk,
   input wire logic resetb,

   // DMI Signals
   input wire  logic                   dmi_req,
   input wire  logic                   dmi_wr,
   input wire  logic [DBG_DMI_ADDR_WIDTH-1:0]  dmi_addr,
   input wire  logic [DATA_WIDTH-1:0]  dmi_wdata,
   output      logic [DATA_WIDTH-1:0]  dmi_rdata,
   output      logic                   dmi_resp,
   
   //Muxed Debug CSR\GPR write
   output      logic  [DATA_WIDTH-1:0] debug_op_wr_data, 

   // Debug CSR Signals
   
   output logic                        debug_csr_valid,
   input wire                          debug_csr_ready,
   output      logic                   debug_csr_wr_en,
   output      logic                   debug_csr_rd_en,
   output      logic  [11:0]           debug_csr_addr,
   input wire         [DATA_WIDTH-1:0] debug_csr_rd_data,
   input wire                          debug_csr_rd_data_valid,
   output      logic                   debug_csr_rd_data_ready,
   


   // Debug GPR Signals
   output logic                        debug_gpr_valid,
   input wire                          debug_gpr_ready,   
   output      logic                   debug_gpr_wr_en,
   output      logic                   debug_gpr_rd_en,
   output      logic  [4:0]            debug_gpr_addr,
   input wire         [DATA_WIDTH-1:0] debug_gpr_rd_data,   
   input wire                          debug_gpr_rd_data_valid,
   output logic                        debug_gpr_rd_data_ready,   


   //HART/Subsystem Signal
   input wire                          sba_resp_error,
   input wire         [DATA_WIDTH-1:0] sba_resp_rd_data,

   input wire                          sba_req_ready,

   input wire                          sba_resp_valid,
   output      logic                   sba_req_valid,
   output      logic  [ADDR_WIDTH-1:0] sba_req_addr,
   output      logic  [3:0]            sba_req_rd_byte_en,
   output      logic  [3:0]            sba_req_wr_byte_en,
   output      logic  [DATA_WIDTH-1:0] sba_req_wr_data,
   output      logic                   sba_resp_ready,

   // Ext Pipe Signals
   input wire                          debug_trx_os,
   input wire                          debug_halt_ack,
   input wire                          debug_resume_ack,
   //input wire                          debug_resethalt_ack,
   input wire                          debug_mode,
   output      logic                   debug_active,
   output      logic                   nondebug_reset,
   output      logic                   debug_halt_req,
   output      logic                   debug_resume_req,
   output      logic                   debug_resethalt_req
);


enum logic [5:0] {
                  INIT          = 6'b000001,
                  WR_ABST_CMD   = 6'b000010,
                  RD_ABST_CMD   = 6'b000100,
                  WR_REGNO_ADDR = 6'b001000,
                  RD_REGNO_ADDR = 6'b010000,
                  ERROR         = 6'b100000		            
                 } command_reg_state, next_state;

// debug state
// 000001 - INIT_DBG
// 000010 - RUNNING
// 000100 - HALT WAIT ACK
// 001000 - HALT STATE
// 010000 - COMMAND ACCESS STATE
// 100000 - RESUME WAIT ACT


enum logic[5:0] {
                 INIT_DBG              = 6'b000001,
                 RUNNING               = 6'b000010,
                 HALT_WAIT_ACK         = 6'b000100,
                 HALT_STATE            = 6'b001000,
                 COMMAND_ACCESS_STATE  = 6'b010000,
                 RESUME_WAIT_ACT       = 6'b100000	
               } debug_state; 

// dmi_resp tied high
assign dmi_resp = 1'b1;

logic [31:0] data_0_reg;
logic [31:0] data_csr_reg;
logic [31:0] data_gpr_reg;

// DMCONTROL
logic            dmcontrol_haltreq       ;
logic            dmcontrol_resumereq      ;
logic            dmcontrol_ackhavereset   ;
//logic            dmcontrol_setresethaltreq;
//logic            dmcontrol_clrresethaltreq;
logic            dmcontrol_ndmreset       ;
logic            dmcontrol_dmactive       ;

// DMSTATUS
logic            dmstatus_allany_havereset ;
logic            havereset_skip_pwrup      ;
logic            dmstatus_allany_resumeack ;
logic            dmstatus_allany_running   ;
logic            dmstatus_allany_halted    ;


// Abstract regs
logic [7:0]  abs_cmd_cmb;
logic [2:0]  abs_cmd_regsize_cmb;
logic        abs_cmd_transfer_cmb;
logic        abs_cmd_regwr_cmb;
logic [3:0]  abs_cmd_regtype_cmb;
logic [11:0] abs_cmd_regno_cmb;
logic        debug_cmd_access;

// Register Access.
logic dmi_req_dmcontrol      ;
logic dmi_req_command        ;
logic dmi_req_abst_data0     ;
logic dmi_req_abst           ;


logic [2:0] abstractcs_cmderr;
logic [2:0] abstractcs_cmderr_cmb;
logic abstractcs_busy;
logic abstractcs_busy_cmb;
logic abstractcs_busyerr_cmb;
logic abstractcs_busyerr;


// DM Clock Enable
logic clk_en_dm;
logic clk_en_dm_cmb;

logic [31:0] mem_rdata;
logic debug_halt_req_comb;
logic debug_resume_req_comb;

assign  dmi_req_dmcontrol   = (dmi_addr == DMCONTROL_ADDR) & dmi_req ? 'b1:'b0;
assign  dmi_req_abst        = (dmi_addr == ABST_CONTROL_AND_STATUS_ADDR) & dmi_req ? 'b1:'b0;
assign  dmi_req_abst_data0  = (dmi_addr == ABS_DATA_0_ADDR) & dmi_req ? 'b1:'b0;
assign  dmi_req_command     = (dmi_addr == ABST_COMMAND_ADDR) & dmi_req ? 'b1:'b0;
assign dmstatus_allany_running = ~dmstatus_allany_halted;


MIV_RV32IMC_opsrv_debug_sba MIV_RV32IMC_opsrv_debug_sba_0(
    .clk                         (clk),
    .resetb                      (resetb),
    .sba_en                      (dmcontrol_dmactive),
    .halted                      (debug_mode),
    .trx_os                      (debug_trx_os),

    // DMI Signals
    //.mem_resp                    (), // Not used, dmi_resp tied high in du
    .mem_req                     (dmi_req),
    .mem_wr                      (dmi_wr),
    .mem_addr                    (dmi_addr),
    .mem_rdata                   (mem_rdata),
    .mem_wdata                   (dmi_wdata),

    // SBA Signals
    .sba_req_ready               (sba_req_ready), 
    .sba_req_valid               (sba_req_valid), 
    .sba_req_addr                (sba_req_addr),
    .sba_req_rd_byte_en          (sba_req_rd_byte_en),
    .sba_req_wr_byte_en          (sba_req_wr_byte_en),
    .sba_req_wr_data             (sba_req_wr_data),
    .sba_resp_valid              (sba_resp_valid),
    .sba_resp_ready              (sba_resp_ready),
    .sba_resp_error              (sba_resp_error),
    .sba_resp_rd_data            (sba_resp_rd_data));


always_comb
   begin

   case(dmi_addr)
      ABST_CONTROL_AND_STATUS_ADDR:
         begin
            dmi_rdata[31:29]  = ABSTRACTCS_RESERVEDD; 
            dmi_rdata[28:24]  = ABSTRACTCS_PROGBUFSIZE;
            dmi_rdata[23:13]  = ABSTRACTCS_RESERVEDC;
            dmi_rdata[12]     = abstractcs_busy;
            dmi_rdata[11]     = ABSTRACTCS_RESERVEDB;
            dmi_rdata[10:8]   = abstractcs_cmderr;
            dmi_rdata[7:4]    = ABSTRACTCS_RESERVEDA;
            dmi_rdata[3:0]    = ABSTRACTCS_DATACOUNT;
         end
       DMCONTROL_ADDR:
         begin
            dmi_rdata[31]     = dmcontrol_haltreq;
            dmi_rdata[30]     = dmcontrol_resumereq;
            dmi_rdata[29]     = DMCONTROL_HARTRESET;
            dmi_rdata[28]     = dmcontrol_ackhavereset;
            dmi_rdata[27]     = DMCONTROL_RESERVEDB;
            dmi_rdata[26]     = DMCONTROL_HASEL;
            dmi_rdata[25:16]  = DMCONTROL_HARTSELLO;
            dmi_rdata[15:6]   = DMCONTROL_HARTSELHI;
            dmi_rdata[5:2]    = DMCONTROL_RESERVEDA;
            dmi_rdata[1]      = dmcontrol_ndmreset;
            dmi_rdata[0]      = dmcontrol_dmactive;
         end
      DMSTATUS_ADDR:
         begin
            dmi_rdata[31:23]  = DMSTATUS_RESERVEDC;
            dmi_rdata[22]     = DMSTATUS_IMPEBREAK;
            dmi_rdata[21:0]   = DMSTATUS_RESERVEDB;
            dmi_rdata[19]     = dmstatus_allany_havereset;
            dmi_rdata[18]     = dmstatus_allany_havereset;
            dmi_rdata[17]     = dmstatus_allany_resumeack;
            dmi_rdata[16]     = dmstatus_allany_resumeack;
            dmi_rdata[15]     = DMSTATUS_ALLANYNONEXIST;
            dmi_rdata[14]     = DMSTATUS_ALLANYNONEXIST;
            dmi_rdata[13]     = DMSTATUS_ALLANYUNAVAIL;
            dmi_rdata[12]     = DMSTATUS_ALLANYUNAVAIL;
            dmi_rdata[11]     = dmstatus_allany_running;
            dmi_rdata[10]     = dmstatus_allany_running;
            dmi_rdata[9]      = dmstatus_allany_halted;
            dmi_rdata[8]      = dmstatus_allany_halted;
            dmi_rdata[7]      = DMSTATUS_AUTHENTICATED;
            dmi_rdata[6]      = DMSTATUS_AUTHBUSY;
            dmi_rdata[5]      = DMSTATUS_HASRESETHALTREQ;
            dmi_rdata[4]      = DMSTATUS_CONFSTRPTRVALID;
            dmi_rdata[3:0]    = DMSTATUS_VERSION;
         end
      ABS_DATA_0_ADDR:
         begin
            dmi_rdata = data_0_reg;
         end
      HALT_SUM_0_ADDR:
         begin
            dmi_rdata = {31'b0,dmstatus_allany_halted};
         end
      HALT_SUM_1_ADDR:
         begin
            dmi_rdata = {31'b0,dmstatus_allany_halted};
         end
      SBA_CONTROL_AND_STATUS_ADDR:
        begin
            dmi_rdata = mem_rdata;
        end
      SYS_BUS_ADDR_0_ADDR:
        begin
            dmi_rdata = mem_rdata;
        end
      SYS_BUS_DATA_0_ADDR:
        begin
            dmi_rdata = mem_rdata;
        end
      default:
         begin
            dmi_rdata[31:0] = 32'b0;
         end
    endcase
    end


// debugger active output
assign debug_active = clk_en_dm;

// Reset Controls

// Clock enable and DM reset 
always@( posedge clk or negedge resetb)
begin
   if (~resetb)
      begin
         dmcontrol_dmactive <= 1'b0;
         clk_en_dm          <= 1'b0;
      end
   else if( clk_en_dm_cmb )
      begin
         if( dmi_req_dmcontrol & dmi_wr )
            begin
               dmcontrol_dmactive <= dmi_wdata[0];
            end
      clk_en_dm <= dmcontrol_dmactive;
      end
end

assign clk_en_dm_cmb = (dmi_req_dmcontrol & dmi_wr) |
                             dmcontrol_dmactive | clk_en_dm;

// External Reset Request( Not the Debug Module)
always@( posedge clk or negedge resetb)
   begin
      if (~resetb)
         begin
            dmcontrol_ndmreset        <= 1'b0;
            dmcontrol_ackhavereset    <= 1'b0;
         end
      else if( clk_en_dm_cmb )
         begin
            if( ~dmcontrol_dmactive )
               begin
                  dmcontrol_ndmreset        <= 1'b0;
                  dmcontrol_ackhavereset    <= 1'b0;
               end
      else
         begin
            if( dmi_req_dmcontrol & dmi_wr )
               begin
                  dmcontrol_ndmreset <= dmi_wdata[1];
                  // Clear sticky NotDM reset status
                  dmcontrol_ackhavereset <= dmi_wdata[28];
               end
         end
      end
   end

// External Reset status
always @(posedge clk or negedge resetb)
   begin
      if( ~resetb )
         begin
            havereset_skip_pwrup      <= 1'b1;
            dmstatus_allany_havereset <= 1'b0;
         end
      else if( clk_en_dm_cmb )
         begin
            if( ~dmcontrol_dmactive )
               begin
                  havereset_skip_pwrup      <= 1'b1;
                  dmstatus_allany_havereset <= 1'b0;
               end
      else
         begin
            if( havereset_skip_pwrup )
               begin
                  havereset_skip_pwrup <= debug_state == INIT_DBG & ~dmcontrol_ndmreset;
               end

            if( ~havereset_skip_pwrup & debug_state == INIT_DBG )
               begin
                  dmstatus_allany_havereset <= 1'b1;
               end
            else if( dmcontrol_ackhavereset )
               begin
                  dmstatus_allany_havereset <= 1'b0;
               end
         end
      end
   end

// Reset signal for system controlled by Debug Module
assign nondebug_reset     = dmcontrol_ndmreset;

/* // Resethalt feature controls
always_ff @(posedge clk, negedge resetb)
 begin
   if( ~resetb ) 
      begin
         dmcontrol_setresethaltreq             <= 1'd0;
         dmcontrol_clrresethaltreq             <= 1'd0;
      end 
   else if( clk_en_dm_cmb )
      begin
         if( ~dmcontrol_dmactive ) 
            begin
               dmcontrol_setresethaltreq       <= 1'd0;
               dmcontrol_clrresethaltreq       <= 1'd0;
            end
         else 
            begin
               if( dmi_req_dmcontrol & dmi_wr )
                  begin
                     dmcontrol_setresethaltreq <= dmi_wdata[3];
                     dmcontrol_clrresethaltreq <= dmi_wdata[2];
                  end
            end
      end
 end
*/



// Halt/Resume Control.
always_ff @(posedge clk, negedge resetb)
 begin
   if( ~resetb) 
      begin
         dmcontrol_haltreq         <= 1'd0;
         dmcontrol_resumereq       <= 1'd0;
      end 
   else if( clk_en_dm_cmb )
      begin
         if( ~dmcontrol_dmactive ) 
            begin
               dmcontrol_haltreq         <= 1'd0;
               dmcontrol_resumereq       <= 1'd0;
            end
         else 
            begin
               if( dmi_req_dmcontrol & dmi_wr )
                  begin
                     dmcontrol_haltreq   <= dmi_wdata[31];
                     dmcontrol_resumereq <= dmi_wdata[30];
                  end
            end
      end
 end

// Halt status
always_ff @(posedge clk, negedge resetb)
begin
   if( ~resetb )
      begin
         dmstatus_allany_halted <= 1'd0;
      end
   else if( clk_en_dm_cmb )
      begin
         if( ~dmcontrol_dmactive )
            begin
               dmstatus_allany_halted <= 1'd0;
            end
         else
            begin
               if( debug_state == HALT_STATE ) //Debug Halted State
                  begin
                     dmstatus_allany_halted <= 1'b1;
                  end
                  else if(debug_state == RUNNING ) // Debug Run State 
                     begin
                        dmstatus_allany_halted <= 1'b0;
                     end
            end
      end
end

// Resume status
always_ff @(posedge clk, negedge resetb)
begin
   if( ~resetb ) begin
      dmstatus_allany_resumeack <= 1'd0;
   end
   else if( clk_en_dm_cmb )
      begin
         if( ~dmcontrol_dmactive )
            begin
               dmstatus_allany_resumeack <= 1'd0;
            end
         else
            begin
               if( ~dmcontrol_resumereq )
                  begin
                     dmstatus_allany_resumeack <= 1'b0;
                  end
               else if( debug_state == RUNNING && dmcontrol_resumereq == 1'b1 ) // Debug Run State
                  begin
                     dmstatus_allany_resumeack <= 1'b1;
                  end
            end
         end
end

// Abstract Control and Status //
logic [2:0] cmderr_cmb ;
logic [2:0] cmderr_ff ;


// Abstract Command // Decode and Execute Reads and Writes of GPRs and CSRs.
// ----------------
logic [31:0] command_reg;
logic [31:0] command_cmb;
logic abs_cmd_regsize_valid_cmb;

assign command_cmb               = dmi_req_command ? dmi_wdata[31:0] : command_reg[31:0];

assign abs_cmd_cmb               = dmi_req_command ? dmi_wdata[31:24] : command_reg[31:24];
assign abs_cmd_regsize_cmb       = dmi_req_command ? dmi_wdata[22:20] : command_reg[22:20];
assign abs_cmd_transfer_cmb      = dmi_req_command ? dmi_wdata[17]    : command_reg[17];
assign abs_cmd_regwr_cmb         = dmi_req_command ? dmi_wdata[16]    : command_reg[16];
assign abs_cmd_regtype_cmb       = dmi_req_command ? dmi_wdata[15:12] : command_reg[15:12];
assign abs_cmd_regno_cmb         = dmi_req_command ? dmi_wdata[0+:12] : command_reg[0+:12];

assign abs_cmd_regsize_valid_cmb = abs_cmd_regsize_cmb == 3'd2;




////////////////////////////////
// New Abstract Command FSM
////////////////////////////////
logic valid_read, valid_write;
logic access_reg_valid;
logic abs_cmd_transfer_ff;


//Registers initialized  when ~dmactive
always_ff @(posedge clk, negedge resetb)
   begin
      if( ~resetb) begin
        command_reg_state <= INIT;
        abs_cmd_transfer_ff <= 'b0;
        abstractcs_cmderr <= 3'b000;
        cmderr_ff <= 3'b000;
        command_reg <= 'b0;
        abstractcs_busy <= 1'b0;
        abstractcs_busyerr <= 1'b0;
      end
    else   
      if( clk_en_dm_cmb ) begin
        if( ~dmcontrol_dmactive) begin
          command_reg_state <= INIT;
          abs_cmd_transfer_ff <= 'b0;
          abstractcs_cmderr <= 3'b000;
          cmderr_ff <= 3'b000;
          command_reg <= 'b0;
          abstractcs_busy <= 1'b0;
          abstractcs_busyerr <= 1'b0;
         end
        else
         begin
            command_reg_state <= next_state;
            abs_cmd_transfer_ff <= abs_cmd_transfer_cmb;
            abstractcs_cmderr <= abstractcs_cmderr_cmb;
            cmderr_ff <= cmderr_cmb;
            command_reg <= command_cmb;
            abstractcs_busy <= abstractcs_busy_cmb;
            abstractcs_busyerr <= abstractcs_busyerr_cmb;
         end
        end
   end

assign access_reg_valid = abs_cmd_cmb == 8'd0 & abs_cmd_regsize_valid_cmb; 
assign debug_cmd_access = debug_state == COMMAND_ACCESS_STATE ? 1'b1 : 1'b0;

assign valid_read  = access_reg_valid & debug_cmd_access & ~abs_cmd_regwr_cmb;
assign valid_write = access_reg_valid & debug_cmd_access &  abs_cmd_regwr_cmb;

assign abstractcs_busy_cmb = (dmi_req_command && ~|abstractcs_cmderr) ? 1'b1 : ((debug_csr_rd_en || debug_csr_wr_en) || (debug_gpr_rd_en || debug_gpr_wr_en) || (command_reg_state == ERROR)) ? 1'b0 : abstractcs_busy; //
assign abstractcs_busyerr_cmb = (abstractcs_busy && |{(dmi_req_command && command_reg_state != INIT), dmi_req_abst, dmi_req_abst_data0}) ? 1'b1 : abstractcs_busyerr;


always_comb
  begin : command_logic

    cmderr_cmb = (dmi_req_abst && |abstractcs_cmderr) ?  (abstractcs_cmderr & ~dmi_wdata[10:8]) : cmderr_ff;
    abstractcs_cmderr_cmb =  abstractcs_busy_cmb ? abstractcs_cmderr : cmderr_ff;
    next_state = command_reg_state; 
    
      case ( command_reg_state )
         INIT:       if (debug_cmd_access && abstractcs_busy_cmb)
                        begin                        
                        if  (abs_cmd_cmb == 8'd0 && ~|abstractcs_cmderr)//   ensure no errors pending
                           begin
                              if (valid_read)
                                 begin
                                      next_state = RD_ABST_CMD;
                                 end
                              else 
                              if (valid_write)
                                 begin    
                                      next_state = WR_ABST_CMD;
                                 end
                              else
                                 begin
                                    cmderr_cmb = ABSTRACT_ERR_EXCEPTION ;
                                    next_state = ERROR;
                                 end
                           end
                        else
                           begin
                             if (abs_cmd_cmb != 8'd0)
                               begin
                                 cmderr_cmb = ABSTRACT_ERR_CMD ; // unsupported
                                 next_state = ERROR;
                               end
                             else
                             if (|{dmcontrol_haltreq, dmcontrol_resumereq, dmcontrol_ackhavereset})
                                begin
                                 cmderr_cmb = ABSTRACT_ERR_NOHALT ; // halt/resume/reset pending
                                 next_state = ERROR;
                                end
                            else
                                next_state = ERROR; // existing command errors
                           end
                        end
                     else
                        begin
                           next_state = INIT;
                        end
         RD_ABST_CMD:   if ( abs_cmd_transfer_ff )
                           begin
                              next_state = RD_REGNO_ADDR;
                           end
                        else
                           begin
                              cmderr_cmb = ABSTRACT_ERR_CMD;
                              next_state = ERROR;
                           end
         WR_ABST_CMD:   if ( abs_cmd_transfer_ff )
                           begin
                              next_state = WR_REGNO_ADDR;
                           end
                        else
                           begin
                              cmderr_cmb = ABSTRACT_ERR_CMD;
                              next_state = ERROR;
                           end
         RD_REGNO_ADDR: if ( (debug_csr_ready && debug_csr_rd_data_valid) || (debug_csr_ready && debug_gpr_rd_data_valid) )
                           begin
                              next_state = INIT;
                           end
                        else
                           begin
                              next_state = RD_REGNO_ADDR; 
                           end
         WR_REGNO_ADDR: if ( debug_csr_ready || debug_gpr_ready)
                           begin
                              next_state = INIT;
                           end
                        else
                           begin
                              next_state = WR_REGNO_ADDR; 
                           end
         ERROR:         
                        begin
                          next_state = INIT;
                        end
         default:
         	begin
              if (abstractcs_busyerr) 
                begin
                  cmderr_cmb = ABSTRACT_ERR_BUSY;
                  next_state = ERROR;
                end
              else
         		next_state = INIT;
            end
      endcase      
    end  

  

  always_ff @(posedge clk, negedge resetb)
        begin
          if (~resetb)
            begin
              debug_csr_valid           <= 1'b0;
              debug_csr_wr_en           <= 1'b0;    
              debug_csr_rd_en           <= 1'b0;    
              debug_csr_addr            <= 12'h0;
              debug_csr_rd_data_ready   <= 1'b0;    
              data_csr_reg              <= 32'h0;
                
              debug_gpr_valid           <= 1'b0;    
              debug_gpr_wr_en           <= 1'b0;    
              debug_gpr_rd_en           <= 1'b0;    
              debug_gpr_addr            <= 5'h0;
              debug_gpr_rd_data_ready   <= 1'b0;    
              data_gpr_reg              <= 32'h0;
                
              debug_op_wr_data          <= 32'b0;
            end
          else
            begin
              if (~debug_active && ~clk_en_dm)
                begin
                  debug_csr_valid           <= 1'b0;
                  debug_csr_wr_en           <= 1'b0;    
                  debug_csr_rd_en           <= 1'b0;    
                  debug_csr_addr            <= 12'h0;
                  debug_csr_rd_data_ready   <= 1'b0;    
                  data_csr_reg              <= 32'h0;
                
                  debug_gpr_valid           <= 1'b0;    
                  debug_gpr_wr_en           <= 1'b0;    
                  debug_gpr_rd_en           <= 1'b0;    
                  debug_gpr_addr            <= 5'h0;
                  debug_gpr_rd_data_ready   <= 1'b0;    
                  data_gpr_reg              <= 32'h0;
                
                  debug_op_wr_data          <= 32'b0;
                end          
              else
          case (abs_cmd_regtype_cmb)
          4'h0:
            begin //CSR read write          
              if ( command_reg_state == RD_REGNO_ADDR & debug_csr_ready )
                begin                
                  debug_csr_valid           <= 1'b1;
                  debug_csr_wr_en           <= 1'b0;
                  debug_csr_rd_en           <= 1'b1;
                  debug_csr_addr            <= abs_cmd_regno_cmb[11:0];
                  debug_csr_rd_data_ready   <= 1'b1;
                  data_csr_reg              <= debug_csr_rd_data_valid ? debug_csr_rd_data : 32'h0;
                  
                  debug_op_wr_data          <= 32'b0;

                end
              else if ( command_reg_state == WR_REGNO_ADDR & debug_csr_ready )
                begin
                  debug_csr_valid           <= 1'b1;
                  debug_csr_wr_en           <= 1'b1;
                  debug_csr_rd_en           <= 1'b0;
                  debug_csr_addr            <= abs_cmd_regno_cmb[11:0];
                  debug_csr_rd_data_ready   <= 1'b0;
                  data_csr_reg              <= 32'h0;
                  
                  debug_op_wr_data          <= data_0_reg;

                end
              else
                begin
                  debug_csr_valid           <= 1'b0;
                  debug_csr_wr_en           <= 1'b0;
                  debug_csr_rd_en           <= 1'b0;
                  debug_csr_addr            <= 12'h0;
                  debug_csr_rd_data_ready   <= 1'b0;
                  data_csr_reg              <= 32'h0;
                  
                  debug_op_wr_data          <= 32'b0;
                end
            end
            
            
          4'h1:
            begin //GPR read write 
              if ( command_reg_state == RD_REGNO_ADDR  & debug_gpr_ready )
                begin
                  debug_gpr_valid           <= 1'b1;
                  debug_gpr_wr_en           <= 1'b0;
                  debug_gpr_rd_en           <= 1'b1;
                  debug_gpr_addr            <= abs_cmd_regno_cmb[4:0];
                  debug_gpr_rd_data_ready   <= 1'b1;
                  data_gpr_reg              <= debug_gpr_rd_data_valid ? debug_gpr_rd_data : 32'h0;
                  
                  debug_op_wr_data          <= 32'b0;

                end
              else if ( command_reg_state == WR_REGNO_ADDR  & debug_gpr_ready )
                begin
                  debug_gpr_valid           <= 1'b1;
                  debug_gpr_wr_en           <= 1'b1;
                  debug_gpr_rd_en           <= 1'b0;
                  debug_gpr_addr            <= abs_cmd_regno_cmb[4:0];
                  debug_gpr_rd_data_ready   <= 1'b0;
                  data_gpr_reg              <= 32'h0;
                  
                  debug_op_wr_data          <= data_0_reg;

                end
              else
                begin
                  debug_gpr_valid           <= 1'b0;
                  debug_gpr_wr_en           <= 1'b0;
                  debug_gpr_rd_en           <= 1'b0;
                  debug_gpr_addr            <= 5'h0;
                  debug_gpr_rd_data_ready   <= 1'b0;
                  data_gpr_reg              <= 32'h0;
                  
                  debug_op_wr_data          <= 32'b0;
                end
            end
            
          default:
            begin
                debug_csr_valid           <= 1'b0;
                debug_csr_wr_en           <= 1'b0;
                debug_csr_rd_en           <= 1'b0;
                debug_csr_addr            <= 12'h0;
                debug_csr_rd_data_ready   <= 1'b0;
                data_csr_reg              <= 32'h0;
                
                debug_gpr_valid           <= 1'b0;
                debug_gpr_wr_en           <= 1'b0;
                debug_gpr_rd_en           <= 1'b0;
                debug_gpr_addr            <= 5'h0;
                debug_gpr_rd_data_ready   <= 1'b0;
                data_gpr_reg              <= 32'h0;
                
                debug_op_wr_data          <= 32'b0;
            end
          endcase
        end
    end



always_ff @(posedge clk, negedge resetb)
begin
   if (~resetb)
      begin
         data_0_reg <= 32'b0;
      end
   else
      begin
         if (~debug_active && ~clk_en_dm)
            begin
               data_0_reg <= 32'b0;
            end
         else
            if( dmi_req_abst_data0 && dmi_wr )
               begin
                  data_0_reg <= dmi_wdata;
               end
            else if ( debug_csr_rd_en )
               begin
                  data_0_reg <= data_csr_reg;
               end
            else if ( debug_gpr_rd_en )
               begin
                  data_0_reg <= data_gpr_reg;
               end
      end         
end

////////////////////////////////
// End
////////////////////////////////

// logic for resethalt 

assign debug_resethalt_req = 1'b0; // feature disabled

/*
always_ff @(posedge clk, negedge resetb)
begin
   if (~resetb)
      begin      
       debug_resethalt_req <= 1'b0;
      end
    else if (dmcontrol_clrresethaltreq)
      begin
        debug_resethalt_req <= 1'b0;
      end
   else    
      begin
         debug_resethalt_req <= dmcontrol_setresethaltreq;
      end
end
*/

// logic for halt request to exu pipe

assign debug_halt_req_comb = dmcontrol_haltreq && (debug_state ==  RUNNING | debug_state == HALT_WAIT_ACK); 


always_ff @(posedge clk, negedge resetb)
begin
   if (~resetb)
      begin
        debug_halt_req <= 1'b0;
      end
    else if (debug_halt_ack)
      begin
        debug_halt_req <= 1'b0;
      end
   else    
      begin
         debug_halt_req <= debug_halt_req_comb;
      end
end

assign debug_resume_req_comb = dmcontrol_resumereq && ~dmstatus_allany_resumeack && (debug_state ==  HALT_STATE | debug_state == RESUME_WAIT_ACT) && ~debug_trx_os;

always_ff @(posedge clk, negedge resetb)
begin
   if (~resetb)
      begin
        debug_resume_req <= 1'b0;
      end
    else if (debug_resume_ack)
      begin
        debug_resume_req <= 1'b0;
      end
   else    
      begin
         debug_resume_req <= debug_resume_req_comb;
      end
end




// Debug State Machine
always_ff @(posedge clk, negedge resetb)
  begin
    if (~resetb)
        begin
            debug_state <= INIT_DBG;
        end
    else
        begin
            case(debug_state)
                INIT_DBG:
                  begin
                     debug_state <= RUNNING;
                  end
                RUNNING: // RUNNING
                    begin
                        if ( debug_halt_req == 1'b1 )
                            begin
                                debug_state <= HALT_WAIT_ACK;
                            end
                       else if (debug_mode) // Hart entered debug mode; 1. step, 2. breakpoint 
                       begin
                           debug_state <= HALT_STATE;
                       end
                        else
                            begin
                                debug_state <= RUNNING;
                            end
                    end

                HALT_WAIT_ACK: // HALT WAIT ACK
                     begin
                        if ( debug_halt_ack == 1'b1 )
                            begin
                                debug_state <= HALT_STATE;
                            end
                        else
                            begin
                                debug_state <= HALT_WAIT_ACK;
                            end
                     end

                HALT_STATE: // HALT STATE
                     begin
                        if ( dmcontrol_resumereq == 1'b1 & ~dmstatus_allany_resumeack)

                            begin
                                debug_state <= RESUME_WAIT_ACT;
                            end
                        else
                            begin
                                if ( abstractcs_busy_cmb)
                                    begin
                                      debug_state <= COMMAND_ACCESS_STATE;                                                                
                                    end
                                else
                                if (~debug_mode & ~dmcontrol_ndmreset)
                                    begin
                                        debug_state <= RUNNING;
                                    end
                                else
                                    begin
                                        debug_state <= HALT_STATE;
                                    end
                            end
                     end

                COMMAND_ACCESS_STATE: // COMMAND ACCESS STATE
                    begin
                        if ( ~abstractcs_busy_cmb)
                            begin                        
                                debug_state <= HALT_STATE;
                            end
                        else
                            begin
                                debug_state <= COMMAND_ACCESS_STATE;
                            end
                     end

               RESUME_WAIT_ACT: // RESUME WAIT ACK
                     begin
                        if ( debug_resume_ack == 1'b1 )
                            begin
                                debug_state <= RUNNING;
                            end
                        else
                            begin
                                debug_state <= RESUME_WAIT_ACT;
                            end
                     end

                default:
                       debug_state <= INIT_DBG;
            endcase
        end
  end

endmodule//tiny_du


`default_nettype wire
// Formal Comments

/*
   - We cannot have a DMI Response without having a DMI Request (assertion ? )
   - We cannot be halted and running at the same time
   - Check that load_* only occurs when expected.

*/
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug_jtag_tap.v
//
//   Purpose:
//    opsrv debug unit jtag tap
//    Contains :
//      - OPSRV jtag tap interface
//
//      - ID_CODE needs to be consistent
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
`default_nettype none

//`include "MIV_RV32IMC_opsrv_debug_pkg.sv"
import MIV_RV32IMC_opsrv_debug_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module MIV_RV32IMC_opsrv_debug_jtag_tap #( parameter l_opsrv_cfg_submicron_debug = 1) (
   input wire  TCLK,
   input wire  TRSTB,
   input wire  TMS,
   input wire  TDI,
   
   output logic TDO,
   output logic TDO_driven,
                           
   input  wire                     io_dataChainIn_data,          
   //input  wire                     io_control_jtag_reset, // not used                                
   //output logic                    io_output_reset,                                       
   output logic                    io_dataChainOut_shift,                                 
   output logic                    io_dataChainOut_data,                                  
   output logic                    io_dataChainOut_capture,                               
   output logic                    io_dataChainOut_update,                                
          
   output logic                    dmi_ch_sel,
   output logic [1:0]              dmi_ch_id 
    
);

////////////////////////////////////////////////////////////////////////////////
// Parameters
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Port directions
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Internal signal declarations
////////////////////////////////////////////////////////////////////////////////
//logic     TDO_driven;                  
//logic     dataChainIn_data_reg;               

logic     [3:0]              currTapState;
logic     [3:0]              nextTapState;
logic                       irShift;
logic                       drShift;
logic                       irCapture;
logic                       drCapture;
logic                       irUpdate;
logic                       drUpdate;
logic     [DR_REG_WIDTH-1:0] shiftReg;
logic     [IR_REG_WIDTH-1:0] irReg;


logic [IR_REG_WIDTH-1:0]  io_output_instruction; 
//logic  tlReset;

////////////////////////////////////////////////////////////////////////////////
// TAP Control FSM
////////////////////////////////////////////////////////////////////////////////
// Current state register
generate if (l_opsrv_cfg_submicron_debug)
   begin: gen_current_state_register_active_high
    if (ACTIVE_HIGH_RESET == 1)
        begin
            always @ (posedge TCLK or posedge TRSTB)
                begin
                    if (TRSTB)
                        begin
                            currTapState <= TEST_LOGIC_RESET;
                        end
                    else
                        begin
                            currTapState <= nextTapState;
                        end
                end
        end
    else
        begin: gen_current_state_register_active_low
            always @ (posedge TCLK or negedge TRSTB)
                begin
                    if (!TRSTB)
                        begin
                            currTapState <= TEST_LOGIC_RESET;
                        end
                    else
                        begin
                            currTapState <= nextTapState;
                        end
                end
        end
   end     
endgenerate

// Combinatorial outputs
//assign tlReset   = (currTapState == TEST_LOGIC_RESET) ? 1'b1 : 1'b0;
assign drCapture = (currTapState == CAPTURE_DR)       ? 1'b1 : 1'b0;
assign drShift   = (currTapState == SHIFT_DR)         ? 1'b1 : 1'b0;
assign drUpdate  = (currTapState == UPDATE_DR)        ? 1'b1 : 1'b0;
assign irCapture = (currTapState == CAPTURE_IR)       ? 1'b1 : 1'b0;
assign irShift   = (currTapState == SHIFT_IR)         ? 1'b1 : 1'b0;
assign irUpdate  = (currTapState == UPDATE_IR)        ? 1'b1 : 1'b0;

// Next state combinatorial logic
always @ (*)
    begin
        case (currTapState)
            TEST_LOGIC_RESET: nextTapState = (!TMS) ? RUN_TEST_IDLE    : currTapState;
            RUN_TEST_IDLE:    nextTapState = (TMS)  ? SELECT_DR        : currTapState;
            SELECT_DR:        nextTapState = (!TMS) ? CAPTURE_DR       : SELECT_IR;
            CAPTURE_DR:       nextTapState = (TMS)  ? EXIT1_DR         : SHIFT_DR;
            SHIFT_DR:         nextTapState = (TMS)  ? EXIT1_DR         : currTapState;
            EXIT1_DR:         nextTapState = (TMS)  ? UPDATE_DR        : PAUSE_DR;
            PAUSE_DR:         nextTapState = (TMS)  ? EXIT2_DR         : currTapState;
            EXIT2_DR:         nextTapState = (TMS)  ? UPDATE_DR        : SHIFT_DR;
            UPDATE_DR:        nextTapState = (TMS)  ? SELECT_DR        : RUN_TEST_IDLE;
            SELECT_IR:        nextTapState = (TMS)  ? TEST_LOGIC_RESET : CAPTURE_IR;
            CAPTURE_IR:       nextTapState = (TMS)  ? EXIT1_IR         : SHIFT_IR;
            SHIFT_IR:         nextTapState = (TMS)  ? EXIT1_IR         : currTapState;
            EXIT1_IR:         nextTapState = (!TMS) ? PAUSE_IR         : UPDATE_IR;
            PAUSE_IR:         nextTapState = (TMS)  ? EXIT2_IR         : currTapState;
            EXIT2_IR:         nextTapState = (TMS)  ? UPDATE_IR        : SHIFT_IR;
            UPDATE_IR:        nextTapState = (TMS)  ? SELECT_DR        : RUN_TEST_IDLE;
        endcase
    end


////////////////////////////////////////////////////////////////////////////////
// DTM 
////////////////////////////////////////////////////////////////////////////////
// Data 
//assign io_output_reset         = tlReset;   // io.output.reset := currState === JtagState.TestLogicReset.U
assign io_dataChainOut_shift   = drShift;   // io.dataChainOut.shift := currState === JtagState.ShiftDR.U
assign io_dataChainOut_data    = TDI;       // io.dataChainOut.data := io.jtag.TDI
assign io_dataChainOut_capture = drCapture; // io.dataChainOut.capture := currState === JtagState.CaptureDR.U
assign io_dataChainOut_update  = drUpdate;  // io.dataChainOut.update := currState === JtagState.UpdateDR.U


assign dmi_ch_sel = ((io_output_instruction == DTM_CS_INSTR) || (io_output_instruction == DMI_ACCESS_INSTR)) ? 1'b1 : 1'b0;
assign dmi_ch_id =  (io_output_instruction == DTM_CS_INSTR)      ? 2'd1 :
                    (io_output_instruction == DMI_ACCESS_INSTR)  ? 2'd2 : 2'b0;

reg shiftReg_ne_0 ;//= 1'b0;
////////////////////////////////////////////////////////////////////////////////
// Shift register
////////////////////////////////////////////////////////////////////////////////
generate if (l_opsrv_cfg_submicron_debug)
   begin: gen_shift_register_active_high
    if (ACTIVE_HIGH_RESET == 1)
        begin
            always @ (posedge TCLK or posedge TRSTB)
                begin
                    if (TRSTB)
                        begin
                            shiftReg <= {DR_REG_WIDTH{1'b0}};
                        end
                    else
                        begin
                            if (irCapture)
                                begin
                                    shiftReg <= {{(DR_REG_WIDTH-1){1'b0}}, 1'b1};
                                end
                            else if (drCapture)
                                begin
                                    if (irReg == ID_CODE_INSTR)
                                        begin
                                            shiftReg <= ID_CODE;
                                        end
                                end
                            else if (irShift | drShift)
                                begin
                                    shiftReg <= {TDI, shiftReg[(DR_REG_WIDTH-1):1]};
                                end
                            else
                                begin
                                    shiftReg <= shiftReg;
                                end
                        end
                end
        end
    else
        begin:gen_shift_register_active_low
            always @ (posedge TCLK or negedge TRSTB)
                begin
                    if (!TRSTB)
                        begin
                            shiftReg <= {DR_REG_WIDTH{1'b0}};
                        end
                    else
                        begin
                            if (irCapture)
                                begin
                                    shiftReg <= {{(DR_REG_WIDTH-1){1'b0}}, 1'b1};
                                end
                            else if (drCapture)
                                begin
                                    if (irReg == ID_CODE_INSTR)
                                        begin
                                            shiftReg <= ID_CODE;
                                        end
                                end
                            else if (irShift | drShift)
                                begin
                                    shiftReg <= {TDI, shiftReg[(DR_REG_WIDTH-1):1]};
                                end
                            else
                                begin
                                    shiftReg <= shiftReg;
                                end
                        end
                end
        end
   end     
endgenerate

assign TDO = (irReg == ID_CODE_INSTR)    ? shiftReg_ne_0 : 
             (irReg == DTM_CS_INSTR)     ? io_dataChainIn_data : // dataChainIn_data_reg :
             (irReg == DMI_ACCESS_INSTR) ? io_dataChainIn_data : // dataChainIn_data_reg :
             (irReg == DMI_ACCESS_INSTR) ? io_dataChainIn_data : // dataChainIn_data_reg :
                                           shiftReg[(DR_REG_WIDTH-1)];  // BYPASS_INSTR

generate if (l_opsrv_cfg_submicron_debug)
   begin: gen_ir_and_Instruction_register_active_high
   if (ACTIVE_HIGH_RESET == 1)
     begin
       always @ (negedge TCLK or posedge TRSTB)
         begin
           if (TRSTB) begin
               //dataChainIn_data_reg <= 1'b0;
               shiftReg_ne_0 <= 1'b0;
               TDO_driven <= 1'b0;
           end else begin
               //dataChainIn_data_reg <= io_dataChainIn_data;
               shiftReg_ne_0 <= shiftReg[0];
               if(irShift || drShift) begin
                   TDO_driven <= 1'b1;
               end else begin
                   TDO_driven <= 1'b0;
               end
           end
         end
     end
   else
     begin:gen_ir_and_Instruction_register_active_low
       always @ (negedge TCLK or negedge TRSTB)
         begin
           if (!TRSTB) begin
               //dataChainIn_data_reg <= 1'b0;
               shiftReg_ne_0 <= 1'b0;
               TDO_driven <= 1'b0;
           end else begin
               //dataChainIn_data_reg <= io_dataChainIn_data;
               shiftReg_ne_0 <= shiftReg[0];
               if(irShift || drShift) begin
                   TDO_driven <= 1'b1;
               end else begin
                   TDO_driven <= 1'b0;
               end
           end
         end
     end
   end
endgenerate


////////////////////////////////////////////////////////////////////////////////
// IR & Instruction register
////////////////////////////////////////////////////////////////////////////////
generate if (l_opsrv_cfg_submicron_debug)
   begin : ir_and_Instruction_register
    if (ACTIVE_HIGH_RESET == 1)
        begin
            always @ (negedge TCLK or posedge TRSTB)
                begin
                    if (TRSTB)
                        begin
                            irReg <= {IR_REG_WIDTH{1'b0}};
                            io_output_instruction <= {IR_REG_WIDTH{1'b0}};
                        end
                    else
                        begin
                            if (irCapture)
                                begin
                                    irReg <= {{(IR_REG_WIDTH-1){1'b0}}, 1'b1};
                                end
                            else if (irUpdate)
                                begin
                                    irReg <= shiftReg[DR_REG_WIDTH-1:DR_REG_WIDTH-IR_REG_WIDTH];
                                    io_output_instruction <= shiftReg[DR_REG_WIDTH-1:DR_REG_WIDTH-IR_REG_WIDTH]; //io.output.instruction := activeInstruction
                                end
                            else
                                begin
                                    irReg <= irReg;
                                    io_output_instruction <= io_output_instruction;
                                end
                        end
                end
        end
    else
        begin:gen_ir_and_Instruction_register_active_low
            always @ (negedge TCLK or negedge TRSTB)
                begin
                    if (!TRSTB)
                        begin
                            irReg <= {IR_REG_WIDTH{1'b0}};
                            io_output_instruction <= {IR_REG_WIDTH{1'b0}}; // 
                        end
                    else
                        begin
                            if (irCapture)
                                begin
                                    irReg <= {{(IR_REG_WIDTH-1){1'b0}}, 1'b1};
                                end
                            else if (irUpdate)
                                begin
                                    irReg <= shiftReg[DR_REG_WIDTH-1:DR_REG_WIDTH-IR_REG_WIDTH];
                                    io_output_instruction <= shiftReg[DR_REG_WIDTH-1:DR_REG_WIDTH-IR_REG_WIDTH]; //io.output.instruction := activeInstruction
                                end
                            else
                                begin
                                    irReg <= irReg;
                                    io_output_instruction <= io_output_instruction;
                                end
                        end
                end
        end
   end
endgenerate

endmodule // TINY_JTAG_TAP
`default_nettype wire
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_debug_sba.sv
//
//   Purpose:
//    opsrv  DM System Bus Access
//    Contains :
//      - OPSRV debug SBA module 
//      
//   Note:  
//    mem_resp tied high in debug_du so no need to implement // commented out
//    A misaligned address error sets both sbcs_to_err (timeout) and sbcs_ba_err (bad address) bits in SBCS
//    Timeout counter present with prescaler, default 8*255 clock ticks before transaction timeout
//
//   Author: 
//
//   Version: 1.4
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// default net type..
// include package (import)
// use separate package for DU . 
`default_nettype none

import MIV_RV32IMC_opsrv_debug_pkg::*;



module MIV_RV32IMC_opsrv_debug_sba(
   input wire logic clk,
   input wire logic resetb,
   input wire logic sba_en,
   input wire logic halted,
   input wire logic trx_os,
   
   // DMI Signals
   input wire  logic                             mem_req,
   input wire  logic                             mem_wr,
   input wire  logic [DBG_DMI_ADDR_WIDTH-1:0]    mem_addr,
   input wire  logic [DBG_DMI_DATA_WIDTH-1:0]    mem_wdata,
   output      logic [DBG_DMI_DATA_WIDTH-1:0]    mem_rdata,
   //output      logic                           mem_resp,

   //HART/Subsystem Signal
   input wire                                   sba_resp_error,
   input wire         [DATA_WIDTH-1:0]          sba_resp_rd_data,
   input wire                                   sba_req_ready,  
   input wire                                   sba_resp_valid,
   output      logic                            sba_req_valid,  
   output      logic  [ADDR_WIDTH-1:0]          sba_req_addr,
   output      logic  [3:0]                     sba_req_rd_byte_en,
   output      logic  [3:0]                     sba_req_wr_byte_en,
   output      logic  [DATA_WIDTH-1:0]          sba_req_wr_data,
   output      logic                            sba_resp_ready

);


// SBA FSM
enum logic [1:0] {
                  IDLE          = 2'b00,
                  START         = 2'b01,
                  BUSTFR        = 2'b10,
                  RETN          = 2'b11
                 } sba_state, next_state;

logic [2:0] increment; // sbaccess byte, hword or word addr increment
logic dmi_valid; // dmi address valid
logic access_valid; // valid sb access
logic misaligned_sbaddr; // misaligned address detect

logic sba_req_valid_int;
logic [ADDR_WIDTH-1:0] sba_req_addr_int;
logic [3:0] sba_req_rd_byte_en_int;
logic [3:0] sba_req_wr_byte_en_int;
logic [DATA_WIDTH-1:0] sba_req_wr_data_int;
logic sba_resp_ready_int;


logic sba_rd_req_ff, sba_rd_req_cmb; 
logic sba_wr_req_ff, sba_wr_req_cmb;


// SBA Registers /* 
//system bus control & status (0x38)
logic        sbcs_busyerror,sbcs_busyerror_ff; 
logic        sbcs_busy, sbcs_busy_ff;
logic        sbcs_readonaddr, sbcs_readonaddr_ff;
logic [2:0]  sbcs_access, sbcs_access_ff;
logic        sbcs_autoincrement, sbcs_autoincrement_ff;
logic        sbcs_readondata, sbcs_readondata_ff;
logic        sbcs_uar_err, sbcs_uar_err_ff;
logic        sbcs_ba_err, sbcs_ba_err_ff;
logic        sbcs_to_err, sbcs_to_err_ff;

logic [ADDR_WIDTH-1:0]    sbaddr_ff, sbaddr; // System Bus Address0 register(0x39).
logic [DATA_WIDTH-1:0]    sbdata_ff, sbdata; // System Bus Data0 register (0x3c)

// generic counter, used on handshake transaction
logic [3:0] prescale_counter; // timeout = prescale_counter >= timeout_val
logic [7:0] counter;
logic count_en;
logic timeout;

// Assignments. 

assign sba_req_valid = sba_req_valid_int; 
assign sba_req_addr = (sba_state == START | sba_state == BUSTFR) ? sba_req_addr_int : 32'b0;
assign sba_req_rd_byte_en = (sba_rd_req_ff & (sba_state == START | sba_state == BUSTFR)) ? sba_req_rd_byte_en_int : 4'b0000;
assign sba_req_wr_byte_en = (sba_wr_req_ff & (sba_state == START | sba_state == BUSTFR)) ? sba_req_wr_byte_en_int : 4'b0000;
assign sba_req_wr_data = (sba_wr_req_ff & (sba_state == START | sba_state == BUSTFR)) ? sba_req_wr_data_int : 32'h0;
assign sba_resp_ready = sba_resp_ready_int;

assign increment =  (sbcs_access == BYTE_ACCESS)  ? 3'b001 : // increment value for word 4, halfword 2, byte 1
                    (sbcs_access == HWORD_ACCESS) ? 3'b010 :
                    (sbcs_access == WORD_ACCESS)  ? 3'b100 : 3'b000;

assign access_valid = |{sbcs_access == BYTE_ACCESS, sbcs_access == HWORD_ACCESS,  sbcs_access == WORD_ACCESS};

assign misaligned_sbaddr = (sbcs_access == HWORD_ACCESS & sbaddr[0]) | (sbcs_access == WORD_ACCESS & ^sbaddr[1:0]);

assign dmi_valid =  |{mem_addr[6:0] == SBA_CONTROL_AND_STATUS_ADDR, mem_addr[6:0] == SYS_BUS_ADDR_0_ADDR, mem_addr[6:0] == SYS_BUS_DATA_0_ADDR}; 


//DMI - MEM Interface
always_comb
  begin
      
      sba_rd_req_cmb = sba_rd_req_ff;
      sba_wr_req_cmb = sba_wr_req_ff;
      
      sbcs_busy = sbcs_busy_ff;
      sbcs_busyerror = sbcs_busyerror_ff;
      sbcs_readonaddr =  sbcs_readonaddr_ff;
      sbcs_access = sbcs_access_ff; 
      sbcs_autoincrement = sbcs_autoincrement_ff;
      sbcs_readondata = sbcs_readondata_ff;
      sbcs_uar_err = sbcs_uar_err_ff;
      sbcs_ba_err = sbcs_ba_err_ff;
      sbcs_to_err = sbcs_to_err_ff;


      sbaddr = sbaddr_ff;
      sbdata = sbdata_ff;

      mem_rdata = 32'h0;

      if (mem_req & dmi_valid) 
        begin
          //mem_resp = 1'b1;
            if (~mem_wr) //READ
              begin
              case(mem_addr [6:0])
              SBA_CONTROL_AND_STATUS_ADDR:
                begin
                  mem_rdata = {SBCS_VER,
                              6'b000000,
                              sbcs_busyerror_ff,
                              sbcs_busy_ff,
                              sbcs_readonaddr_ff, 
                              sbcs_access_ff, 
                              sbcs_autoincrement_ff,
                              sbcs_readondata_ff,
                              sbcs_uar_err_ff, //sbcs_error 4
                              sbcs_ba_err_ff,  //sbcs_error 2
                              sbcs_to_err_ff,  //sbcs_error 1
                              SBCS_SIZE,
                              SBCS_ACCESSES
                              };
                end
              SYS_BUS_ADDR_0_ADDR:
                begin
                  mem_rdata = sbaddr_ff;
                end
              SYS_BUS_DATA_0_ADDR: // [3]Read call SBA FSM and;1. set sbcs_busy, 2. if sbcs_readondata asserted, read from address location pointed at by sbaddr, 3. if sbcs_autoincrement asserted, sbaddr++, 4. clear sbcs_busy.
                begin
                  if (~sbcs_busy) // assumed - not explicitly stated
                  begin  
                    mem_rdata = sbdata_ff; // return the data
                      if (sbcs_readondata & (sbaddr > 32'hFFFF)) // sbaddr needs to be > abstract Reg address space
                        begin                          
                          sba_rd_req_cmb = 1'b1; // sbdata updated after bus access, new value not returned to debugger
                        end
                      else
                         sba_rd_req_cmb = 1'b0;
                  end
                  else // read request whilst busy
                  begin
                    mem_rdata = 32'b0; 
                    sbcs_busyerror = 1'b1; // busy error if debugger sbdata read whilst SB access in flight
                  end
                end

              default:
                begin
                  mem_rdata = 32'b0;
                  sba_rd_req_cmb = 1'b0;
                end
              endcase
              end
        
            else //WRITE 
              begin
              mem_rdata = 32'b0;
              case(mem_addr [6:0])
              SBA_CONTROL_AND_STATUS_ADDR:
                begin
                     
                  sbcs_readonaddr = mem_wdata[20];
                  sbcs_access = mem_wdata[19:17]; 
                  sbcs_autoincrement = mem_wdata[16];
                  sbcs_readondata = mem_wdata[15];
                  if (mem_wdata[22]) sbcs_busyerror = 1'b0; //RW1C error bits
                  if (mem_wdata[14])sbcs_uar_err = 1'b0;
                  if (mem_wdata[13])sbcs_ba_err = 1'b0; 
                  if (mem_wdata[12])sbcs_to_err = 1'b0;
                    //other bits read only
                                          
                end
              SYS_BUS_ADDR_0_ADDR: //[1] Writes - call SBA FSM and; 1. set sbcs_busy, 2. if sbcs_readonaddr asserted, read from address location pointed at by sbaddr (assuming legitimate memory space!) 3. if sbcs_autoincrement asserted then sbaddr++, 4. clear sbcs_busy
                begin
                  if (~sbcs_busy)
                    begin
                      sbaddr = mem_wdata;
                      if (~|{sbcs_uar_err, sbcs_ba_err, sbcs_to_err, sbcs_busyerror} & sbcs_readonaddr & (sbaddr > 32'hFFFF) )// sbaddr needs to be > abstract Reg address space
                          begin   
                            sba_rd_req_cmb = 1'b1; // sba read fsm, sbdata updated on FSM bus tfr
                          end
                        else
                          sba_rd_req_cmb = 1'b0;
                      end
                  else                  
                    sbcs_busyerror = 1'b1; // attempted writes whilst sbcs_busy asserted, set busy error bit
                end
              SYS_BUS_DATA_0_ADDR:// [2] Writes call SBA FSM and; 1. set sbcs_busy, 2. sba write data to address in sbaddr,, set busy error bit,3. if write OK and sbcs_autoincrement asserted then sbaddr++, 4. clear sbcs_busy.
                begin
                  if (~sbcs_busy)
                    begin
                      sbdata  =  mem_wdata;
                        if (~|{sbcs_uar_err, sbcs_ba_err, sbcs_to_err, sbcs_busyerror} & (sbaddr > 32'hFFFF) )// sbaddr needs to be > abstract Reg address space
                          begin 
                            sba_wr_req_cmb = 1'b1;
                          end
                        else
                          sba_wr_req_cmb = 1'b0;
                    end
                  else
                    sbcs_busyerror = 1'b1; 
                end
    
              default:
                begin
                  sba_rd_req_cmb = 1'b0;
                  sba_wr_req_cmb = 1'b0;
                  //set error?
                end
              endcase
            end
        end
    end


   // SBA Master FSM 
always_ff @( posedge clk or negedge resetb)
    begin
      if (~resetb) // reset regs etc
        begin
          sba_state <= IDLE; 
        end
      else
        begin
          sba_state <= next_state;
        end
    end

       
always_comb 
    begin
        count_en = 1'b0;
        next_state = sba_state;


      case (sba_state)// IDLE 
        IDLE:
          begin           
            if (halted  & (sba_rd_req_cmb | sba_wr_req_cmb) & ~trx_os)
                next_state = START;
            else            
                next_state = IDLE;

            end
        START:
          begin
            if ((sba_rd_req_cmb | sba_wr_req_cmb)  & sba_req_ready) 
              begin
                if (access_valid & ~misaligned_sbaddr) // check valid access and not misaligned address  & ~misaligned_sbaddr
                  begin
                    next_state = BUSTFR;
                    count_en = 1'b0;
                  end
                else
                    next_state = IDLE; 
              end
            else

            if (timeout | misaligned_sbaddr | ~access_valid )
                next_state = IDLE;
                if (timeout) count_en = 1'b0; // disable count, to_err set
            else
                count_en = 1'b1; // count
        end
  
        BUSTFR: //TRANSFER 
          begin
            if ((sba_rd_req_cmb | sba_wr_req_cmb) & (sba_resp_valid |sba_resp_error))
              begin  
                next_state         = RETN;
              end
            else
               count_en            = 1'b1; // count
          end //

        RETN:
            begin
            next_state             = IDLE;
            end //

        endcase
    end

always_ff @( posedge clk, negedge resetb) // fsm outputs on transition
    begin
    if (~resetb) // reset regs etc
      begin

        sbcs_readonaddr_ff        <= 1'b0;
        sbcs_access_ff            <= 3'b010; //Default WORD_ACCESS
        sbcs_autoincrement_ff     <= 1'b0;
        sbcs_readondata_ff        <= 1'b0;

        sba_rd_req_ff             <= 1'b0;
        sba_wr_req_ff             <= 1'b0;

        sbcs_busyerror_ff         <= 1'b0;
        sbcs_busy_ff              <= 1'b0; 
        
        sbaddr_ff                 <= 32'h0;
        sbdata_ff                 <= 32'h0;

        sbcs_uar_err_ff           <= 1'b0;
        sbcs_to_err_ff            <= 1'b0;
        sbcs_ba_err_ff            <= 1'b0;
          
        sba_req_valid_int         <= 1'b0;
        sba_req_addr_int          <= 32'b0;
        sba_req_wr_data_int       <= 32'b0;
        sba_req_wr_byte_en_int    <= 4'b0000;
        sba_req_rd_byte_en_int    <= 4'b0000;
        sba_resp_ready_int        <= 1'b0;
       
      end
      
    else if (~sba_en) // DM not active
    
      begin

        sbcs_readonaddr_ff        <= 1'b0;
        sbcs_access_ff            <= WORD_ACCESS; //Default 
        sbcs_autoincrement_ff     <= 1'b0;
        sbcs_readondata_ff        <= 1'b0;

        sba_rd_req_ff             <= 1'b0;
        sba_wr_req_ff             <= 1'b0;

        sbcs_busyerror_ff         <= 1'b0;
        sbcs_busy_ff              <= 1'b0; 
        
        sbaddr_ff                 <= 32'h0;
        sbdata_ff                 <= 32'h0;

        sbcs_uar_err_ff           <= 1'b0;
        sbcs_to_err_ff            <= 1'b0;
        sbcs_ba_err_ff            <= 1'b0;
          
        sba_req_valid_int         <= 1'b0;
        sba_req_addr_int          <= 32'b0;
        sba_req_wr_data_int       <= 32'b0;
        sba_req_wr_byte_en_int    <= 4'b0000;
        sba_req_rd_byte_en_int    <= 4'b0000;
        sba_resp_ready_int        <= 1'b0;
       
      end

    else
      begin
        sbcs_readonaddr_ff        <= sbcs_readonaddr;
        sbcs_access_ff            <= sbcs_access;
        sbcs_autoincrement_ff     <= sbcs_autoincrement;
        sbcs_readondata_ff        <= sbcs_readondata;
          


        sbcs_busyerror_ff      <= sbcs_busyerror;
        sbcs_busy_ff           <= sbcs_busy; 
        sbcs_uar_err_ff       <= sbcs_uar_err;
        sbcs_to_err_ff        <= sbcs_to_err;
        sbcs_ba_err_ff        <= sbcs_ba_err;
 
        sbaddr_ff              <= sbaddr;
        sbdata_ff              <= sbdata;

        sba_rd_req_ff         <= sba_rd_req_cmb;
        sba_wr_req_ff         <= sba_wr_req_cmb;

        sba_req_valid_int     <= sba_req_valid;  
        sba_req_addr_int      <= sba_req_addr;  
        sba_req_wr_data_int   <= sba_req_wr_data;  
        sba_req_wr_byte_en_int <= sba_req_wr_byte_en;  
        sba_req_rd_byte_en_int <= sba_req_rd_byte_en;  
        sba_resp_ready_int     <= sba_resp_ready;


        case (next_state)

        IDLE:
          begin
            sbcs_busy_ff              <= 1'b0;
            sba_rd_req_ff             <= 1'b0;
            sba_wr_req_ff             <= 1'b0;
            sba_req_valid_int         <= 1'b0;
            sba_resp_ready_int        <= 1'b0;
            if (sbcs_autoincrement & (sba_state == RETN)) sbaddr_ff <= sbaddr + increment;
            if (~sbcs_ba_err & sba_resp_error ) sbcs_ba_err_ff <= 1'b1; // late reported bad address error
            if (timeout & ~sbcs_to_err) sbcs_to_err_ff  <= 1'b1; // timeout and back to IDLE if req_ready not received (set timeout_err flag)
          end

        START:
          begin
            if (access_valid & ~misaligned_sbaddr)
              begin
                sba_req_valid_int <= 1'b1;
                sba_resp_ready_int <= 1'b1;
                sbcs_busy_ff <= 1'b1;
                
                if (sba_rd_req_cmb) 
                  begin
                    case (sbcs_access)
                    BYTE_ACCESS:
                      begin
                        sba_req_addr_int <= sbaddr;
                        sba_req_wr_byte_en_int  <= 4'b0000;
                        sba_req_rd_byte_en_int  <= (sbaddr[1:0] == 2'b00) ? 4'b0001 :
                                                   (sbaddr[1:0] == 2'b01) ? 4'b0010 :
                                                   (sbaddr[1:0] == 2'b10) ? 4'b0100 :
                                                   (sbaddr[1:0] == 2'b11) ? 4'b1000 : 4'b0000;
                      end
                      
                    HWORD_ACCESS:
                      begin
                        sba_req_addr_int <= sbaddr;
                        sba_req_wr_byte_en_int  <= 4'b0000;
                        sba_req_rd_byte_en_int  <= (sbaddr[1] == 1'b0) ? 4'b0011 :
                                                   (sbaddr[1] == 1'b1) ? 4'b1100 : 4'b0000;

                      end
                    WORD_ACCESS:
                      begin
                        sba_req_addr_int        <= sbaddr;
                        sba_req_wr_byte_en_int  <= 4'b0000;
                        sba_req_rd_byte_en_int  <= 4'b1111;

                      end
                    default:
                      begin
                        sba_req_valid_int           <= 1'b0;
                        sba_req_addr_int            <= 32'h0;//
                        sba_req_rd_byte_en_int      <= 4'b0000;
                        sba_req_wr_byte_en_int      <= 4'b0000;
                     end
                    endcase
                  end
                  
                else
                  
                if (sba_wr_req_cmb)
                  begin                   
                    case (sbcs_access)
                    BYTE_ACCESS:
                      begin
                        sba_req_addr_int        <= sbaddr;
                        sba_req_wr_data_int     <= (sbaddr[1:0] == 2'b00) ? {24'b0, sbdata[7:0]}:
                                                   (sbaddr[1:0] == 2'b01) ? {16'b0, sbdata[7:0], 8'b0}:
                                                   (sbaddr[1:0] == 2'b10) ? {8'b0, sbdata[7:0], 16'b0}:
                                                   (sbaddr[1:0] == 2'b11) ? {sbdata[7:0], 24'b0}: 32'b0;

                        sba_req_wr_byte_en_int  <= (sbaddr[1:0] == 2'b00) ? 4'b0001 :
                                                   (sbaddr[1:0] == 2'b01) ? 4'b0010 :
                                                   (sbaddr[1:0] == 2'b10) ? 4'b0100 :
                                                   (sbaddr[1:0] == 2'b11) ? 4'b1000 : 4'b0000;
                        sba_req_rd_byte_en_int  <= 4'b0000;

                      end
                    HWORD_ACCESS:
                      begin
                        sba_req_addr_int        <= sbaddr;
                        sba_req_wr_data_int     <= (sbaddr[1] == 1'b0) ? {16'b0, sbdata[15:0]}:
                                                   (sbaddr[1] == 1'b1) ? {sbdata[15:0],16'b0} : 32'b0;

                        sba_req_wr_byte_en_int  <= (sbaddr[1] == 1'b0) ? 4'b0011 :
                                                   (sbaddr[1] == 1'b1) ? 4'b1100 : 4'b0000;
                        sba_req_rd_byte_en_int  <= 4'b0000;

                      end
                    WORD_ACCESS:
                      begin
                        sba_req_addr_int        <= sbaddr;
                        sba_req_wr_data_int     <= sbdata;
                        sba_req_wr_byte_en_int  <= 4'b1111;
                        sba_req_rd_byte_en_int  <= 4'b0000;

                      end
                    default:
                      begin
                        sba_req_valid_int           <= 1'b0;
                        sba_req_addr_int            <= 32'h0;
                        sba_req_wr_data_int         <= 32'h0;
                        sba_req_wr_byte_en_int      <= 4'b0000;
                        sba_req_rd_byte_en_int      <= 4'b0000;
                      end
                    endcase
                  end
                  
                else
                  begin
                    sba_req_valid_int           <= 1'b0;
                    sba_req_addr_int            <= 32'h0;
                    sba_req_wr_data_int         <= 32'h0;
                    sba_req_wr_byte_en_int      <= 4'b0000;
                    sba_req_rd_byte_en_int      <= 4'b0000;
                  end                
              end
            else
              if (~access_valid & ~sbcs_uar_err) sbcs_uar_err_ff <= 1'b1; //unsupported access request error
              if (misaligned_sbaddr & (~sbcs_to_err | ~sbcs_ba_err)) // sbaddr misaligned
              begin
                sbcs_to_err_ff <= 1'b1; // both these errors set to signify misaligned address error 
                sbcs_ba_err_ff <= 1'b1;
              end
          end

        BUSTFR:
          begin
            if (sba_wr_req_cmb & sba_req_ready)
              begin
                 sba_req_valid_int <= 1'b0;
              end
            else
            if (sba_rd_req_cmb & (sba_resp_valid & ~sba_resp_error))
              begin
              sba_req_valid_int <= 1'b0;
              sba_resp_ready_int <= 1'b0;
              end
            else
            // wait for timeout
              begin
                if (timeout)
                begin
                    sba_req_valid_int           <= 1'b0;
                    sba_req_addr_int            <= 32'h0;
                    sba_req_wr_byte_en_int      <= 4'b0000;
                    sba_req_rd_byte_en_int      <= 4'b0000;
                    if (~sbcs_to_err) sbcs_to_err_ff  <= 1'b1; // timeout error
                end
              end 
            end // 

        RETN:
          begin
            if (sba_rd_req_cmb & (sba_resp_valid & ~sba_resp_error))
              begin
              sba_resp_ready_int <= 1'b0;
              case (sbcs_access)
              BYTE_ACCESS:
                begin
                  sbdata_ff[7:0]     <= (sbaddr[1:0] == 2'b00) ? sba_resp_rd_data[7:0]:
                                        (sbaddr[1:0] == 2'b01) ? sba_resp_rd_data[15:8]:
                                        (sbaddr[1:0] == 2'b10) ? sba_resp_rd_data[23:16]:
                                        (sbaddr[1:0] == 2'b11) ? sba_resp_rd_data[31:24]: 8'b0;
                end
              HWORD_ACCESS:
                begin
                  sbdata_ff[15:0]   <= (sbaddr[1] == 1'b0) ? sba_resp_rd_data[15:0]:
                                       (sbaddr[1] == 1'b1) ? sba_resp_rd_data[31:16]: 16'b0;
                 end
              WORD_ACCESS:
                begin
                  sbdata_ff       <=  sba_resp_rd_data;
                end
              endcase
              end
            else

            if (sba_resp_error | timeout)
              begin
                sba_resp_ready_int               <= 1'b0;
                sba_req_addr_int                 <= 32'h0;
                sba_req_wr_byte_en_int           <= 4'b0000;
                sba_req_rd_byte_en_int           <= 4'b0000;
                if (~sbcs_ba_err & sba_resp_error ) sbcs_ba_err_ff <= 1'b1; // bad address error
                if (~sbcs_to_err & timeout) sbcs_to_err_ff  <= 1'b1; // timeout error
              end
          end //
        endcase
      end
    end

always_ff @( posedge clk or negedge resetb) // timeout counter
    begin
      if (~resetb) // reset regs etc
        begin
         prescale_counter <= 4'h0;
         counter <= 8'h00;
         timeout <= 1'b0;
        end
      else
        if (count_en)
          begin
            if (counter == 8'hff)
              begin
                prescale_counter <= prescale_counter + 1'b1;
                counter <= 8'h00;
                timeout <= (prescale_counter >= TIMEOUT_VAL);
              end
            else
                counter <= counter + 1'b1;
          end
        else
          begin
            prescale_counter <= 4'h0;
            counter <= 8'h00;
            timeout <= 1'b0;
          end
    end // timeout counter
    
 endmodule//tiny_sba

`default_nettype wire
// Formal Comments

/*

   - We cannot have an Sys Bus Access with  (assertion ? )
   - We cannot be halted and running at the same time
   - Check that load_* only occurs when expected. 
*/
// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_regs.sv
//
//   Purpose:
//    opsrv configuration and control registers
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv_regs
//********************************************************************************
// Parameter description

  #(   
    

    parameter REGS_ADDR_WIDTH              = 12,
	parameter ECC_ENABLE                   = 0,
    parameter l_opsrv_cfg_lmem0_present    = 1,
	parameter l_opsrv_cfg_axi_mstr_present = 1

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,
    
    input wire  logic                            sys_parity_disable,

    
    // CPU control interface
    input wire  logic                            cpu_regs_req_valid,
    output      logic                            cpu_regs_req_ready, 
    input wire  logic [3:0]                      cpu_regs_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_regs_req_wr_byte_en,
    input wire  logic                            cpu_regs_req_read,
    input wire  logic                            cpu_regs_req_write,
    input wire  logic [REGS_ADDR_WIDTH-1:0]      cpu_regs_req_addr,
    input wire  logic                            cpu_regs_req_addr_p,
    input wire  logic [31:0]                     cpu_regs_req_wr_data,
    input wire  logic [3:0]                      cpu_regs_req_wr_data_p,
    output      logic                            cpu_regs_resp_valid,
    input wire  logic                            cpu_regs_resp_ready,
    output      logic                            cpu_regs_resp_error,
    output      logic [31:0]                     cpu_regs_resp_rd_data,
    output      logic [3:0]                      cpu_regs_resp_rd_data_p,
    
    input wire  logic                            cpu_regs_lmem0_ecc_err_correctable,  
    input wire  logic                            cpu_regs_lmem0_ecc_err_uncorrectable,
    input wire  logic                            cpu_regs_lmem1_ecc_err_correctable,  
    input wire  logic                            cpu_regs_lmem1_ecc_err_uncorrectable,
    input wire  logic                            cpu_regs_axi_mstr_wr_resp_err,
    input wire  logic                            cpu_regs_udma_ctrl_irq,
    
    output      logic [1:0]                      cpu_regs_opsrv_irq,
    
    output      logic                            cpu_regs_opsrv_parity_en,
    output      logic [1:0]                      cpu_regs_axi_rd_cfg_min_size,
    output      logic [1:0]                      cpu_regs_axi_wr_cfg_min_size,   
    output      logic                            cpu_regs_cfg_fence_all_src,  
    output      logic [3:0]                      cpu_regs_cfg_ar_cache,       
    output      logic [3:0]                      cpu_regs_cfg_aw_cache,       
    output      logic                            cpu_regs_cfg_raw_hzd_check,  
    output      logic                            cpu_regs_cfg_war_hzd_check,  
    
    output      logic                            cpu_regs_core_soft_reset,                   //core_soft_reset module output
    output      logic                            cpu_regs_core_soft_irq,                     //core_soft_irq module output
    
    input wire  logic                            gpr_ded_soft_reset                          //gpr ded soft reset input
    
  );

//********************************************************************************
// Declarations

// localparams

  localparam REQ_BUFF_WIDTH = 4;
  localparam REQ_BUFF_DEPTH = 2;
  localparam LOG2_REQ_BUFF_DEPTH = 1;



// Internal nets

  logic                                       req_is_opsrv_cfg_reg;
  logic                                       resp_is_opsrv_cfg_reg;
  logic                                       read_opsrv_cfg_reg;
  logic                                       write_opsrv_cfg_reg;
  logic                                       opsrv_parity_en_reg;
  logic                                       write_parity_en_reg;
  logic [31:0]                                opsrv_cfg_reg;
  logic [31:0]                                opsrv_cfg_reg_rd_data;
  
  
  logic                                       req_is_opsrv_irq_en;
  logic                                       resp_is_opsrv_irq_en;
  logic                                       read_opsrv_irq_en_reg;
  logic                                       write_opsrv_irq_en_reg;
  logic                                       opsrv_irq_lmem0_ecc_err_corr_en_reg;
  logic                                       opsrv_irq_lmem0_ecc_err_uncorr_en_reg;
  logic                                       opsrv_irq_lmem1_ecc_err_corr_en_reg;
  logic                                       opsrv_irq_lmem1_ecc_err_uncorr_en_reg;
  logic                                       opsrv_irq_axi_write_err_en_reg;
  logic [31:0]                                opsrv_irq_en_reg;
  logic [31:0]                                opsrv_irq_en_reg_rd_data;
    
  logic                                       req_is_opsrv_irq_pend;
  logic                                       resp_is_opsrv_irq_pend;
  logic                                       read_opsrv_irq_pend_reg;
  logic                                       write_opsrv_irq_pend_reg;
  logic                                       opsrv_irq_lmem0_ecc_err_corr_pend_reg;
  logic                                       opsrv_irq_lmem0_ecc_err_uncorr_pend_reg;
  logic                                       opsrv_irq_lmem1_ecc_err_corr_pend_reg;
  logic                                       opsrv_irq_lmem1_ecc_err_uncorr_pend_reg;
  logic                                       opsrv_irq_axi_write_err_pend_reg;
  logic [31:0]                                opsrv_irq_pend_reg;
  logic [31:0]                                opsrv_irq_pend_reg_rd_data;
  
  logic                                       req_buffer_req_valid;
  logic                                       req_buffer_req_ready;
  logic [REQ_BUFF_WIDTH-1:0]                  req_buffer_reg_sel;
  logic                                       req_buffer_resp_valid;
  logic [REQ_BUFF_WIDTH-1:0]                  req_buffer_resp_sel;
  logic [(REQ_BUFF_WIDTH*REQ_BUFF_DEPTH)-1:0] req_buffer_resp_sel_pkd;
  logic [REQ_BUFF_DEPTH-1:0]                  req_buffer_resp_valid_pkd;
  logic                                       resp_is_read;
  logic [31:0]                                reg_rd_data;
  logic                                       req_wr_hzd;
  
  // Internal nets for core_soft_reset reg
  logic      								  resp_is_opsrv_core_soft_reg;
  logic                                       req_is_opsrv_core_soft_reg;
  logic                                       write_opsrv_core_soft_reg;
  logic                                       read_opsrv_core_soft_reg;
  logic [31:0]                                opsrv_core_soft_reg;
  logic [31:0]                                opsrv_core_soft_reg_rd_data;
  
  logic                                       toggle_core_soft_reset;


//********************************************************************************
// Main code
//********************************************************************************

  
  //-------------------------------------
  // opsrv_cfg 
  // OPSRV configuration register
  // address: 0x000
  // bit description:
  //          [0] opsrv_parity_en
  //
  //-------------------------------------
  
  assign req_is_opsrv_cfg_reg  = (cpu_regs_req_addr == 12'h000) & cpu_regs_req_valid;
  assign read_opsrv_cfg_reg    = resp_is_opsrv_cfg_reg & req_buffer_resp_valid & cpu_regs_resp_ready & resp_is_read;
  assign write_opsrv_cfg_reg   = req_is_opsrv_cfg_reg & cpu_regs_req_write & cpu_regs_req_ready;
  
  // opsrv_parity_en_reg
  
  assign write_parity_en_reg = write_opsrv_cfg_reg & cpu_regs_req_wr_byte_en[0];
  
  MIV_RV32IMC_csr_gpr_state_reg
  #(
    .WIDTH               (1),  
    .FIELD_RESET_EN      (1),
    .FIELD_RESET_VAL     (0)
  )
  u_opsrv_parity_en_reg
  (
    .clk                         (clk),
    .resetn                      (resetn),
    .init_wr_en                  (1'b0),
    .init_wr_data                (1'b0),
    .machine_implicit_wr_en      (1'b0),
    .machine_implicit_wr_data    (1'b0),
    .machine_sw_wr_en            (1'b0), // REVISIT - Add write_parity_en_reg if parity used
    .machine_sw_wr_data          (1'b0), // REVISIT - Add cpu_regs_req_wr_data[0] if parity used
    .state_val                   (opsrv_parity_en_reg)
  );
  
  
  assign opsrv_cfg_reg = { {31{1'b0}}, opsrv_parity_en_reg};
  
  assign opsrv_cfg_reg_rd_data = {32{read_opsrv_cfg_reg}} & opsrv_cfg_reg;
  
  //-------------------------------------
  // interrupt registers.
  // OPSRV has 2 interrupt status registers with corresponding enable registers
  // When an enabled interrupt is asserted, an interrupt is generated to the core
  // Interrupt reg 0 (error bits)
  //  lmem0_ecc_err_correctable  
  //  lmem0_ecc_err_uncorrectable
  //  lmem1_ecc_err_correctable  
  //  lmem1_ecc_err_uncorrectable
  //  axi_mstr_d_wr_resp_err
  //
  // Interrupt reg 1 (udma) - not implemented yet
  //  udma_ctrl_irq 
  
  
  //-------------------------------------
  // opsrv_irq_en 
  // OPSRV IRQ enable register
  // address: 0x010
  // bit description:
  //          [0] lmem0 ecc_err_correctable enable   
  //          [1] lmem0 ecc_err_uncorrectable enable
  //          [2] lmem1 ecc_err_correctable enable 
  //          [3] lmem1 ecc_err_uncorrectable enable
  //          [4] Axi master_write response error enable
  //
  //-------------------------------------
  
  assign req_is_opsrv_irq_en      = (cpu_regs_req_addr == 12'h010) & cpu_regs_req_valid;
  assign read_opsrv_irq_en_reg    = resp_is_opsrv_irq_en & req_buffer_resp_valid & cpu_regs_resp_ready & resp_is_read;
  assign write_opsrv_irq_en_reg   = req_is_opsrv_irq_en & cpu_regs_req_write & cpu_regs_req_ready;
  
  generate
  if(l_opsrv_cfg_lmem0_present & ECC_ENABLE) begin: gen_lmem0_irq
  
    logic       write_opsrv_irq_lmem0_ecc_err_en;
    logic [1:0] opsrv_irq_lmem0_ecc_err_en_reg;
    
    assign write_opsrv_irq_lmem0_ecc_err_en   = write_opsrv_irq_en_reg & cpu_regs_req_wr_byte_en[0];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (2),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem0_ecc_err_en_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (2'b00),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (2'b00),
      .machine_sw_wr_en            (write_opsrv_irq_lmem0_ecc_err_en),
      .machine_sw_wr_data          (cpu_regs_req_wr_data[1:0]),
      .state_val                   (opsrv_irq_lmem0_ecc_err_en_reg)
    );
    
    assign opsrv_irq_lmem0_ecc_err_corr_en_reg   = opsrv_irq_lmem0_ecc_err_en_reg[0];
    assign opsrv_irq_lmem0_ecc_err_uncorr_en_reg = opsrv_irq_lmem0_ecc_err_en_reg[1];
  
  end
  else begin : ngen_lmem0_irq
    assign opsrv_irq_lmem0_ecc_err_corr_en_reg   = 1'b0;
    assign opsrv_irq_lmem0_ecc_err_uncorr_en_reg = 1'b0;
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_lmem1_present) begin: gen_lmem1_irq
  
    logic       write_opsrv_irq_lmem1_ecc_err_en;
    logic [1:0] opsrv_irq_lmem1_ecc_err_en_reg;
    
    assign write_opsrv_irq_lmem1_ecc_err_en   = write_opsrv_irq_en_reg & cpu_regs_req_wr_byte_en[0];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (2),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem1_ecc_err_en_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (2'b00),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (2'b00),
      .machine_sw_wr_en            (write_opsrv_irq_lmem1_ecc_err_en),
      .machine_sw_wr_data          (cpu_regs_req_wr_data[3:2]),
      .state_val                   (opsrv_irq_lmem1_ecc_err_en_reg)
    );
    
    assign opsrv_irq_lmem1_ecc_err_corr_en_reg   = opsrv_irq_lmem1_ecc_err_en_reg[0];
    assign opsrv_irq_lmem1_ecc_err_uncorr_en_reg = opsrv_irq_lmem1_ecc_err_en_reg[1];
  
  end
  else begin : ngen_lmem1_irq
    assign opsrv_irq_lmem1_ecc_err_corr_en_reg   = 1'b0;
    assign opsrv_irq_lmem1_ecc_err_uncorr_en_reg = 1'b0;
  end   
  endgenerate
  
  generate
  if(l_opsrv_cfg_axi_mstr_present) begin:  gen_axi_irq
  
    logic        write_opsrv_irq_axi_write_err_en;
    
    assign write_opsrv_irq_axi_write_err_en   = write_opsrv_irq_en_reg & cpu_regs_req_wr_byte_en[0];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_axi_ecc_err_en_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (1'b0),
      .machine_sw_wr_en            (write_opsrv_irq_axi_write_err_en),
      .machine_sw_wr_data          (cpu_regs_req_wr_data[4]),
      .state_val                   (opsrv_irq_axi_write_err_en_reg)
    );
    
  
  end
  else begin : ngen_axi_irq
    assign opsrv_irq_axi_write_err_en_reg   = 1'b0;
  end   
  endgenerate
  
  assign opsrv_irq_en_reg = { {27{1'b0}},
                              opsrv_irq_axi_write_err_en_reg,
                              opsrv_irq_lmem1_ecc_err_uncorr_en_reg,
                              opsrv_irq_lmem1_ecc_err_corr_en_reg,
                              opsrv_irq_lmem0_ecc_err_uncorr_en_reg,
                              opsrv_irq_lmem0_ecc_err_corr_en_reg};
  
  assign opsrv_irq_en_reg_rd_data = {32{read_opsrv_irq_en_reg}} & opsrv_irq_en_reg;
     
  //-------------------------------------
  // opsrv_irq_pend 
  // OPSRV IRQ pending register
  // address: 0x014
  // bit description:
  // bit description:
  //          [0] lmem0 ecc_err_correctable pending   
  //          [1] lmem0 ecc_err_uncorrectable pending
  //          [2] lmem1 ecc_err_correctable pending 
  //          [3] lmem1 ecc_err_uncorrectable pending
  //          [4] Axi master_write response error pending
  //
  //-------------------------------------
  
  // pending bits are set when the interrupt source is asserted and remain set until 
  // cleared by the CPU writing a '1' to the register bit

  
  assign req_is_opsrv_irq_pend      = (cpu_regs_req_addr == 12'h014) & cpu_regs_req_valid;
  assign read_opsrv_irq_pend_reg    = resp_is_opsrv_irq_pend & req_buffer_resp_valid & cpu_regs_resp_ready & resp_is_read;
  assign write_opsrv_irq_pend_reg   = req_is_opsrv_irq_pend & cpu_regs_req_write & cpu_regs_req_ready;
  
  generate
  if(l_opsrv_cfg_lmem0_present) begin: gen_lmem0_irq_pend
  
    logic       write_opsrv_irq_lmem0_ecc_err_corr_pend;
    logic       write_opsrv_irq_lmem0_ecc_err_uncorr_pend;
    
    assign write_opsrv_irq_lmem0_ecc_err_corr_pend   = write_opsrv_irq_pend_reg & cpu_regs_req_wr_byte_en[0] & cpu_regs_req_wr_data[0];
    assign write_opsrv_irq_lmem0_ecc_err_uncorr_pend = write_opsrv_irq_pend_reg & cpu_regs_req_wr_byte_en[0] & cpu_regs_req_wr_data[1];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem0_ecc_err_corr_pend_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (cpu_regs_lmem0_ecc_err_correctable),
      .machine_implicit_wr_data    (1'b1),
      .machine_sw_wr_en            (write_opsrv_irq_lmem0_ecc_err_corr_pend),
      .machine_sw_wr_data          (1'b0),
      .state_val                   (opsrv_irq_lmem0_ecc_err_corr_pend_reg)
    );
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem0_ecc_err_uncorr_pend_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (cpu_regs_lmem0_ecc_err_uncorrectable),
      .machine_implicit_wr_data    (1'b1),
      .machine_sw_wr_en            (write_opsrv_irq_lmem0_ecc_err_uncorr_pend),
      .machine_sw_wr_data          (1'b0),
      .state_val                   (opsrv_irq_lmem0_ecc_err_uncorr_pend_reg)
    );
   
  end
  else begin : ngen_lmem0_irq_pend
  
    assign opsrv_irq_lmem0_ecc_err_corr_pend_reg   = 1'b0;
    assign opsrv_irq_lmem0_ecc_err_uncorr_pend_reg = 1'b0;
    
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_lmem1_present) begin: gen_lmem1_irq_pend
  
    logic       write_opsrv_irq_lmem1_ecc_err_corr_pend;
    logic       write_opsrv_irq_lmem1_ecc_err_uncorr_pend;
    
    assign write_opsrv_irq_lmem1_ecc_err_corr_pend   = write_opsrv_irq_pend_reg & cpu_regs_req_wr_byte_en[0] & cpu_regs_req_wr_data[2];
    assign write_opsrv_irq_lmem1_ecc_err_uncorr_pend = write_opsrv_irq_pend_reg & cpu_regs_req_wr_byte_en[0] & cpu_regs_req_wr_data[3];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem1_ecc_err_corr_pend_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (cpu_regs_lmem1_ecc_err_correctable),
      .machine_implicit_wr_data    (1'b1),
      .machine_sw_wr_en            (write_opsrv_irq_lmem1_ecc_err_corr_pend),
      .machine_sw_wr_data          (1'b0),
      .state_val                   (opsrv_irq_lmem1_ecc_err_corr_pend_reg)
    );
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_lmem1_ecc_err_uncorr_pend_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (cpu_regs_lmem1_ecc_err_uncorrectable),
      .machine_implicit_wr_data    (1'b1),
      .machine_sw_wr_en            (write_opsrv_irq_lmem1_ecc_err_uncorr_pend),
      .machine_sw_wr_data          (1'b0),
      .state_val                   (opsrv_irq_lmem1_ecc_err_uncorr_pend_reg)
    );
   
  end
  else begin : ngen_lmem1_irq_pend
  
    assign opsrv_irq_lmem1_ecc_err_corr_pend_reg   = 1'b0;
    assign opsrv_irq_lmem1_ecc_err_uncorr_pend_reg = 1'b0;
    
  end   
  endgenerate  
  
  generate
  if(l_opsrv_cfg_axi_mstr_present) begin:  gen_axi_irq_pend

    logic        write_opsrv_irq_axi_write_err_pend;
    
    assign write_opsrv_irq_axi_write_err_pend   = write_opsrv_irq_pend_reg & cpu_regs_req_wr_byte_en[0] & cpu_regs_req_wr_data[4];
    
    MIV_RV32IMC_csr_gpr_state_reg
    #(
      .WIDTH               (1),  
      .FIELD_RESET_EN      (1),
      .FIELD_RESET_VAL     (0)
    )
    u_opsrv_irq_axi_ecc_err_pend_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (cpu_regs_axi_mstr_wr_resp_err),
      .machine_implicit_wr_data    (1'b1),
      .machine_sw_wr_en            (write_opsrv_irq_axi_write_err_pend),
      .machine_sw_wr_data          (1'b0),
      .state_val                   (opsrv_irq_axi_write_err_pend_reg)
    );   
  
  end
  else begin : ngen_axi_irq_pend
  
    assign opsrv_irq_axi_write_err_pend_reg   = 1'b0;
    
  end   
  endgenerate
  
  assign opsrv_irq_pend_reg = { {27{1'b0}},
                              opsrv_irq_axi_write_err_pend_reg,
                              opsrv_irq_lmem1_ecc_err_uncorr_pend_reg,
                              opsrv_irq_lmem1_ecc_err_corr_pend_reg,
                              opsrv_irq_lmem0_ecc_err_uncorr_pend_reg,
                              opsrv_irq_lmem0_ecc_err_corr_pend_reg};
  
  assign opsrv_irq_pend_reg_rd_data = {32{read_opsrv_irq_pend_reg}} & opsrv_irq_pend_reg;

  //-------------------

  //-------------------------------------
  // opsrv_core_soft_reg 
  // OPSRV CORE SOFT RESET REGISTER
  // address: 0x020
  // bit description:
  //          [0] core_soft_reset_reg   
  //          [1] core_soft_irq_reg
  //          [2] core_gpr_ded_reset_reg
  //					
  //
  //-------------------------------------
  
  assign req_is_opsrv_core_soft_reg  = (cpu_regs_req_addr == 12'h020) & cpu_regs_req_valid;
  assign read_opsrv_core_soft_reg    = resp_is_opsrv_core_soft_reg & req_buffer_resp_valid & cpu_regs_resp_ready & resp_is_read;
  assign write_opsrv_core_soft_reg   = req_is_opsrv_core_soft_reg & cpu_regs_req_write & cpu_regs_req_ready;
  
  logic write_opsrv_core_soft_reset;
  logic opsrv_core_soft_reset_reg;
  
  assign write_opsrv_core_soft_reset = write_opsrv_core_soft_reg & cpu_regs_req_wr_byte_en[0];
  
  
  //synchronous logic for toggling core_soft_reset
  always @ (posedge clk)
  begin
  if(~resetn)
    toggle_core_soft_reset = 1'b0;
  else
    begin
    if(opsrv_core_soft_reg[0])       //if the core_soft_reset_reg has been written to,
        toggle_core_soft_reset = 1'b0;  //reset it to zero one clock period later in order to prevent the cpu from being locked in reset  
    else 
        toggle_core_soft_reset = 1'b1;
    end
  end
  
  MIV_RV32IMC_csr_gpr_state_reg
  #(
    .WIDTH               (1),  
    .FIELD_RESET_EN      (1),
    .FIELD_RESET_VAL     (0)
  )
  u_opsrv_core_soft_reset_reg
    (
      .clk                         (clk),
      .resetn                      ( (resetn && toggle_core_soft_reset) ), //toggle_reset logic above used to reset the register
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (1'b0),
      .machine_sw_wr_en            (write_opsrv_core_soft_reset || gpr_ded_soft_reset), //soft reset write is enabled when the register is written to in software or when there is a GPR DED
      .machine_sw_wr_data          (cpu_regs_req_wr_data[0] || gpr_ded_soft_reset), //soft reset is set to a 1 when the register is written to in software or when there is a GPR DED
      .state_val                   (opsrv_core_soft_reset_reg)
    );
  
  
  logic write_opsrv_core_soft_irq;
  logic opsrv_core_soft_irq_reg;
  
  assign write_opsrv_core_soft_irq = write_opsrv_core_soft_reg & cpu_regs_req_wr_byte_en[0];
  
  MIV_RV32IMC_csr_gpr_state_reg
  #(
    .WIDTH               (1),  
    .FIELD_RESET_EN      (1),
    .FIELD_RESET_VAL     (0)
  )
  u_opsrv_core_soft_irq_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (1'b0),
      .machine_sw_wr_en            (write_opsrv_core_soft_irq),
      .machine_sw_wr_data          (cpu_regs_req_wr_data[1]),
      .state_val                   (opsrv_core_soft_irq_reg)
    );
    
  
  logic write_opsrv_core_gpr_ded_reset;
  logic opsrv_core_gpr_ded_reset_reg;
  
  assign write_opsrv_core_gpr_ded_reset = write_opsrv_core_soft_reg & cpu_regs_req_wr_byte_en[0];
  
  MIV_RV32IMC_csr_gpr_state_reg
  #(
    .WIDTH               (1),  
    .FIELD_RESET_EN      (1),
    .FIELD_RESET_VAL     (0)
  )
  u_opsrv_core_gpr_ded_reset_reg
    (
      .clk                         (clk),
      .resetn                      (resetn),
      .init_wr_en                  (1'b0),
      .init_wr_data                (1'b0),
      .machine_implicit_wr_en      (1'b0),
      .machine_implicit_wr_data    (1'b0),
      .machine_sw_wr_en            (write_opsrv_core_gpr_ded_reset || gpr_ded_soft_reset),
      .machine_sw_wr_data          (cpu_regs_req_wr_data[2] || gpr_ded_soft_reset),
      .state_val                   (opsrv_core_gpr_ded_reset_reg)
    );
    
    assign opsrv_core_soft_reg = { {29{1'b0}},opsrv_core_gpr_ded_reset_reg, opsrv_core_soft_irq_reg, opsrv_core_soft_reset_reg};
    
    assign opsrv_core_soft_reg_rd_data = {32{read_opsrv_core_soft_reg}} & opsrv_core_soft_reg;
  //--------------------------------------
  
  
  // Submicron CPU core expects read responses one or more cycles after the request is accepted
  // With a small number of registers, the request path is more critical than response path, therefore buffer requests and pipeline
  // The response is the returned directly
  // If acceptance of the response is delayed, this may allow a write to overtake the read, therefore hold off acceptance of 
  // write requests if there is a read still outstanding to the same location.
  
  

  
  assign req_buffer_req_valid = cpu_regs_req_valid & ~req_wr_hzd;
  
  assign req_buffer_reg_sel = {req_is_opsrv_irq_pend,
                               req_is_opsrv_irq_en,
                               req_is_opsrv_cfg_reg,
                               cpu_regs_req_read}; 
  
  MIV_RV32IMC_buffer
  #(
    .BUFF_WIDTH         (REQ_BUFF_WIDTH), 
    .BUFF_SIZE          (REQ_BUFF_DEPTH),
    .PTR_SIZE           (LOG2_REQ_BUFF_DEPTH)
  )
  u_req_buffer
  (
    .clk                (clk),
    .resetn             (resetn),
    .valid_in           (req_buffer_req_valid),
    .ready_in           (req_buffer_req_ready),
    .data_in            (req_buffer_reg_sel),
    .data_out           (req_buffer_resp_sel),     
    .valid_out          (req_buffer_resp_valid),     
    .ready_out          (cpu_regs_resp_ready),
    .data_out_pkd       (req_buffer_resp_sel_pkd), 
    .valid_out_pkd      (req_buffer_resp_valid_pkd), 
    .nearly_full        ()  //open
  );
  
  // check for writes request to registers with read requests outstanding
  // REVISIT. If this affects timing too much, make pessimistic but improve timing by blocking writes if any read outstanding
  
  always @*
  begin : wr_hzd_loop
    integer i;
    logic [REQ_BUFF_DEPTH-1:0] tmp_wr_hzd; 
    logic [REQ_BUFF_WIDTH-1:0] curr_resp_entry;
    tmp_wr_hzd = 1'b0;
    for(i=0; i<REQ_BUFF_DEPTH; i=i+1)
    begin
      curr_resp_entry    = req_buffer_resp_sel_pkd[(i*REQ_BUFF_WIDTH)+:REQ_BUFF_WIDTH];
      tmp_wr_hzd[i]      = ((req_buffer_resp_valid_pkd[i] & curr_resp_entry[REQ_BUFF_WIDTH-1]) &                // valid read response pending
                            (|(req_buffer_reg_sel[REQ_BUFF_WIDTH-2:0] & curr_resp_entry[REQ_BUFF_WIDTH-2:0]))); // to the same register
    end
    req_wr_hzd = cpu_regs_req_write & cpu_regs_req_valid &                                                      // valid write request pending
                 (|tmp_wr_hzd);
  end                  
  
  assign {resp_is_opsrv_irq_pend,
          resp_is_opsrv_irq_en,
          resp_is_opsrv_cfg_reg,
          resp_is_read} = req_buffer_resp_sel;
          
  assign reg_rd_data = opsrv_cfg_reg_rd_data |   
                       opsrv_irq_en_reg_rd_data |
                       opsrv_irq_pend_reg_rd_data;   
  
  // assign outputs
  assign cpu_regs_req_ready      = req_buffer_req_ready & ~req_wr_hzd;  
  assign cpu_regs_resp_valid     = req_buffer_resp_valid;
  assign cpu_regs_resp_error     = req_buffer_resp_valid & ~(|req_buffer_resp_sel[REQ_BUFF_WIDTH-2:0]);
  assign cpu_regs_resp_rd_data   = reg_rd_data;
  assign cpu_regs_resp_rd_data_p = {4{cpu_regs_opsrv_parity_en}} & {(^reg_rd_data[31:24]),
                                                                    (^reg_rd_data[23:16]),
                                                                    (^reg_rd_data[15:8]),
                                                                    (^reg_rd_data[7:0])};
  
  
  assign cpu_regs_axi_rd_cfg_min_size = l_opsrv_axi_rd_cfg_min_size;
  assign cpu_regs_axi_wr_cfg_min_size = l_opsrv_axi_wr_cfg_min_size;
  assign cpu_regs_opsrv_parity_en     = opsrv_parity_en_reg & ~sys_parity_disable;
  assign cpu_regs_cfg_fence_all_src   = l_cfg_fence_all_src;
  assign cpu_regs_cfg_ar_cache        = l_opsrv_cfg_ar_cache;
  assign cpu_regs_cfg_aw_cache        = l_opsrv_cfg_aw_cache;
  assign cpu_regs_cfg_raw_hzd_check   = l_opsrv_cfg_raw_hzd_en;
  assign cpu_regs_cfg_war_hzd_check   = l_opsrv_cfg_war_hzd_en;
  
  assign cpu_regs_core_soft_reset     = opsrv_core_soft_reg[0];     //core_soft_reset output assigned
  assign cpu_regs_core_soft_irq       = opsrv_core_soft_reg[1];     //core_soft_irq output assigned
  
  assign cpu_regs_opsrv_irq[1] = 1'b0;  // UDMA interupts not cureently implemented
  assign cpu_regs_opsrv_irq[0] = |(opsrv_irq_en_reg & opsrv_irq_pend_reg);
  
  

//********************************************************************************
// properties
//********************************************************************************
`ifdef OPSRV_RTL_PROPS

`endif 

endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_opsrv_udma.sv
//
//   Purpose:
//    opsrv MicroDMA engine
//   
//
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none

import MIV_RV32IMC_opsrv_pkg::*;
import MIV_RV32IMC_opsrv_cfg_pkg::*;

module  MIV_RV32IMC_opsrv_udma
//********************************************************************************
// Parameter description

  #(   
    

    parameter AXI_MSTR_ADDR_WIDTH             = 16,
    parameter AHB_MSTR_ADDR_WIDTH             = 16,
    parameter UDMA_CTRL_ADDR_WIDTH            = 12,    
    parameter LMEM0_ADDR_WIDTH                = 16,
    parameter LMEM1_ADDR_WIDTH                = 16

   )

//********************************************************************************
// Port description

  (    
    input wire logic                             resetn,
    input wire logic                             clk,

    // Control/status/config    
    input wire logic                             opsrv_parity_en,   
    output     logic                             trx_os_d_rd,
    output     logic                             trx_os_d_wr,
    
    // CPU control interface
    input wire  logic                            cpu_udma_ctrl_req_valid,
    output      logic                            cpu_udma_ctrl_req_ready, 
    input wire  logic [3:0]                      cpu_udma_ctrl_req_rd_byte_en,  
    input wire  logic [3:0]                      cpu_udma_ctrl_req_wr_byte_en,
    input wire  logic                            cpu_udma_ctrl_req_read,
    input wire  logic                            cpu_udma_ctrl_req_write,
    input wire  logic [UDMA_CTRL_ADDR_WIDTH-1:0] cpu_udma_ctrl_req_addr,
    input wire  logic                            cpu_udma_ctrl_req_addr_p,
    input wire  logic [31:0]                     cpu_udma_ctrl_req_wr_data,
    input wire  logic [3:0]                      cpu_udma_ctrl_req_wr_data_p,
    output      logic                            cpu_udma_ctrl_resp_valid,
    input wire  logic                            cpu_udma_ctrl_resp_ready,
    output      logic                            cpu_udma_ctrl_resp_error,
    output      logic [31:0]                     cpu_udma_ctrl_resp_rd_data,
    output      logic [3:0]                      cpu_udma_ctrl_resp_rd_data_p,
    output      logic                            cpu_udma_ctrl_irq,
    
    // Lmem0 interface   
    output     logic                             udma_lmem0_req_valid,
    input wire logic                             udma_lmem0_req_ready, 
    output     logic [3:0]                       udma_lmem0_req_rd_byte_en,  
    output     logic [3:0]                       udma_lmem0_req_wr_byte_en,
    output     logic                             udma_lmem0_req_read,
    output     logic                             udma_lmem0_req_write,
    output     logic [LMEM0_ADDR_WIDTH-1:0]      udma_lmem0_req_addr,
    output     logic                             udma_lmem0_req_addr_p,
    output     logic [3:0]                       udma_lmem0_req_len,
    output     logic [31:0]                      udma_lmem0_req_wr_data,
    output     logic [3:0]                       udma_lmem0_req_wr_data_p,
    output     logic                             udma_lmem0_req_wr_data_last,
    input wire logic                             udma_lmem0_resp_valid,
    input wire logic                             udma_lmem0_resp_last,
    output     logic                             udma_lmem0_resp_ready,
    input wire logic                             udma_lmem0_resp_rd_error,
    input wire logic [31:0]                      udma_lmem0_resp_rd_data, 
    input wire logic [3:0]                       udma_lmem0_resp_rd_data_p,     
    
    // Lmem1 interface
    output     logic                             udma_lmem1_req_valid,
    input wire logic                             udma_lmem1_req_ready, 
    output     logic [3:0]                       udma_lmem1_req_rd_byte_en,  
    output     logic [3:0]                       udma_lmem1_req_wr_byte_en,
    output     logic                             udma_lmem1_req_read,
    output     logic                             udma_lmem1_req_write,
    output     logic [LMEM1_ADDR_WIDTH-1:0]      udma_lmem1_req_addr,
    output     logic                             udma_lmem1_req_addr_p,
    output     logic [3:0]                       udma_lmem1_req_len,
    output     logic [31:0]                      udma_lmem1_req_wr_data,
    output     logic [3:0]                       udma_lmem1_req_wr_data_p,
    output     logic                             udma_lmem1_req_wr_data_last,
    input wire logic                             udma_lmem1_resp_valid,
    input wire logic                             udma_lmem1_resp_last,
    output     logic                             udma_lmem1_resp_ready,
    input wire logic                             udma_lmem1_resp_rd_error,
    input wire logic [31:0]                      udma_lmem1_resp_rd_data, 
    input wire logic [3:0]                       udma_lmem1_resp_rd_data_p,           
    
    // AXI master interface
    output     logic                             udma_axi_req_valid,
    input wire logic                             udma_axi_req_ready, 
    output     logic [3:0]                       udma_axi_req_rd_byte_en,  
    output     logic [3:0]                       udma_axi_req_wr_byte_en,
    output     logic                             udma_axi_req_read,  
    output     logic                             udma_axi_req_write,
    output     logic [AXI_MSTR_ADDR_WIDTH-1:0]   udma_axi_req_addr,
    output     logic                             udma_axi_req_addr_p,
    output     logic [3:0]                       udma_axi_req_len,
    output     logic [31:0]                      udma_axi_req_wr_data,
    output     logic [3:0]                       udma_axi_req_wr_data_p,
    output     logic                             udma_axi_req_wr_data_last,
    input wire logic                             udma_axi_resp_valid,
    input wire logic                             udma_axi_resp_last,
    output     logic                             udma_axi_resp_ready,
    input wire logic                             udma_axi_resp_rd_error,
    input wire logic [31:0]                      udma_axi_resp_rd_data, 
    input wire logic [3:0]                       udma_axi_resp_rd_data_p,
    input wire logic                             udma_axi_wr_resp_err,
    
    // AHB master interface
    output     logic                             udma_ahb_req_valid,
    input wire logic                             udma_ahb_req_ready, 
    output     logic [3:0]                       udma_ahb_req_rd_byte_en,  
    output     logic [3:0]                       udma_ahb_req_wr_byte_en,
    output     logic                             udma_ahb_req_read,  
    output     logic                             udma_ahb_req_write,
    output     logic [AHB_MSTR_ADDR_WIDTH-1:0]   udma_ahb_req_addr,
    output     logic                             udma_ahb_req_addr_p,
    output     logic [3:0]                       udma_ahb_req_len,
    output     logic [31:0]                      udma_ahb_req_wr_data,
    output     logic [3:0]                       udma_ahb_req_wr_data_p,
    output     logic                             udma_ahb_req_wr_data_last,
    input wire logic                             udma_ahb_resp_valid,
    input wire logic                             udma_ahb_resp_last,
    output     logic                             udma_ahb_resp_ready,
    input wire logic                             udma_ahb_resp_rd_error,
    input wire logic [31:0]                      udma_ahb_resp_rd_data, 
    input wire logic [3:0]                       udma_ahb_resp_rd_data_p,   
    
    // APB DAP interface   
    input wire  logic                            apb_dap_udma_ctrl_req_valid,
    output      logic                            apb_dap_udma_ctrl_req_ready, 
    input wire  logic [3:0]                      apb_dap_udma_ctrl_req_rd_byte_en,  
    input wire  logic [3:0]                      apb_dap_udma_ctrl_req_wr_byte_en,
    input wire  logic [UDMA_CTRL_ADDR_WIDTH-1:0] apb_dap_udma_ctrl_req_addr,
    input wire  logic                            apb_dap_udma_ctrl_req_addr_p,
    input wire  logic [31:0]                     apb_dap_udma_ctrl_req_wr_data,
    input wire  logic [3:0]                      apb_dap_udma_ctrl_req_wr_data_p,
    output      logic                            apb_dap_udma_ctrl_resp_valid,
    input wire  logic                            apb_dap_udma_ctrl_resp_ready,
    output      logic                            apb_dap_udma_ctrl_resp_rd_error,
    output      logic [31:0]                     apb_dap_udma_ctrl_resp_rd_data,
    output      logic [3:0]                      apb_dap_udma_ctrl_resp_rd_data_p,
    output      logic                            apb_dap_udma_ctrl_irq
    
    
  );

//********************************************************************************
// Declarations

// localparams



// Internal nets


 logic                            cpu_udma_ctrl_sys_bus_rd_err;
 logic                            cpu_udma_ctrl_sys_bus_wr_err;
 logic                            cpu_udma_ctrl_lmem0_correctable_ecc_err;
 logic                            cpu_udma_ctrl_lmem0_uncorrectable_ecc_err;
 logic                            cpu_udma_ctrl_lmem1_correctable_ecc_err;
 logic                            cpu_udma_ctrl_lmem1_uncorrectable_ecc_err;



//********************************************************************************
// Main code
//********************************************************************************


 

endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_rr_pri_arb.sv
//
//   Purpose: Parameterized round-robin arbiter
//
//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_rr_pri_arb
//********************************************************************************
// Parameter description

  #(
     parameter NUM_REQS = 3,
     parameter USE_FORMAL = 1,
     parameter USE_SIM = 1
   )

//********************************************************************************
// Port description

  (
    input wire                  resetn,
    input wire                  clk,
    input wire                  unlock,
    input wire [NUM_REQS-1:0]   req, 
    output wire [NUM_REQS-1:0]  gnt,  
    output wire [NUM_REQS-1:0]  sel_seq,
    output wire [NUM_REQS-1:0]  sel_early
    
 
    
  );

//********************************************************************************
// localparams
// Declarations

  wire                       go_next_pri; 
  reg [NUM_REQS-1:0]         hipri_req_ptr;
  wire [NUM_REQS-1:0]        next_hipri_req_ptr;
  wire [(2*NUM_REQS)-1:0]    hipri_req_ptr_dbl;
  
  wire [(2*NUM_REQS)-1:0]    req_dbl;
  wire [NUM_REQS-1:0]        gnt_fixarb[NUM_REQS-1:0];
  
  reg [NUM_REQS-1:0]         tmp_gnt;
  
  wire [NUM_REQS-1:0]        req_shifted [NUM_REQS-1:0];
  wire [NUM_REQS-1:0]        gnt_shifted [NUM_REQS-1:0];
  wire [(2*NUM_REQS)-1:0]    gnt_shifted_dbl [NUM_REQS-1:0];
  wire [NUM_REQS-1:0]        gnt_unshifted [NUM_REQS-1:0];
  
  wire [NUM_REQS-1:0]        req_masked;
  reg                        is_locked;
  reg  [NUM_REQS-1:0]        sel_reg;
  wire [NUM_REQS-1:0]        next_sel_reg;

// Internal nets

//********************************************************************************
// Main code
//********************************************************************************
  
  // REVISIT Round robin for now - change to pseudo random
  
  // Onehot encoding as needs to be speedy
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      hipri_req_ptr <= 1'b1;  //will be implicitly extended (a bit nasty)!!
    else
      hipri_req_ptr <= next_hipri_req_ptr;        
  end 

  assign go_next_pri = |tmp_gnt;
  //assign hipri_req_ptr_dbl = {hipri_req_ptr,hipri_req_ptr} >> 1;
  assign hipri_req_ptr_dbl = {tmp_gnt,tmp_gnt} << 1;
  assign next_hipri_req_ptr = go_next_pri ? hipri_req_ptr_dbl[NUM_REQS+:NUM_REQS] : hipri_req_ptr;  
  
  // implement rr arbiter as a set of fixed priortiy arbiters with the request rotated for each,
  // then select which to use based on the pointer - a bit big, but fast
  
  // mask new requests when locked.
  assign req_masked = req & {NUM_REQS{~is_locked}};  //{NUM_REQS{(unlock | ~is_locked)}};
  assign req_dbl = {req_masked,req_masked};
  
  generate
  genvar i_priarb;
  for (i_priarb = 0; i_priarb < NUM_REQS; i_priarb = i_priarb+1) begin : gen_pri_arb
    
    assign req_shifted[i_priarb] = req_dbl[i_priarb+:NUM_REQS];
  
    MIV_RV32IMC_fixed_arb
    //***************************************************************
    // Parameter description
   #(
      .NUM_REQS            (NUM_REQS)
    )

    u_MIV_RV32IMC_fixed_arb
    //***************************************************************
    // Signal description
    (
      .req                 (req_shifted[i_priarb]),
      .gnt                 (gnt_shifted[i_priarb]),
      .gnt_dbl             (gnt_shifted_dbl[i_priarb])
    ); 
    
    assign gnt_unshifted[i_priarb] = gnt_shifted_dbl[i_priarb][(NUM_REQS-i_priarb)+:NUM_REQS];
    
  end
  endgenerate 
  
  always @*
  begin : rr_pri_mux_loop
    integer i;
    tmp_gnt = {NUM_REQS{1'b0}};
    for(i=0; i<NUM_REQS; i=i+1)
    begin
      tmp_gnt = tmp_gnt | ({NUM_REQS{hipri_req_ptr[i]}} & gnt_unshifted[i]);
    end
  end
  
  assign gnt = tmp_gnt;    
  
  // if lock is enabled, when a request is granted, hold the selected request (sel output) until the unlock
  // signal is seen
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      is_locked <= 1'b0;  
    else
      is_locked <= ((|tmp_gnt) | is_locked) & ~unlock;      
  end 
  
  
  always @(posedge clk or negedge resetn)
  begin
    if(~resetn)
      sel_reg <= {NUM_REQS{1'b0}};  
    else
      sel_reg <= next_sel_reg;      
  end 
  
  assign next_sel_reg = is_locked ? sel_reg : tmp_gnt; 
  
  assign sel_seq    = sel_reg;
  assign sel_early  = next_sel_reg;


endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File:
//   MIV_RV32IMC_strb_to_addr.sv
//
//   Purpose:

//   
//
//
//   Author: $Author:  $
//
//   Version: $Revision:  $
//
//   Date: $Date:  $
//
//   Revision History:
// 
//   Revision:
//
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

`default_nettype none


module  MIV_RV32IMC_strb_to_addr
//********************************************************************************
// Parameter description
  #(
      parameter NUM_BYTES = 8
   )
//********************************************************************************
// Port description

  (
    //inputs
    input wire                               resetn,
    input wire                               clk,
    
    input wire [NUM_BYTES-1:0]               strb,
    input wire [1:0]                         cfg_min_size,
    
    output wire [2:0]                        addr,
    output wire [1:0]                        size 

  );

//********************************************************************************
// localparams
// Declarations

  wire [2:0]  addr_nosmask;
  reg [1:0]   ax_size;
  wire [2:0]  ax_size_mask;
  wire [2:0]  cfg_size_mask;
  wire [1:0]  size_min;
  wire [7:0]  byte_strb;
  
// Internal nets

//********************************************************************************
// Main code
//********************************************************************************
  // extend strobes in 4 byte config
  generate if(NUM_BYTES == 4) begin : gen_4byte
    assign byte_strb = {4'b0000,strb};   
  end
  else begin : gen_8byte
    assign byte_strb = strb; 
  end
  endgenerate 

  // fully decode write strobes (only use simple be mode)
  // byte_strb    size  addr[2] [1] [0]   
  
  // 0000_0001    0         0   0   0   
  // 0000_0010    0         0   0   1
  // 0000_0100    0         0   1   0
  // 0000_1000    0         0   1   1
  // 0001_0000    0         1   0   0
  // 0010_0000    0         1   0   1
  // 0100_0000    0         1   1   0
  // 1000_0000    0         1   1   1
  // 0000_0011    1         0   0   x
  // 0000_1100    1         0   1   x
  // 0011_0000    1         1   0   x
  // 1100_0000    1         1   1   x
  // 0000_1111    2         0   x   x
  // 1111_0000    2         1   x   x
  // 1111_1111    3         x   x   x
   
  assign addr_nosmask[0] = byte_strb[7] | byte_strb[5] | byte_strb[3] | byte_strb[1];
  assign addr_nosmask[1] = byte_strb[7] | byte_strb[6] | byte_strb[3] | byte_strb[2];   
  assign addr_nosmask[2] = byte_strb[7] | byte_strb[6] | byte_strb[5] | byte_strb[4]; 
    // mask address bits based on size to ensure correct alignment
  always @*
  begin
    case(byte_strb)
      8'b0000_0001:  ax_size = 2'd0;
      8'b0000_0010:  ax_size = 2'd0;
      8'b0000_0100:  ax_size = 2'd0;
      8'b0000_1000:  ax_size = 2'd0;
      8'b0001_0000:  ax_size = 2'd0;
      8'b0010_0000:  ax_size = 2'd0;
      8'b0100_0000:  ax_size = 2'd0;
      8'b1000_0000:  ax_size = 2'd0;
      8'b0000_0011:  ax_size = 2'd1;
      8'b0000_1100:  ax_size = 2'd1;
      8'b0011_0000:  ax_size = 2'd1;
      8'b1100_0000:  ax_size = 2'd1;
      8'b0000_1111:  ax_size = 2'd2;
      8'b1111_0000:  ax_size = 2'd2;
      8'b1111_1111:  ax_size = 2'd3;
      default:       ax_size = 2'd3;
    endcase
  end
  
  assign ax_size_mask = (ax_size == 2'd0) ? 3'b000 :
                        (ax_size == 2'd1) ? 3'b001 :
                        (ax_size == 2'd2) ? 3'b011 :
                                            3'b111;
                                          
                                          
  assign cfg_size_mask = (cfg_min_size == 2'd0) ? 3'b000 :
                         (cfg_min_size == 2'd1) ? 3'b001 :
                         (cfg_min_size == 2'd2) ? 3'b011 :
                                                  3'b111;  
  
  assign size_min       = (ax_size >= cfg_min_size) ? ax_size : cfg_min_size;
                                                  
                                              
  assign addr =  addr_nosmask & ~ax_size_mask & ~cfg_size_mask; 
  assign size =  size_min;

endmodule


`default_nettype wire

// Copyright (c) 2020, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2020, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
////////////////////////////////////////////////////////////////////////////////
module MIV_RV32IMC_ram_singleport_addreg
//********************************************************************************
// Parameter description

  #(
    parameter RAM_DEPTH            = 4096,
    parameter ADDR_WIDTH           = 12  ,
    parameter DATA_WIDTH           = 36,
    parameter WEN_WIDTH            = 4,
    parameter RAM_SB_IN_WIDTH      = 4,
    parameter RAM_SB_OUT_WIDTH      = 4
  )

//********************************************************************************
// Port description

  (
    input  wire logic                           rstb,
    input  wire logic                           clk,
    input  wire logic [ADDR_WIDTH-1:0]          addr,
    input  wire logic                           ce,
    input  wire logic [WEN_WIDTH-1:0]           we,
    input  wire logic                           ret1n,
    input  wire logic                           pg_override,
    input  wire logic                           ecc_bypass,
    input  wire logic [2-1:0]                   ram_err_inject,
    input  wire logic [DATA_WIDTH-1:0]          din,
    output      logic [DATA_WIDTH-1:0]          dout,
    output      logic [2-1:0]                   ecc_err,
    output      logic [2-1:0]                   ecc_err_int,
    input  wire logic [RAM_SB_IN_WIDTH-1: 0]    ram_sb_in,
    output      logic [RAM_SB_OUT_WIDTH-1: 0]   ram_sb_out

  );
//********************************************************************************
// Declarations

// localparams



// Internal nets
   reg [ADDR_WIDTH-1:0] addr_reg;
   reg [DATA_WIDTH - 1:0] mem [RAM_DEPTH-1:0] ;
   //wire ECC_LMEM_0_ERR_NET;



//********************************************************************************
// Main code
//********************************************************************************


  //  assign ecc_err = ECC_LMEM_0_ERR_NET;
  assign ecc_err = 2'b0; // tied to 0
  assign ecc_err_int = 2'b0;// tied to 0
  assign ram_sb_out = {RAM_SB_OUT_WIDTH{1'b0}}; // Signal temp tied to 0, DCS to assign registered o/p.

  generate
  if(WEN_WIDTH == 1) begin
    always@(posedge clk)
    begin
        addr_reg <= addr;
        if(we[0]) mem[addr[ADDR_WIDTH-1:0] >> 2][(DATA_WIDTH - 1):0] <= din[(DATA_WIDTH - 1):0];  // Changed to account for parity bits
    end
  end else begin 
    always@(posedge clk)
    begin
        addr_reg <= addr;
        if(we[3]) mem[addr[ADDR_WIDTH-1:0] >> 2][31:24] <= din[31:24]; // REVISIT - Add parity bits
        if(we[2]) mem[addr[ADDR_WIDTH-1:0] >> 2][23:16] <= din[23:16];
        if(we[1]) mem[addr[ADDR_WIDTH-1:0] >> 2][15:8 ] <= din[15:8 ];
        if(we[0]) mem[addr[ADDR_WIDTH-1:0] >> 2][ 7:0 ] <= din[ 7:0 ];
    end
  end
  endgenerate
    assign dout = mem[addr_reg[ADDR_WIDTH-1:0] >> 2];

endmodule


`default_nettype wire

