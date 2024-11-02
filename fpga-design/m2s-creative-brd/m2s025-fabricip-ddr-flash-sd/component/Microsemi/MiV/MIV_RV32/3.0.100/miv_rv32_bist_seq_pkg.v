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
// FUNCTION:
//
// This package should be included in all modules which use the PMC RAM BIST 
// blocks.  The package includes user definable parameters such as the number
// of RAMs, the maximum size of a RAM, test bus, and BIST bus sizes, etc.
//
// A copy of this package should be kept in your design, with the indicated
// parameters modified as required.  
//
// The BIST sequencer talks to all the BIST wrappers using a control bus and
// listens to all the RAM results using an acknowledgement bus.
//
//     input  logic [bistctl_width-1:0] bistctl;
//
// Also, the BIST blocks for a given RAM communicate to each other using another
// bus.  The address and control wrapper (bistone, bisttwo, etc.) communicate
// to the data analyzer (bistonedata, bisttwodata, etc.) using the bus:
//
//     logic [bistwrap_width-1:0] bistwrap;
//
// The above should be used to declare the bus that connects them.  Each 
// address and control wrapper has its own bistwrap bus, so do not try and
// mix them.
//
//
// PARAMETER DESCRIPTION:
//
// BIST_NUM                number of RAMs being tested by the BIST sequencer
// BIST_ADDR_WIDTH         max number of address bits of all the RAMs tested
// BIST_DATA_WIDTH         max number of data bits of all the RAMs tested
// BIST_CMASK_WIDTH        width of the compare mask
// BIST_TEST_WIDTH         width of the test bus connected to the BIST sequencer
// ECC_ERR_INJECT_WIDTH    width of ECC error injection bus in BIST wrapper
// ECC_ERR_WIDTH           width of ECC error bus in the BIST wrapper
// PARITY_ERR_INJECT_WIDth width of parity error injection bus in BIST wrapper
// PARITY_ERR_WIDTH        width of parity error bus in BIST wrapper
// BIST_ECC_NUM            number of RAMs which have ECC
// BIST_NO_ECC_NUM         number of RAMs which don't have ECC
//
// BIST_PE_WIDTH           width of PE bus
// BIST_PE_NORMAL          PE bus for normal mode
// BIST_PE_BIST            PE bus for BIST mode
//
// BISTMODE_WIDTH          width of BIST mode bus
// BISTMODE_RESET          BIST reset mode
// BISTMODE_BIST           automated RAM BIST test mode
// BISTMODE_SHIFT          shifts data on BIST test bus to BIST wrapper
// BISTMODE_RUN            executes test shifted in with bistmode_shift
// BISTMODE_HOLD           pause during shifting, ignored in normal operation
// BISTMODE_REGCHECK       sets BIST reg outputs to inverse of bistmode_reset
// BISTMODE_ERR_INJECT     automated RAM BIST test mode with error injection
// BISTMODE_LOW_POWER      runs low power mode test on low power enabled RAM
//
// BISTACK_WIDTH           width of BIST acknowledge bus
// BISTACKECC_WIDTH        width of BIST ECC acknowledge bus 
// BIST_ERR_INJECT_WIDTH   width of BIST error injection bus
// BISTRMCTRL_WIDTH        width of RM control bus
// BIST_ERR_LIMIT          BIST error limit (0.13um=7, 90nm=9)
// BIST_ERR_BIT            BIST error bit (0.13um=3, 90nm=4)
//
// BISTCTL_SYNC_CE         BIST control cell enable
// BISTCTL_SYNC_WE         BIST control write enable
// BISTCTL_DUAL_RCE        BIST control read-side cell enable
// BISTCTL_DUAL_RWE        BIST control read-side write enable
// BISTCTL_DUAL_WCE        BIST control write-side cell enable
// BISTCTL_DUAL_WWE        BIST control write-side write enable
// BISTCTL_ADDR0           BIST control address bus 0
// BISTCTL_ADDR1           BIST control address bus 1
// BISTCTL_TEST0           BIST control data bus 0
// BISTCTL_TEST1           BIST control data bus 1
// BISTCTL_CMASK_EN        BIST control compare mask enable
// BISTCTL_CMASK           BIST control compare mask bus
// BISTCTL_PE              BIST control PE bus
// BISTCTL_LP1_BIST        BIST control light sleep mode
// BISTCTL_LP2_BIST        BIST control deep sleep mode
// BISTCTL_LP3_BIST        BIST control shutdown mode
// BISTCTL_SIDE            BIST control side select
// BISTCTL_BIST            BIST control bist mode enable
// BISTCTL_RESET           BIST control bist mode reset (1 bit)
// BISTCTL_WIDTH           BIST control width
//
// BISTWRAP_WORD           BIST wrapper word
// BISTWRAP_WIDTH          BIST wrapper width
//
// RM_SEL_NORMAL           BIST RM normal mode
// RM_SEL_BIST             BIST RM BIST mode
// RM_SEL_BACKDOOR         BIST RM backdoor mode
//
// BIST_LOW                BIST low 
// BIST_HIGH               BIST high
// BIST_FALSE              BIST false
// BIST_TRUE               BIST true
// BIST_ECC_OFF            BIST ECC off
// BIST_ECC_ON             BIST ECC on
// BIST_PIPELINE_OFF       BIST pipeline off
// BIST_PIPELINE_ON        BIST pipeline on
// BIST_BYPASS_FF_OFF      BIST bypass flip flop off
// BIST_BYPASS_FF_ON       BIST bypass flip flop on
// BIST_BYPASS_FLL_OFF     BIST bypass FLL off
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none

package miv_rv32_bist_seq_pkg;

  import miv_rv32_bist_shared_pkg::*;

  parameter BIST_NUM                = 73;
  parameter BIST_ADDR_WIDTH         = 13;
  parameter BIST_DATA_WIDTH         = 104;
  parameter BIST_CMASK_WIDTH        = 7;
  parameter BIST_ECC_NUM            = 73;
  parameter BIST_NO_ECC_NUM         = 0;
  parameter BIST_ROM_NUM            = 0;
  parameter BISTACK_WIDTH           = 1;
  parameter BISTACKECC_WIDTH        = 73;
  parameter BISTACKROM_WIDTH        = 1;
  
  parameter BISTCTL_ERR_INJECT      = 0;
  parameter BISTCTL_SYNC_CE         = BIST_ERR_INJECT_WIDTH;
  parameter BISTCTL_SYNC_WE         = BISTCTL_SYNC_CE + 1;
  parameter BISTCTL_DUAL_RCE        = BISTCTL_SYNC_WE + 1;
  parameter BISTCTL_DUAL_RWE        = BISTCTL_DUAL_RCE + 1;
  parameter BISTCTL_DUAL_WCE        = BISTCTL_DUAL_RWE + 1;
  parameter BISTCTL_DUAL_WWE        = BISTCTL_DUAL_WCE + 1;
  parameter BISTCTL_ADDR0           = BISTCTL_DUAL_WWE + 1;
  parameter BISTCTL_ADDR1           = BISTCTL_ADDR0 + BIST_ADDR_WIDTH;
  parameter BISTCTL_TEST0           = BISTCTL_ADDR1 + BIST_ADDR_WIDTH;
  parameter BISTCTL_TEST1           = BISTCTL_TEST0 + BIST_SEED_WIDTH;
  parameter BISTCTL_CMASK_EN        = BISTCTL_TEST1 + BIST_SEED_WIDTH;
  parameter BISTCTL_CMASK           = BISTCTL_CMASK_EN + 1;
  parameter BISTCTL_PE              = BISTCTL_CMASK + BIST_CMASK_WIDTH;
  parameter BISTCTL_LP1_BIST        = BISTCTL_PE + BIST_PE_WIDTH;
  parameter BISTCTL_LP2_BIST        = BISTCTL_LP1_BIST + 1;
  parameter BISTCTL_LP3_BIST        = BISTCTL_LP2_BIST + 1;
  parameter BISTCTL_SIDE            = BISTCTL_LP3_BIST + 1;
  parameter BISTCTL_RESET           = BISTCTL_SIDE + 1;
  parameter BISTCTL_BIST            = BISTCTL_RESET + 1;
  parameter BISTCTL_WIDTH           = BISTCTL_BIST + 1;
  
endpackage : miv_rv32_bist_seq_pkg

// Reset default nettype for 3rd Party IP
`default_nettype wire
