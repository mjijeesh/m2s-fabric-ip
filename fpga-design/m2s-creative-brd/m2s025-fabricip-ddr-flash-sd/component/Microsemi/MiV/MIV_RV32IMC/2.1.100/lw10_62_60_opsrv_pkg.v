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



package MIV_RV32IMC_opsrv_pkg;

//------------------
// Global definitions
//------------------

  localparam l_opsrv_cfg_cpu_addr_width                    = 32;
  localparam L_XLEN = 32;                            
//-----------------------
// Functions 
//-----------------------

   //***************************************************************************
   // Constant function for Ceiling Log Base 2: ceiling(log2(n))
   // Unlike $clog2(1) = 0, this function returns func_clog2(1) = 1
   //***************************************************************************
   function integer func_clog2 (input integer value);
      integer val;
      begin
         val = (value == 1) ?  value : value - 1;
         for (func_clog2 = 0; val > 0; func_clog2 = func_clog2 + 1) begin
            val = val >> 1;
         end
      end
   endfunction
   
                
 
endpackage


`default_nettype wire
