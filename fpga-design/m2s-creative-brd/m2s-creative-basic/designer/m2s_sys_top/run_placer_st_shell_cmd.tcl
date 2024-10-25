read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/designer/m2s_sys_top/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top_layout_combinational_loops.xml}
report -type slack {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\pinslacks.txt}
