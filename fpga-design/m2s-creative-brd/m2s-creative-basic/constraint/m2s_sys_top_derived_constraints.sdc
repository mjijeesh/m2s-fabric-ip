# Microsemi Corp.
# Date: 2024-Oct-25 14:59:15
# This file was generated based on the following SDC source files:
#   C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/component/work/ddr_mss_sb/CCC_0/ddr_mss_sb_CCC_0_FCCC.sdc
#   C:/Microsemi/Libero_SoC_v11.9/Designer/data/aPA4M/cores/constraints/PA4M2500/coreconfigp.sdc
#   C:/Microsemi/Libero_SoC_v11.9/Designer/data/aPA4M/cores/constraints/coreresetp.sdc
#   C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/component/work/ddr_mss_sb_MSS/ddr_mss_sb_MSS.sdc
#   C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/component/work/ddr_mss_sb/FABOSC_0/ddr_mss_sb_FABOSC_0_OSC.sdc
#   C:/Microsemi/Libero_SoC_v11.9/Designer/data/aPA4M/cores/constraints/sysreset.sdc
#

create_clock -name {CLK0_PAD} -period 20 [ get_ports { CLK0_PAD } ]
create_clock -name {m2s_creative_demo_0/ddr_mss_sb_0/ddr_mss_sb_MSS_0/CLK_CONFIG_APB} -period 80 [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/ddr_mss_sb_MSS_0/MSS_ADLIB_INST/CLK_CONFIG_APB } ]
create_clock -ignore_errors -name {m2s_creative_demo_0/ddr_mss_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/GL0} -multiply_by 4 -divide_by 4 -source [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/CCC_INST/CLK0_PAD } ] -phase 0 [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/CCC_INST/GL0 } ]
set_false_path -ignore_errors -through [ get_nets { m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/INIT_DONE m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/SDIF_RELEASED } ]
set_false_path -ignore_errors -through [ get_nets { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/ddr_settled m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/count_ddr_enable m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/release_sdif*_core m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/count_sdif*_enable } ]
set_false_path -ignore_errors -from [ get_cells { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/MSS_HPMS_READY_int } ] -to [ get_cells { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/sm0_areset_n_rcosc m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/sm0_areset_n_rcosc_q1 } ]
set_false_path -ignore_errors -from [ get_cells { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/MSS_HPMS_READY_int m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SDIF*_PERST_N_re } ] -to [ get_cells { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/sdif*_areset_n_rcosc* } ]
set_false_path -ignore_errors -through [ get_nets { m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/CONFIG1_DONE m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/CONFIG2_DONE m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SDIF*_PERST_N m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SDIF*_PSEL m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SDIF*_PWRITE m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SDIF*_PRDATA[*] m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_EXT_RESET_OUT m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_RESET_F2M m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_M3_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_MDDR_DDR_AXI_S_CORE_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_FDDR_CORE_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_SDIF*_PHY_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_SDIF*_CORE_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_SDIF0_0_CORE_RESET m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/SOFT_SDIF0_1_CORE_RESET } ]
set_false_path -ignore_errors -through [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/ddr_mss_sb_MSS_0/MSS_ADLIB_INST/CONFIG_PRESET_N } ]
set_false_path -ignore_errors -through [ get_pins { m2s_creative_demo_0/ddr_mss_sb_0/SYSRESET_POR/POWER_ON_RESET_N } ]
set_max_delay 0 -through [ get_nets { m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PSEL m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PENABLE } ] -to [ get_cells { m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PREADY* m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/state[0] } ]
set_min_delay -24 -through [ get_nets { m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PWRITE m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PADDR[*] m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PWDATA[*] m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PSEL m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/FIC_2_APB_M_PENABLE } ]
