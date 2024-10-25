----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Fri Oct 25 14:44:00 2024
-- Parameters for CoreGPIO
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant APB_WIDTH : integer := 32;
    constant FIXED_CONFIG_0 : integer := 0;
    constant FIXED_CONFIG_1 : integer := 0;
    constant FIXED_CONFIG_2 : integer := 0;
    constant FIXED_CONFIG_3 : integer := 0;
    constant FIXED_CONFIG_4 : integer := 0;
    constant FIXED_CONFIG_5 : integer := 0;
    constant FIXED_CONFIG_6 : integer := 0;
    constant FIXED_CONFIG_7 : integer := 0;
    constant FIXED_CONFIG_8 : integer := 0;
    constant FIXED_CONFIG_9 : integer := 0;
    constant FIXED_CONFIG_10 : integer := 0;
    constant FIXED_CONFIG_11 : integer := 0;
    constant FIXED_CONFIG_12 : integer := 0;
    constant FIXED_CONFIG_13 : integer := 0;
    constant FIXED_CONFIG_14 : integer := 0;
    constant FIXED_CONFIG_15 : integer := 0;
    constant FIXED_CONFIG_16 : integer := 0;
    constant FIXED_CONFIG_17 : integer := 0;
    constant FIXED_CONFIG_18 : integer := 0;
    constant FIXED_CONFIG_19 : integer := 0;
    constant FIXED_CONFIG_20 : integer := 0;
    constant FIXED_CONFIG_21 : integer := 0;
    constant FIXED_CONFIG_22 : integer := 0;
    constant FIXED_CONFIG_23 : integer := 0;
    constant FIXED_CONFIG_24 : integer := 0;
    constant FIXED_CONFIG_25 : integer := 0;
    constant FIXED_CONFIG_26 : integer := 0;
    constant FIXED_CONFIG_27 : integer := 0;
    constant FIXED_CONFIG_28 : integer := 0;
    constant FIXED_CONFIG_29 : integer := 0;
    constant FIXED_CONFIG_30 : integer := 0;
    constant FIXED_CONFIG_31 : integer := 0;
    constant INT_BUS : integer := 0;
    constant IO_INT_TYPE_0 : integer := 7;
    constant IO_INT_TYPE_1 : integer := 7;
    constant IO_INT_TYPE_2 : integer := 7;
    constant IO_INT_TYPE_3 : integer := 7;
    constant IO_INT_TYPE_4 : integer := 7;
    constant IO_INT_TYPE_5 : integer := 7;
    constant IO_INT_TYPE_6 : integer := 7;
    constant IO_INT_TYPE_7 : integer := 7;
    constant IO_INT_TYPE_8 : integer := 0;
    constant IO_INT_TYPE_9 : integer := 0;
    constant IO_INT_TYPE_10 : integer := 7;
    constant IO_INT_TYPE_11 : integer := 7;
    constant IO_INT_TYPE_12 : integer := 7;
    constant IO_INT_TYPE_13 : integer := 7;
    constant IO_INT_TYPE_14 : integer := 7;
    constant IO_INT_TYPE_15 : integer := 7;
    constant IO_INT_TYPE_16 : integer := 7;
    constant IO_INT_TYPE_17 : integer := 7;
    constant IO_INT_TYPE_18 : integer := 7;
    constant IO_INT_TYPE_19 : integer := 7;
    constant IO_INT_TYPE_20 : integer := 7;
    constant IO_INT_TYPE_21 : integer := 7;
    constant IO_INT_TYPE_22 : integer := 7;
    constant IO_INT_TYPE_23 : integer := 7;
    constant IO_INT_TYPE_24 : integer := 7;
    constant IO_INT_TYPE_25 : integer := 7;
    constant IO_INT_TYPE_26 : integer := 7;
    constant IO_INT_TYPE_27 : integer := 7;
    constant IO_INT_TYPE_28 : integer := 7;
    constant IO_INT_TYPE_29 : integer := 7;
    constant IO_INT_TYPE_30 : integer := 7;
    constant IO_INT_TYPE_31 : integer := 7;
    constant IO_NUM : integer := 8;
    constant IO_TYPE_0 : integer := 1;
    constant IO_TYPE_1 : integer := 1;
    constant IO_TYPE_2 : integer := 1;
    constant IO_TYPE_3 : integer := 1;
    constant IO_TYPE_4 : integer := 1;
    constant IO_TYPE_5 : integer := 1;
    constant IO_TYPE_6 : integer := 1;
    constant IO_TYPE_7 : integer := 1;
    constant IO_TYPE_8 : integer := 0;
    constant IO_TYPE_9 : integer := 0;
    constant IO_TYPE_10 : integer := 0;
    constant IO_TYPE_11 : integer := 0;
    constant IO_TYPE_12 : integer := 0;
    constant IO_TYPE_13 : integer := 0;
    constant IO_TYPE_14 : integer := 0;
    constant IO_TYPE_15 : integer := 0;
    constant IO_TYPE_16 : integer := 0;
    constant IO_TYPE_17 : integer := 0;
    constant IO_TYPE_18 : integer := 0;
    constant IO_TYPE_19 : integer := 0;
    constant IO_TYPE_20 : integer := 0;
    constant IO_TYPE_21 : integer := 0;
    constant IO_TYPE_22 : integer := 0;
    constant IO_TYPE_23 : integer := 0;
    constant IO_TYPE_24 : integer := 0;
    constant IO_TYPE_25 : integer := 0;
    constant IO_TYPE_26 : integer := 0;
    constant IO_TYPE_27 : integer := 0;
    constant IO_TYPE_28 : integer := 0;
    constant IO_TYPE_29 : integer := 0;
    constant IO_TYPE_30 : integer := 0;
    constant IO_TYPE_31 : integer := 0;
    constant IO_VAL_0 : integer := 0;
    constant IO_VAL_1 : integer := 0;
    constant IO_VAL_2 : integer := 0;
    constant IO_VAL_3 : integer := 0;
    constant IO_VAL_4 : integer := 0;
    constant IO_VAL_5 : integer := 0;
    constant IO_VAL_6 : integer := 0;
    constant IO_VAL_7 : integer := 0;
    constant IO_VAL_8 : integer := 0;
    constant IO_VAL_9 : integer := 0;
    constant IO_VAL_10 : integer := 0;
    constant IO_VAL_11 : integer := 0;
    constant IO_VAL_12 : integer := 0;
    constant IO_VAL_13 : integer := 0;
    constant IO_VAL_14 : integer := 0;
    constant IO_VAL_15 : integer := 0;
    constant IO_VAL_16 : integer := 0;
    constant IO_VAL_17 : integer := 0;
    constant IO_VAL_18 : integer := 0;
    constant IO_VAL_19 : integer := 0;
    constant IO_VAL_20 : integer := 0;
    constant IO_VAL_21 : integer := 0;
    constant IO_VAL_22 : integer := 0;
    constant IO_VAL_23 : integer := 0;
    constant IO_VAL_24 : integer := 0;
    constant IO_VAL_25 : integer := 0;
    constant IO_VAL_26 : integer := 0;
    constant IO_VAL_27 : integer := 0;
    constant IO_VAL_28 : integer := 0;
    constant IO_VAL_29 : integer := 0;
    constant IO_VAL_30 : integer := 0;
    constant IO_VAL_31 : integer := 0;
    constant OE_TYPE : integer := 1;
    constant testbench : string( 1 to 4 ) := "User";
end coreparameters;
