# compile all vhdl filter file
vcom -93 -work ./work ../src/adder.vhd
vcom -93 -work ./work ../src/bN_2to1mux.vhd
vcom -93 -work ./work ../src/bN_3to1mux.vhd
vcom -93 -work ./work ../src/full_adder.vhd
vcom -93 -work ./work ../src/half_adder.vhd
vcom -93 -work ./work ../src/CSA.vhd
vcom -93 -work ./work ../src/partial_product_generator.vhd
vcom -93 -work ./work ../src/significant_multiplier.vhd

# compile vhdl testbench file
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vcom -93 -work ./work ../tb/multiplier_test.vhd

# compile verilog file for twwstbech
vlog -work ./work ../tb/tb_multiplier.v

# start_simulation
vsim work.tb_multiplier

add wave *

run 180 ns
