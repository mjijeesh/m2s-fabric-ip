set_device \
    -fam SmartFusion2 \
    -die PA4M2500_N \
    -pkg vf256
set_input_cfg \
	-path {C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/component/work/ddr_mss_sb_MSS/ENVM.cfg}
set_output_efc \
    -path {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top.efc}
set_proj_dir \
    -path {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic}
gen_prg -use_init false
