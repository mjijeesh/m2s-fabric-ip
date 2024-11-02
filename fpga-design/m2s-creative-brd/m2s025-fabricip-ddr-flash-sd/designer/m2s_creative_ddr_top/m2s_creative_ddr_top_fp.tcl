new_project \
         -name {m2s_creative_ddr_top} \
         -location {C:\Git\cortex-m3-fabric-ip\fpga-designs\m3_m2s025_fabricip_ddr_flash_sdcard_v20221p1\designer\m2s_creative_ddr_top\m2s_creative_ddr_top_fp} \
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
