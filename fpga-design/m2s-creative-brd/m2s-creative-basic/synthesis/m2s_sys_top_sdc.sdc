# Written by Synplify Pro version mapact, Build 2172R. Synopsys Run ID: sid1729848601 
# Top Level Design Parameters 

# Clocks 
create_clock -period 20.000 -waveform {0.000 10.000} -name {CLK0_PAD} [get_ports {CLK0_PAD}] 
create_clock -period 80.000 -waveform {0.000 40.000} -name {m2s_creative_demo_0/ddr_mss_sb_0/ddr_mss_sb_MSS_0/CLK_CONFIG_APB} [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/ddr_mss_sb_MSS_0/MSS_ADLIB_INST:CLK_CONFIG_APB}] 
create_clock -period 20.000 -waveform {0.000 10.000} -name {m2s_creative_demo_0/ddr_mss_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/FABOSC_0/I_RCOSC_25_50MHZ:CLKOUT}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/GL0} -multiply_by {4} -divide_by {4} -source [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/CLK0_PAD_INST:Y}]  [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/CCC_0/CCC_INST:GL0}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 
set_false_path -through [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/INIT_DONE_int_RNIUED4:Y}] 
set_false_path -through [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/soft_reset_reg[1]:Q m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/soft_reset_reg[2]:Q m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/control_reg_1[0]:Q m2s_creative_demo_0/ddr_mss_sb_0/CORECONFIGP_0/control_reg_1[1]:Q}] 
set_false_path -through [get_pins {m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/ddr_settled:Q m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/release_sdif0_core:Q m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/release_sdif0_core:Q m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/release_sdif0_core:Q m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/release_sdif0_core:Q m2s_creative_demo_0/ddr_mss_sb_0/CORERESETP_0/count_ddr_enable:Q}] 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -from [get_cells { m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.MSS_HPMS_READY_int }] -to [get_cells { m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.sm0_areset_n_rcosc m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.sm0_areset_n_rcosc_q1 }]
# set_false_path -from [get_cells { m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.MSS_HPMS_READY_int m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.SDIF*_PERST_N_re }] -to [get_cells { m2s_creative_demo_0.ddr_mss_sb_0.CORERESETP_0.sdif*_areset_n_rcosc* }]
# set_false_path -through [get_pins { m2s_creative_demo_0.ddr_mss_sb_0.ddr_mss_sb_MSS_0.MSS_ADLIB_INST.CONFIG_PRESET_N }]
# set_false_path -through [get_pins { m2s_creative_demo_0.ddr_mss_sb_0.SYSRESET_POR.POWER_ON_RESET_N }]
# set_max_delay 0 -through [get_nets { m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PSEL m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PENABLE }] -to [get_cells { m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PREADY* m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.state[0] }]
# set_min_delay -24 -through [get_nets { m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PWRITE m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PADDR[*] m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PWDATA[*] m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PSEL m2s_creative_demo_0.ddr_mss_sb_0.CORECONFIGP_0.FIC_2_APB_M_PENABLE }]

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

