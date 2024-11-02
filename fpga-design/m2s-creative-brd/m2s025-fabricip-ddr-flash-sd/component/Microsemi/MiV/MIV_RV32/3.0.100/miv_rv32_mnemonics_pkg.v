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

`default_nettype none




package miv_rv32_mnemonic_pkg;
//****************************************************************************


typedef enum {
            rv32_default,
            rv32_noexec,
            rv32_trap,
            rv32_reset,
            rv32_dbgexit,
            rv32i_lui,
            rv32i_auipc,
            rv32i_jal,
            rv32i_jalr,
            rv32i_beq,
            rv32i_bne,
            rv32i_blt,
            rv32i_bge,
            rv32i_bltu,
            rv32i_bgeu,
            rv32i_lb,
            rv32i_lh,
            rv32i_lw,
            rv32i_lbu,
            rv32i_lhu,
            rv32i_sb,
            rv32i_sh,
            rv32i_sw,
            rv32i_addi,
            rv32i_slti,
            rv32i_sltiu,
            rv32i_xori,
            rv32i_ori,
            rv32i_andi,
            rv32i_slli,
            rv32i_srli,
            rv32i_srai,
            rv32i_add,
            rv32i_sub,
            rv32i_sll,
            rv32i_slt,
            rv32i_sltu,
            rv32i_xor,
            rv32i_srl,
            rv32i_sra,
            rv32i_or,
            rv32i_and,
            rv32i_fence,
            rv32i_fence_i,
            rv32m_mul,
            rv32m_mulh,
            rv32m_mulhsu,
            rv32m_mulhu,
            rv32m_div,
            rv32m_divu,
            rv32m_rem,
            rv32m_remu,
            rv32c_illegal0,
            rv32c_addi4spn,
            rv32c_lw,
            rv32c_sw,
            rv32c_addi,
            rv32c_addi_hint,
            rv32c_nop,
            rv32c_nop_hint,
            rv32c_jal,
            rv32c_li,
            rv32c_li_hint,
            rv32c_addi16sp,
            rv32c_lui,
            rv32c_lui_hint,
            rv32c_srli,
            rv32c_srli64_hint,
            rv32c_srai,
            rv32c_srai64_hint,
            rv32c_andi,
            rv32c_sub,
            rv32c_xor,
            rv32c_or,
            rv32c_and,
            rv32c_j,
            rv32c_beqz,
            rv32c_bnez,
            rv32c_slli,
            rv32c_slli_hint,
            rv32c_slli64_hint,
            rv32c_lwsp,
            rv32c_jr,
            rv32c_mv,
            rv32c_mv_hint,
            rv32c_ebreak,
            rv32c_jalr,
            rv32c_add,
            rv32c_add_hint,
            rv32c_swsp,
            rv32i_csrrw,
            rv32i_csrrs,
            rv32i_csrrc,
            rv32i_csrrwi,
            rv32i_csrrsi,
            rv32i_csrrci,
            rv32i_ecall,
            rv32i_ebreak,
            rv32i_dret,
            rv32i_mret,
            rv32i_sret,
            rv32i_uret,
            rv32i_wfi
            } t_mnemonic_list;


endpackage


//****************************************************************************


  


`default_nettype wire
