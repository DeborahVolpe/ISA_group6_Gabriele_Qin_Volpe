# compile common vhdl filter file
analyze -f vhdl -lib WORK ../src/common_component/adder.vhd
analyze -f vhdl -lib WORK ../src/common_component/bN_2to1mux.vhd
analyze -f vhdl -lib WORK ../src/common_component/bN_3to1mux.vhd
analyze -f vhdl -lib WORK ../src/common_component/bN_4to1mux.vhd
analyze -f vhdl -lib WORK ../src/common_component/flipflop.vhd
analyze -f vhdl -lib WORK ../src/common_component/flip_flop_N_level.vhd
analyze -f vhdl -lib WORK ../src/common_component/reg.vhd
analyze -f vhdl -lib WORK ../src/common_component/reg_N_level.vhd
analyze -f vhdl -lib WORK ../src/common_component/reg_start_value.vhd