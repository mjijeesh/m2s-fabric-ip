open_project -project {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top_fp\m2s_sys_top.pro}
set_programming_file -name {M2S025} -file {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top.ipd}
enable_device -name {M2S025} -enable 1
set_programming_action -action {PROGRAM} -name {M2S025} 
run_selected_actions
set_programming_file -name {M2S025} -no_file
save_project
close_project
