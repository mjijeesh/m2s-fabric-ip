set_family {SmartFusion2}
read_adl {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top.adl}
map_netlist
read_sdc {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\constraint\m2s_sys_top_derived_constraints.sdc}
check_constraints {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\constraint\placer_sdc_errors.log}
write_sdc -strict {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\place_route.sdc}
