# compile VHDL file for testbench
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd

# compile verilog netlist
vlog -work ./work ../netlist/Filter.v

#compile verilog testbench
vlog -work ./work ../tb/tb_filter.v

#lanch simulation 
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_filter/UUT=../netlist/Filter.sdf work.tb_filter

#to write vcd
vcd file ../vcd/filter_syn.vcd
vcd add /tb_filter/UUT/*

run 3 us
