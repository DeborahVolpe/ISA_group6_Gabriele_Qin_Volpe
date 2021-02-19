source compile_common_component.do
source compile_controller.do
source compile_datapath.do
source compile_registerfile.do

vcom -93 -work ./work ../src/RISCV.vhd


# compile testbench component

vcom -93 -work ./work ../tb/tb_component/clk_gen.vhd
vcom -93 -work ./work ../tb/tb_component/Data_memory.vhd
vcom -93 -work ./work ../tb/tb_component/Instruction_memory.vhd
vcom -93 -work ./work ../tb/tb_component/data_sink.vhd


# compile verilog file for testbech
vlog -work ./work ../tb/tb_component/tb_RISC_file.v

# start_simulation
vsim work.tb_RISCV_file

add wave *
add wave sim:/tb_RISCV_file/DUT/*
add wave sim:/tb_RISCV_file/DUT/registerfile_instance/*
add wave sim:/tb_RISCV_file/IM/*
add wave sim:/tb_RISCV_file/DM/*

run 300 ns
