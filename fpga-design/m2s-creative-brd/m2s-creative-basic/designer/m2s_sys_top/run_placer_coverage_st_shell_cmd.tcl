read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/jijeesh/workspace.m2s/m2s-fabric-ip/fpga-design/m2s-creative-brd/m2s-creative-basic/designer/m2s_sys_top/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\m2s_sys_top_place_and_route_constraint_coverage.xml}]
set reportfile {C:\jijeesh\workspace.m2s\m2s-fabric-ip\fpga-design\m2s-creative-brd\m2s-creative-basic\designer\m2s_sys_top\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
