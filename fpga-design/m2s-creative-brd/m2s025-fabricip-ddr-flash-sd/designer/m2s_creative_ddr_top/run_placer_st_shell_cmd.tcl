read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {C:/Git/arch/cortex-m3/fpga-design/m3_m2s025_fabricip_ddr_flash_sdcard/designer/m2s_creative_ddr_top/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\m2s_creative_ddr_top_layout_combinational_loops.xml}
report -type slack {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\m2s_creative_ddr_top_place_and_route_constraint_coverage.xml}]
set reportfile {C:\Git\arch\cortex-m3\fpga-design\m3_m2s025_fabricip_ddr_flash_sdcard\designer\m2s_creative_ddr_top\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp