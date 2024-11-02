set_device \
    -family  SmartFusion2 \
    -die     PA4M2500_N \
    -package vf256 \
    -speed   STD \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def {RTG4_MITIGATION_ON} {0}
set_def USE_CONSTRAINTS_FLOW 1
set_def NETLIST_TYPE EDIF
set_name m2s_creative_ddr_top
set_workdir {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top}
set_log     {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\m2s_creative_ddr_top_sdc.log}
set_design_state pre_layout
