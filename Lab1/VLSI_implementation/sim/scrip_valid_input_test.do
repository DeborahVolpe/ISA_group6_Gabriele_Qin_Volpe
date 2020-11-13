# compile all vhdl filter file
vcom -93 -work ./work ../src/flipflop.vhd
vcom -93 -work ./work ../src/flip_flop_N_level.vhd
vcom -93 -work ./work ../src/reg.vhd
vcom -93 -work ./work ../src/adder.vhd
vcom -93 -work ./work ../src/multiplier_n.vhd
vcom -93 -work ./work ../src/subtractor.vhd
vcom -93 -work ./work ../src/Filter.vhd

# compile vhdl testbench file
vcom -93 -work ./work ../tb_valid_input_test/clk_gen.vhd
vcom -93 -work ./work ../tb_valid_input_test/data_maker_new.vhd
vcom -93 -work ./work ../tb_valid_input_test/data_sink.vhd

# compile verilog file for twwstbech
vlog -work ./work ../tb_valid_input_test/tb_filter.v

# start_simulation
vsim work.tb_filter

add wave *

run 4000 ns
