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

////////////////////////////////////////////////////////////////////////////////
//
//   File: core_pkg.sv
//
//   Purpose: core shared package
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

`ifdef core_MACROS
`else
  `define core_MACROS 1
  `define core_MACRO_MAX(a,b) (a)>(b)?(a):(b)
`endif

package miv_rv32_pkg;

//------------------
// Global definitions
//------------------

  localparam L_XLEN = 32;

//------------------
// Instruction list
//------------------



//----------------
// Register file
//----------------

          
 
//----------------
// CSR
//----------------   

  localparam logic [1:0] l_core_mode_machine     = 2'd3;   
  localparam logic [1:0] l_core_mode_supervisor  = 2'd1;
  localparam logic [1:0] l_core_mode_user        = 2'd0;                      
                                       
//****************************************************************************
// csr address literals
//**************************************************************************** 
  
  localparam logic [1:0] l_mtvec_mode_direct = 2'd0;
  localparam logic [1:0] l_mtvec_mode_vectored = 2'd1;
  
//Machine Information Registers  
  localparam logic [11:0] l_core_csr_addr_mvendorid      =   12'hF11;   // Vendor ID.
  localparam logic [11:0] l_core_csr_addr_marchid        =   12'hF12;   // Architecture ID.
  localparam logic [11:0] l_core_csr_addr_mimpid         =   12'hF13;   // Implementation ID.
  localparam logic [11:0] l_core_csr_addr_mhartid        =   12'hF14;   // Hardware thread ID.
//Machine Trap Setup
  localparam logic [11:0] l_core_csr_addr_mstatus        =   12'h300;   // Machine status register.
  localparam logic [11:0] l_core_csr_addr_misa           =   12'h301;   // ISA and extensions
  localparam logic [11:0] l_core_csr_addr_medeleg        =   12'h302;   // Machine exception delegation register.
  localparam logic [11:0] l_core_csr_addr_mideleg        =   12'h303;   // Machine interrupt delegation register.
  localparam logic [11:0] l_core_csr_addr_mie            =   12'h304;   // Machine interrupt-enable register.
  localparam logic [11:0] l_core_csr_addr_mtvec          =   12'h305;   // Machine trap-handler base address.
  localparam logic [11:0] l_core_csr_addr_mcounteren     =   12'h306;   // Machine counter enable.
//Machine Trap Handling
  localparam logic [11:0] l_core_csr_addr_mscratch       =   12'h340;   // Scratch register for machine trap handlers.
  localparam logic [11:0] l_core_csr_addr_mepc           =   12'h341;   // Machine exception program counter.
  localparam logic [11:0] l_core_csr_addr_mcause         =   12'h342;   // mcause Machine trap cause.
  localparam logic [11:0] l_core_csr_addr_mtval          =   12'h343;   // mtval Machine bad address or instruction.
  localparam logic [11:0] l_core_csr_addr_mip            =   12'h344;   // mip Machine interrupt pending.
//Machine Protection and Translation
  localparam logic [11:0] l_core_csr_addr_pmpcfg0        =   12'h3A0;   // pmpcfg0 Physical memory protection configuration.
  localparam logic [11:0] l_core_csr_addr_pmpcfg1        =   12'h3A1;   // pmpcfg1 Physical memory protection configuration.
  localparam logic [11:0] l_core_csr_addr_pmpcfg2        =   12'h3A2;   // pmpcfg2 Physical memory protection configuration.
  localparam logic [11:0] l_core_csr_addr_pmpcfg3        =   12'h3A3;   // pmpcfg3 Physical memory protection configuration.
  localparam logic [11:0] l_core_csr_addr_pmpaddr0       =   12'h3B0;   // Physical memory protection address register 0.
  localparam logic [11:0] l_core_csr_addr_pmpaddr1       =   12'h3B1;   // Physical memory protection address register 1.
  localparam logic [11:0] l_core_csr_addr_pmpaddr2       =   12'h3B2;   // Physical memory protection address register 2.
  localparam logic [11:0] l_core_csr_addr_pmpaddr3       =   12'h3B3;   // Physical memory protection address register 3.
  localparam logic [11:0] l_core_csr_addr_pmpaddr4       =   12'h3B4;   // Physical memory protection address register 4.
  localparam logic [11:0] l_core_csr_addr_pmpaddr5       =   12'h3B5;   // Physical memory protection address register 5.
  localparam logic [11:0] l_core_csr_addr_pmpaddr6       =   12'h3B6;   // Physical memory protection address register 6.
  localparam logic [11:0] l_core_csr_addr_pmpaddr7       =   12'h3B7;   // Physical memory protection address register 7.
  localparam logic [11:0] l_core_csr_addr_pmpaddr8       =   12'h3B8;   // Physical memory protection address register 8.
  localparam logic [11:0] l_core_csr_addr_pmpaddr9       =   12'h3B9;   // Physical memory protection address register 9.
  localparam logic [11:0] l_core_csr_addr_pmpaddr10      =   12'h3BA;   // Physical memory protection address register 10.
  localparam logic [11:0] l_core_csr_addr_pmpaddr11      =   12'h3BB;   // Physical memory protection address register 11.
  localparam logic [11:0] l_core_csr_addr_pmpaddr12      =   12'h3BC;   // Physical memory protection address register 12.
  localparam logic [11:0] l_core_csr_addr_pmpaddr13      =   12'h3BD;   // Physical memory protection address register 13.
  localparam logic [11:0] l_core_csr_addr_pmpaddr14      =   12'h3BE;   // Physical memory protection address register 14.
  localparam logic [11:0] l_core_csr_addr_pmpaddr15      =   12'h3BF;   // Physical memory protection address register 15.
//Machine Counter/Timers
  localparam logic [11:0] l_core_csr_addr_mcycle         =   12'hB00;   // Machine cycle counter.
  localparam logic [11:0] l_core_csr_addr_minstret       =   12'hB02;   // Machine instructions-retired counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter3   =   12'hB03;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter4   =   12'hB04;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter5   =   12'hB05;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter6   =   12'hB06;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter7   =   12'hB07;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter8   =   12'hB08;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter9   =   12'hB09;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter10  =   12'hB0A;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter11  =   12'hB0B;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter12  =   12'hB0C;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter13  =   12'hB0D;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter14  =   12'hB0E;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter15  =   12'hB0F;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter16  =   12'hB10;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter17  =   12'hB11;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter18  =   12'hB12;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter19  =   12'hB13;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter20  =   12'hB14;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter21  =   12'hB15;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter22  =   12'hB16;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter23  =   12'hB17;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter24  =   12'hB18;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter25  =   12'hB19;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter26  =   12'hB1A;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter27  =   12'hB1B;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter28  =   12'hB1C;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter29  =   12'hB1D;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter30  =   12'hB1E;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mhpmcounter31  =   12'hB1F;   // Machine performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_mcycleh        =   12'hB80;   // Upper 32 bits of mcycle, RV32I only.
  localparam logic [11:0] l_core_csr_addr_minstreth      =   12'hB82;   // Upper 32 bits of minstret, RV32I only.  
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh3  =   12'hB83;   // Upper 32 bits of mhpmcounter3 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh4  =   12'hB84;   // Upper 32 bits of mhpmcounter4 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh5  =   12'hB85;   // Upper 32 bits of mhpmcounter5 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh6  =   12'hB86;   // Upper 32 bits of mhpmcounter6 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh7  =   12'hB87;   // Upper 32 bits of mhpmcounter7 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh8  =   12'hB88;   // Upper 32 bits of mhpmcounter8 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh9  =   12'hB89;   // Upper 32 bits of mhpmcounter9 
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh10 =   12'hB8A;   // Upper 32 bits of mhpmcounter10
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh11 =   12'hB8B;   // Upper 32 bits of mhpmcounter11
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh12 =   12'hB8C;   // Upper 32 bits of mhpmcounter12
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh13 =   12'hB8D;   // Upper 32 bits of mhpmcounter13
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh14 =   12'hB8E;   // Upper 32 bits of mhpmcounter14
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh15 =   12'hB8F;   // Upper 32 bits of mhpmcounter15
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh16 =   12'hB90;   // Upper 32 bits of mhpmcounter16
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh17 =   12'hB91;   // Upper 32 bits of mhpmcounter17
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh18 =   12'hB92;   // Upper 32 bits of mhpmcounter18
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh19 =   12'hB93;   // Upper 32 bits of mhpmcounter19
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh20 =   12'hB94;   // Upper 32 bits of mhpmcounter20
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh21 =   12'hB95;   // Upper 32 bits of mhpmcounter21
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh22 =   12'hB96;   // Upper 32 bits of mhpmcounter22
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh23 =   12'hB97;   // Upper 32 bits of mhpmcounter23
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh24 =   12'hB98;   // Upper 32 bits of mhpmcounter24
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh25 =   12'hB99;   // Upper 32 bits of mhpmcounter25
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh26 =   12'hB9A;   // Upper 32 bits of mhpmcounter26
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh27 =   12'hB9B;   // Upper 32 bits of mhpmcounter27
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh28 =   12'hB9C;   // Upper 32 bits of mhpmcounter28
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh29 =   12'hB9D;   // Upper 32 bits of mhpmcounter29
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh30 =   12'hB9E;   // Upper 32 bits of mhpmcounter30
  localparam logic [11:0] l_core_csr_addr_mhpmcounterh31 =   12'hB9F;   // Upper 32 bits of mhpmcounter31
//Machine Counter Setup
  localparam logic [11:0] l_core_csr_addr_mcounterinhibit =   12'h320;   // Machine counter-inhibit register.
  localparam logic [11:0] l_core_csr_addr_mhpmevent3     =   12'h323;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent4     =   12'h324;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent5     =   12'h325;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent6     =   12'h326;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent7     =   12'h327;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent8     =   12'h328;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent9     =   12'h329;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent10    =   12'h32A;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent11    =   12'h32B;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent12    =   12'h32C;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent13    =   12'h32D;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent14    =   12'h32E;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent15    =   12'h32F;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent16    =   12'h330;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent17    =   12'h331;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent18    =   12'h332;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent19    =   12'h333;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent20    =   12'h334;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent21    =   12'h335;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent22    =   12'h336;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent23    =   12'h337;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent24    =   12'h338;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent25    =   12'h339;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent26    =   12'h33A;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent27    =   12'h33B;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent28    =   12'h33C;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent29    =   12'h33D;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent30    =   12'h33E;   // Machine performance-monitoring event selector.
  localparam logic [11:0] l_core_csr_addr_mhpmevent31    =   12'h33F;   // Machine performance-monitoring event selector
  
//Supervisor Trap Setup
  localparam logic [11:0] l_core_csr_addr_sstatus        =   12'h100;   // Supervisor status register. 
  localparam logic [11:0] l_core_csr_addr_sedeleg        =   12'h102;   // Supervisor exception delegation register..
  localparam logic [11:0] l_core_csr_addr_sideleg        =   12'h103;   // Supervisor interrupt delegation register.
  localparam logic [11:0] l_core_csr_addr_sie            =   12'h104;   // Supervisor interrupt-enable register.
  localparam logic [11:0] l_core_csr_addr_stvec          =   12'h105;   // Supervisor trap handler base address.
  localparam logic [11:0] l_core_csr_addr_scounteren     =   12'h106;   // Supervisor counter enable.
//Supervisor Trap Handling
  localparam logic [11:0] l_core_csr_addr_sscratch       =   12'h140;   // Scratch register for supervisor trap handlers.
  localparam logic [11:0] l_core_csr_addr_sepc           =   12'h141;   // Supervisor exception program counter.
  localparam logic [11:0] l_core_csr_addr_scause         =   12'h142;   // Supervisor trap cause.
  localparam logic [11:0] l_core_csr_addr_stval          =   12'h143;   // Supervisor bad address or instruction.
  localparam logic [11:0] l_core_csr_addr_sip            =   12'h144;   // Supervisor interrupt pending.
//Supervisor Protection and Translation
  localparam logic [11:0] l_core_csr_addr_satp           =   12'h180;   // Supervisor address translation and protection.
  
  
//User Trap Setup
  localparam logic [11:0] l_core_csr_addr_ustatus        =   12'h000;   // User status register.
  localparam logic [11:0] l_core_csr_addr_uie            =   12'h004;   // User interrupt-enable register.
  localparam logic [11:0] l_core_csr_addr_utvec          =   12'h005;   // utvec User trap handler base address.
//User Trap Handling
  localparam logic [11:0] l_core_csr_addr_uscratch       =   12'h040;   // Scratch register for user trap handlers.
  localparam logic [11:0] l_core_csr_addr_uepc           =   12'h041;   // User exception program counter.
  localparam logic [11:0] l_core_csr_addr_ucause         =   12'h042;   // User trap cause.
  localparam logic [11:0] l_core_csr_addr_utval          =   12'h043;   // User bad address or instruction.
  localparam logic [11:0] l_core_csr_addr_uip            =   12'h044;   // User interrupt pending.
//User Floating-Point CSRs
  localparam logic [11:0] l_core_csr_addr_fflags         =   12'h001;   // Floating-Point Accrued Exceptions.
  localparam logic [11:0] l_core_csr_addr_frm            =   12'h002;   // Floating-Point Dynamic Rounding Mode.
  localparam logic [11:0] l_core_csr_addr_fcsr           =   12'h002;   // Floating-Point Control and Status Register (frm + fflags).
//User Counter/Timers
  localparam logic [11:0] l_core_csr_addr_cycle          =   12'hC00;   // Cycle counter for RDCYCLE instruction.
  localparam logic [11:0] l_core_csr_addr_time           =   12'hC01;   // Timer for RDTIME instruction.
  localparam logic [11:0] l_core_csr_addr_instret        =   12'hC02;   // Instructions-retired counter for RDINSTRET instruction.
  localparam logic [11:0] l_core_csr_addr_hpmcounter3    =   12'hC03;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter4    =   12'hC04;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter5    =   12'hC05;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter6    =   12'hC06;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter7    =   12'hC07;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter8    =   12'hC08;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter9    =   12'hC09;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter10   =   12'hC0A;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter11   =   12'hC0B;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter12   =   12'hC0C;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter13   =   12'hC0D;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter14   =   12'hC0E;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter15   =   12'hC0F;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter16   =   12'hC10;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter17   =   12'hC11;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter18   =   12'hC12;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter19   =   12'hC13;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter20   =   12'hC14;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter21   =   12'hC15;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter22   =   12'hC16;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter23   =   12'hC17;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter24   =   12'hC18;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter25   =   12'hC19;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter26   =   12'hC1A;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter27   =   12'hC1B;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter28   =   12'hC1C;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter29   =   12'hC1D;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter30   =   12'hC1E;   // performance-monitoring counter.
  localparam logic [11:0] l_core_csr_addr_hpmcounter31   =   12'hC1F;   // performance-monitoring counter.

  localparam logic [11:0] l_core_csr_addr_cycleh         =   12'hC80;   // Upper 32 bits of cycle, RV32I only.
  localparam logic [11:0] l_core_csr_addr_timeh          =   12'hC81;   // Upper 32 bits of time, RV32I only.
  localparam logic [11:0] l_core_csr_addr_instreth       =   12'hC82;   // Upper 32 bits of instret, RV32I only.
  localparam logic [11:0] l_core_csr_addr_hpmcounterh3   =   12'hC83;   // Upper 32 bits of hpmcounter3 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh4   =   12'hC84;   // Upper 32 bits of hpmcounter4 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh5   =   12'hC85;   // Upper 32 bits of hpmcounter5 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh6   =   12'hC86;   // Upper 32 bits of hpmcounter6 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh7   =   12'hC87;   // Upper 32 bits of hpmcounter7 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh8   =   12'hC88;   // Upper 32 bits of hpmcounter8 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh9   =   12'hC89;   // Upper 32 bits of hpmcounter9 
  localparam logic [11:0] l_core_csr_addr_hpmcounterh10  =   12'hC8A;   // Upper 32 bits of hpmcounter10
  localparam logic [11:0] l_core_csr_addr_hpmcounterh11  =   12'hC8B;   // Upper 32 bits of hpmcounter11
  localparam logic [11:0] l_core_csr_addr_hpmcounterh12  =   12'hC8C;   // Upper 32 bits of hpmcounter12
  localparam logic [11:0] l_core_csr_addr_hpmcounterh13  =   12'hC8D;   // Upper 32 bits of hpmcounter13
  localparam logic [11:0] l_core_csr_addr_hpmcounterh14  =   12'hC8E;   // Upper 32 bits of hpmcounter14
  localparam logic [11:0] l_core_csr_addr_hpmcounterh15  =   12'hC8F;   // Upper 32 bits of hpmcounter15
  localparam logic [11:0] l_core_csr_addr_hpmcounterh16  =   12'hC90;   // Upper 32 bits of hpmcounter16
  localparam logic [11:0] l_core_csr_addr_hpmcounterh17  =   12'hC91;   // Upper 32 bits of hpmcounter17
  localparam logic [11:0] l_core_csr_addr_hpmcounterh18  =   12'hC92;   // Upper 32 bits of hpmcounter18
  localparam logic [11:0] l_core_csr_addr_hpmcounterh19  =   12'hC93;   // Upper 32 bits of hpmcounter19
  localparam logic [11:0] l_core_csr_addr_hpmcounterh20  =   12'hC94;   // Upper 32 bits of hpmcounter20
  localparam logic [11:0] l_core_csr_addr_hpmcounterh21  =   12'hC95;   // Upper 32 bits of hpmcounter21
  localparam logic [11:0] l_core_csr_addr_hpmcounterh22  =   12'hC96;   // Upper 32 bits of hpmcounter22
  localparam logic [11:0] l_core_csr_addr_hpmcounterh23  =   12'hC97;   // Upper 32 bits of hpmcounter23
  localparam logic [11:0] l_core_csr_addr_hpmcounterh24  =   12'hC98;   // Upper 32 bits of hpmcounter24
  localparam logic [11:0] l_core_csr_addr_hpmcounterh25  =   12'hC99;   // Upper 32 bits of hpmcounter25
  localparam logic [11:0] l_core_csr_addr_hpmcounterh26  =   12'hC9A;   // Upper 32 bits of hpmcounter26
  localparam logic [11:0] l_core_csr_addr_hpmcounterh27  =   12'hC9B;   // Upper 32 bits of hpmcounter27
  localparam logic [11:0] l_core_csr_addr_hpmcounterh28  =   12'hC9C;   // Upper 32 bits of hpmcounter28
  localparam logic [11:0] l_core_csr_addr_hpmcounterh29  =   12'hC9D;   // Upper 32 bits of hpmcounter29
  localparam logic [11:0] l_core_csr_addr_hpmcounterh30  =   12'hC9E;   // Upper 32 bits of hpmcounter30
  localparam logic [11:0] l_core_csr_addr_hpmcounterh31  =   12'hC9F;   // Upper 32 bits of hpmcounter31
  
  localparam logic [11:0] l_core_csr_addr_tselect        =   12'h7A0;   // Debug/Trace trigger register select.
  localparam logic [11:0] l_core_csr_addr_tdata1         =   12'h7A1;   // First Debug/Trace trigger data register.
  localparam logic [11:0] l_core_csr_addr_tdata2         =   12'h7A2;   // Second Debug/Trace trigger data register.
  localparam logic [11:0] l_core_csr_addr_tdata3         =   12'h7A3;   // Third Debug/Trace trigger data register.
  localparam logic [11:0] l_core_csr_addr_tcontrol       =   12'h7A5;   // Trigger control register register
  localparam logic [11:0] l_core_csr_addr_mcontext       =   12'h7A8;   // Trigger machine context register
  localparam logic [11:0] l_core_csr_addr_scontext       =   12'h7AA;   // Trigger supervisor context register
  
  localparam logic [11:0] l_core_csr_addr_dcsr           =   12'h7B0;   // Debug control and status register.
  localparam logic [11:0] l_core_csr_addr_dpc            =   12'h7B1;   // Debug PC
  localparam logic [11:0] l_core_csr_addr_dscratch0      =   12'h7B2;   // Debug scratch register 0
  localparam logic [11:0] l_core_csr_addr_dscratch1      =   12'h7B3;   // Debug scratch register 1


//----------------
// IFU
//----------------

  typedef enum logic       {iab_rd_alignment_word,
                            iab_rd_alignment_hword} t_iab_rd_alignment; 
  
//----------------
// EXU
//----------------


  typedef enum logic [1:0] {exu_op0_rs1,
                           exu_op0_pc,
                           exu_op0_lsu,
                           exu_op0_csr} t_exu_alu_operand0_sel;

  typedef enum logic [2:0] {exu_op1_rs2,
                           exu_op1_imm,
                           exu_op1_lit4,
                           exu_op1_lit2} t_exu_alu_operand1_sel;
                           
  typedef enum logic [4:0] {exu_alu_op_none,
                           exu_alu_op_add_op0_op1,
                           exu_alu_op_sub_op0_op1,
                           exu_alu_op_xor_op0_op1,
                           exu_alu_op_or_op0_op1,
                           exu_alu_op_and_op0_op1, 
                           exu_alu_op_multiply_signed_op0_signed_op1,
                           exu_alu_op_multiply_high_signed_op0_signed_op1,
                           exu_alu_op_multiply_unsigned_op0_unsigned_op1,
                           exu_alu_op_multiply_high_unsigned_op0_unsigned_op1,
                           exu_alu_op_multiply_signed_op0_unsigned_op1,
                           exu_alu_op_multiply_high_signed_op0_unsigned_op1,
                           exu_alu_op_divide_signed_op0_signed_op1,
                           exu_alu_op_divide_unsigned_op0_unsigned_op1,
                           exu_alu_op_remainder_signed_op0_signed_op1,
                           exu_alu_op_remainder_unsigned_op0_unsigned_op1,       
                           exu_cmp_op_compare_lt_unsigned_op0_unsigned_op1,
                           exu_cmp_op_compare_lt_signed_op0_signed_op1,
                           exu_cmp_op_compare_gte_unsigned_op0_unsigned_op1,
                           exu_cmp_op_compare_gte_signed_op0_signed_op1,
                           exu_cmp_op_compare_equal_signed_op0_signed_op1,
                           exu_cmp_op_compare_equal_unsigned_op0_unsigned_op1,
                           exu_cmp_op_compare_not_equal_signed_op0_signed_op1,
                           exu_cmp_op_compare_not_equal_unsigned_op0_unsigned_op1} t_exu_alu_op_sel;
                                   
  typedef enum logic [1:0] {exu_shifter_op_none,               
                           exu_shifter_op_shift_left,  
                           exu_shifter_op_shift_right,      
                           exu_shifter_op_arithmetic_shift_right} t_exu_shifter_op_sel;
                           
  typedef enum logic [2:0] {shifter_places_operand_none,
                           shifter_places_operand_addr_byte,
                           shifter_places_operand_addr_hword,
                           shifter_places_operand_noshift,
                           shifter_places_operand_rs2,
                           shifter_places_operand_imm} t_exu_shifter_places_sel;
                           
  typedef enum logic [1:0] {shifter_operand_none,
                           shifter_operand_rs1,
                           shifter_operand_rs2}t_exu_shifter_operand_sel; 
                           
  typedef enum logic [2:0] {exu_alu_result_mux_none,
                           exu_alu_result_mux_cmp_lit,
                           exu_alu_result_mux_shifter,
                           exu_alu_result_mux_adder, 
                           exu_alu_result_mux_logical, 
                           exu_alu_result_mux_multiplier,
                           exu_alu_result_mux_divider, 
                           exu_alu_result_mux_acu }t_exu_alu_result_mux_sel;
                           
  typedef enum logic [2:0] {bcu_operand1_imm,
                           bcu_operand1_epc,
                           bcu_operand1_dpc,
                           bcu_operand1_exvec,
                           bcu_operand1_resetvec}t_exu_bcu_operand1_sel;    
                           
  typedef enum logic [1:0] {bcu_operand0_pc,
                           bcu_operand0_rs1,
                           bcu_operand0_trap_cause}t_exu_bcu_operand0_sel;  
                           
  typedef enum logic       {bcu_op_none,
                           bcu_op_add}t_exu_bcu_op_sel;                      
                           
  typedef struct {logic cmp_cond;} t_exu_flags;
  
  typedef enum logic [1:0] {csr_alu_wr_op_none,
                           csr_alu_wr_op_swap,
                           csr_alu_wr_op_set,
                           csr_alu_wr_op_clr} t_csr_alu_wr_op_sel;
                           
  typedef enum logic {csr_alu_rd_op_none,
                     csr_alu_rd_op_rd} t_csr_alu_rd_op_sel;
                     
typedef struct {    
  logic mvendorid_sw_rd_sel;
  logic marchid_sw_rd_sel;
  logic mimpid_sw_rd_sel;
  logic mhartid_sw_rd_sel;
  logic mstatus_sw_rd_sel;
  logic sstatus_sw_rd_sel;
  logic ustatus_sw_rd_sel;
  logic misa_sw_rd_sel;
  logic medeleg_sw_rd_sel;
  logic mideleg_sw_rd_sel;
  logic mie_sw_rd_sel;
  logic sie_sw_rd_sel;
  logic uie_sw_rd_sel;
  logic mip_sw_rd_sel;
  logic sip_sw_rd_sel; 
  logic uip_sw_rd_sel; 
  logic ip_sw_rd_sel; 
  logic mtvec_sw_rd_sel; 
  logic mepc_sw_rd_sel;
  logic mcause_sw_rd_sel;
  logic mtval_sw_rd_sel;
  logic mcounteren_sw_rd_sel;
  logic mcounterinhibit_sw_rd_sel;
  logic mscratch_sw_rd_sel;
  logic pmpcfg_0_3_sw_rd_sel;
  logic pmpaddr_0_15_sw_rd_sel;
  logic sedeleg_sw_rd_sel;
  logic sideleg_sw_rd_sel;
  logic stvec_sw_rd_sel;
  logic sepc_sw_rd_sel;
  logic scause_sw_rd_sel;
  logic stval_sw_rd_sel;
  logic scounteren_sw_rd_sel;
  logic sscratch_sw_rd_sel;
  logic satp_sw_rd_sel;
  logic utvec_sw_rd_sel;
  logic uepc_sw_rd_sel;
  logic ucause_sw_rd_sel;
  logic utval_sw_rd_sel;
  logic uscratch_sw_rd_sel;
  logic ucycle_sw_rd_sel;
  logic mcycle_sw_rd_sel;
  logic ucycleh_sw_rd_sel;
  logic mcycleh_sw_rd_sel;
  logic utime_sw_rd_sel;
  logic utimeh_sw_rd_sel;
  logic uinstret_sw_rd_sel;
  logic minstret_sw_rd_sel;
  logic uinstreth_sw_rd_sel;
  logic minstreth_sw_rd_sel;
  logic hpmcounter_3_31_sw_rd_sel;
  logic hpmcounter_3_31h_sw_rd_sel;
  logic mhpmcounter_3_31_sw_rd_sel;
  logic mhpmcounter_3_31h_sw_rd_sel;
  logic hpmevent_3_31_sw_rd_sel;
  logic tselect_sw_rd_sel;
  logic tdata1_sw_rd_sel;
  logic tdata2_sw_rd_sel;
  logic tdata3_sw_rd_sel;
  logic dcsr_debugger_rd_sel;
  logic dpc_debugger_rd_sel;
  logic dscratch0_debugger_rd_sel;
  logic dscratch1_debugger_rd_sel;
  } t_csr_reg_rd_sel;   
                    
typedef struct {    
  logic mvendorid_sw_wr_sel;
  logic marchid_sw_wr_sel;
  logic mimpid_sw_wr_sel;
  logic mhartid_sw_wr_sel;
  logic mstatus_sw_wr_sel;
  logic sstatus_sw_wr_sel;
  logic ustatus_sw_wr_sel;
  logic misa_sw_wr_sel;
  logic medeleg_sw_wr_sel;
  logic mideleg_sw_wr_sel;
  logic mie_sw_wr_sel;
  logic sie_sw_wr_sel;
  logic uie_sw_wr_sel;
  logic mip_sw_wr_sel;
  logic sip_sw_wr_sel; 
  logic uip_sw_wr_sel; 
  logic ip_sw_wr_sel; 
  logic mtvec_sw_wr_sel; 
  logic mepc_sw_wr_sel;
  logic mcause_sw_wr_sel;
  logic mtval_sw_wr_sel;
  logic mcounteren_sw_wr_sel;
  logic mcounterinhibit_sw_wr_sel;
  logic mscratch_sw_wr_sel;
  logic pmpcfg_0_3_sw_wr_sel;
  logic pmpaddr_0_15_sw_wr_sel;
  logic sedeleg_sw_wr_sel;
  logic sideleg_sw_wr_sel;
  logic stvec_sw_wr_sel;
  logic sepc_sw_wr_sel;
  logic scause_sw_wr_sel;
  logic stval_sw_wr_sel;
  logic scounteren_sw_wr_sel;
  logic sscratch_sw_wr_sel;
  logic satp_sw_wr_sel;
  logic utvec_sw_wr_sel;
  logic uepc_sw_wr_sel;
  logic ucause_sw_wr_sel;
  logic utval_sw_wr_sel;
  logic uscratch_sw_wr_sel;
  logic ucycle_sw_wr_sel;
  logic mcycle_sw_wr_sel;
  logic ucycleh_sw_wr_sel;
  logic mcycleh_sw_wr_sel;
  logic utime_sw_wr_sel;
  logic utimeh_sw_wr_sel;
  logic uinstret_sw_wr_sel;
  logic minstret_sw_wr_sel;
  logic uinstreth_sw_wr_sel;
  logic minstreth_sw_wr_sel;
  logic hpmcounter_3_31_sw_wr_sel;
  logic hpmcounter_3_31h_sw_wr_sel;
  logic mhpmcounter_3_31_sw_wr_sel;
  logic mhpmcounter_3_31h_sw_wr_sel;
  logic hpmevent_3_31_sw_wr_sel;
  logic tselect_sw_wr_sel;
  logic tdata1_sw_wr_sel;
  logic tdata2_sw_wr_sel;
  logic tdata3_sw_wr_sel;
  logic dcsr_debugger_wr_sel;
  logic dpc_debugger_wr_sel;
  logic dscratch0_debugger_wr_sel;
  logic dscratch1_debugger_wr_sel;
  } t_csr_reg_wr_sel;                                  
//----------------
// LSF/IFU/LSU
//----------------
               
  typedef enum logic [3:0] {lsu_op_none,
                           lsu_op_ld_byte_s,
                           lsu_op_ld_hword_s,
                           lsu_op_ld_word,
                           lsu_op_ld_byte_u,
                           lsu_op_ld_hword_u,
                           lsu_op_str_byte,
                           lsu_op_str_word,
                           lsu_op_str_hword,
                           lsu_op_fence} t_lsu_op;                                                       
                            
//----------------
// IDCTRL
//---------------- 

  typedef enum logic       {expipe_stage_state_ready, 
                            expipe_stage_state_busy} t_expipe_stage_state;

  typedef enum logic [1:0] {branch_cond_none,
                            branch_cond_always,
                            branch_cond_compare_true} t_branch_cond;
                            
  typedef enum logic [1:0] {gpr_wr_mux_sel_none,
                            gpr_wr_mux_sel_lsu,
                            gpr_wr_mux_sel_exu,
                            gpr_wr_mux_sel_csr} t_gpr_wr_mux_sel;
                            
                    
  typedef enum logic [2:0] {alignment_word,
                            alignment_halfword_u,
                            alignment_halfword_s,
                            alignment_byte_u,
                            alignment_byte_s} t_alignment_type;

    typedef struct {logic irq_src_ext;
                    logic irq_src_sw;
                    logic irq_src_timer;
                    } t_irq_src;                         
                            
                            
//-----------------------                
// MMU
//-----------------------
                            
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
