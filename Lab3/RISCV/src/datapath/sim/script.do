# compile all vhdl filter file
vcom -93 -work ./work ../../common_component/bN_2to1mux.vhd
vcom -93 -work ./work ../component/bN_5to1.vhd
vcom -93 -work ./work ../component/adder_subtractor.vhd
vcom -93 -work ./work ../component/AndN_bit.vhd
vcom -93 -work ./work ../component/barrel_shifter.vhd
vcom -93 -work ./work ../component/LUI_AUIPC.vhd
vcom -93 -work ./work ../component/XorN_bit.vhd
vcom -93 -work ./work ../component/ZeroN_bit.vhd
vcom -93 -work ./work ../component/datapath.vhd

# compile vhdl testbench file
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker.vhd
vcom -93 -work ./work ../tb/data_sink.vhd

# compile verilog file for twwstbech
vlog -work ./work ../tb/tb_datapath.v

# start_simulation
vsim work.tb_datapath

add wave *

run 180 ns
