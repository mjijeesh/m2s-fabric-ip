set_device -family {SmartFusion2} -die {M2S025} -speed {STD}
read_adl {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\m2s_creative_ddr_top.adl}
read_afl {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\m2s_creative_ddr_top.afl}
map_netlist
read_sdc {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\constraint\m2s_creative_ddr_top_derived_constraints.sdc}
check_constraints {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\constraint\placer_sdc_errors.log}
write_sdc -mode layout {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\place_route.sdc}
