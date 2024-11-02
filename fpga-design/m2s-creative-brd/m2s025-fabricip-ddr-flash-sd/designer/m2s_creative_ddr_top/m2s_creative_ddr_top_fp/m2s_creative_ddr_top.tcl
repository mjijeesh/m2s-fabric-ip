open_project -project {C:\Git\arch\cortex-m3\fpga-design\m2s-creative-brd\m2s025-fabricip-ddr--flash-sd\designer\m2s_creative_ddr_top\m2s_creative_ddr_top_fp\m2s_creative_ddr_top.pro}
enable_device -name {M2S025} -enable 1
set_programming_file -name {M2S025} -file {C:\Git\arch\cortex-m3\fpga-design\m2s-creative-brd\m2s025-fabricip-ddr--flash-sd\designer\m2s_creative_ddr_top\m2s_creative_ddr_top.ppd}
set_programming_action -action {PROGRAM} -name {M2S025} 
run_selected_actions
save_project
close_project
