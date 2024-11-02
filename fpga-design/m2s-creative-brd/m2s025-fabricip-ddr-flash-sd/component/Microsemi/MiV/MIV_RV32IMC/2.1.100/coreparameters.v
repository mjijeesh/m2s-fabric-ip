//--------------------------------------------------------------------
// Created by Microsemi SmartDesign Thu Nov 24 16:42:07 2022
// Parameters for MIV_RV32IMC
//--------------------------------------------------------------------


parameter AHB_END_ADDR_0 = 'hffff;
parameter AHB_END_ADDR_1 = 'h8fff;
parameter AHB_MASTER_TYPE = 0;
parameter AHB_SLAVE_MIRROR = 0;
parameter AHB_START_ADDR_0 = 'h0;
parameter AHB_START_ADDR_1 = 'h8000;
parameter APB_END_ADDR_0 = 'hffff;
parameter APB_END_ADDR_1 = 'h7fff;
parameter APB_MASTER_TYPE = 1;
parameter APB_SLAVE_MIRROR = 0;
parameter APB_START_ADDR_0 = 'h0;
parameter APB_START_ADDR_1 = 'h7000;
parameter AXI_END_ADDR_0 = 'hffff;
parameter AXI_END_ADDR_1 = 'h6fff;
parameter AXI_MASTER_TYPE = 0;
parameter AXI_SLAVE_MIRROR = 0;
parameter AXI_START_ADDR_0 = 'h0;
parameter AXI_START_ADDR_1 = 'h6000;
parameter DAP_END_ADDR_0 = 'h4000;
parameter DAP_END_ADDR_1 = 'h4000;
parameter DAP_START_ADDR_0 = 'h0;
parameter DAP_START_ADDR_1 = 'h4000;
parameter DEBUGGER = 1;
parameter ECC_ENABLE = 0;
parameter FAMILY = 19;
parameter FWD_REGS = 0;
parameter GEN_DECODE_RV32 = 3;
parameter GEN_MUL_TYPE = 0;
parameter GPR_REGS = 0;
parameter INTERNAL_MTIME = 1;
parameter INTERNAL_MTIME_IRQ = 1;
parameter MTIME_PRESCALER = 100;
parameter MTVEC_OFFSET = 'h34;
parameter NUM_EXT_IRQS = 0;
parameter RESET_VECTOR_ADDR_0 = 'h0;
parameter RESET_VECTOR_ADDR_1 = 'h8000;
parameter TCM_DAP_PRESENT = 0;
parameter TCM_END_ADDR_0 = 'h4000;
parameter TCM_END_ADDR_1 = 'h4000;
parameter TCM_PRESENT = 1;
parameter TCM_START_ADDR_0 = 'h0;
parameter TCM_START_ADDR_1 = 'h4000;
parameter VECTORED_INTERRUPTS = 0;
