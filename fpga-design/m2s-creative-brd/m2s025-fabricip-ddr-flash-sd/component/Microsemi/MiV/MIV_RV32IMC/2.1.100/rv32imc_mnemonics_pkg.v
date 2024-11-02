////////////////////////////////////////////////////////////////////////////////
//                              Microsemi Corp.                               //
//                                                                            //
//                               Copyright 2018                               //
//                            All Rights Reserved                             //
//                         CONFIDENTIAL & PROPRIETARY                         //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//   File: 
//
//   Purpose: 
//
//   Author: 
//
//   Version: 1.0
//
////////////////////////////////////////////////////////////////////////////////

`default_nettype none




package MIV_RV32IMC_rv32imc_mnemonic_pkg;
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
