# compile common vhdl filter file
vcom -93 -work ./work ../src/common_component/adder.vhd
vcom -93 -work ./work ../src/common_component/bN_2to1mux.vhd
vcom -93 -work ./work ../src/common_component/bN_3to1mux.vhd
vcom -93 -work ./work ../src/common_component/bN_4to1mux.vhd
vcom -93 -work ./work ../src/common_component/flipflop.vhd
vcom -93 -work ./work ../src/common_component/flip_flop_N_level.vhd
vcom -93 -work ./work ../src/common_component/reg.vhd
vcom -93 -work ./work ../src/common_component/reg_N_level.vhd
vcom -93 -work ./work ../src/common_component/reg_start_value.vhd