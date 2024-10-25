new_project \
         -name {m2s_sys_top} \
         -location {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S025} \
         -name {M2S025}
enable_device \
         -name {M2S025} \
         -enable {TRUE}
save_project
close_project
