set_component ddr_mss_sb_MSS
# Microsemi Corp.
# Date: 2024-Oct-25 14:32:51
#

create_clock -period 80 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
set_false_path -ignore_errors -through [ get_pins { MSS_ADLIB_INST/CONFIG_PRESET_N } ]
