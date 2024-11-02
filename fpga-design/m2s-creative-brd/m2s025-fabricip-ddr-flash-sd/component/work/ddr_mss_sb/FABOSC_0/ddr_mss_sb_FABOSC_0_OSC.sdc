set_component ddr_mss_sb_FABOSC_0_OSC
# Microsemi Corp.
# Date: 2023-May-23 14:03:51
#

create_clock -ignore_errors -period 20 [ get_pins { I_RCOSC_25_50MHZ/CLKOUT } ]
create_clock -ignore_errors -period 30517.6 [ get_pins { I_XTLOSC/CLKOUT } ]
