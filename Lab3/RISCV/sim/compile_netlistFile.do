# compile verilog netlist
vlog -work ./work ../netlist/synopsys/RISCV.v

# compile testbench component
vcom -93 -work ./work ../src/common_component/reg_start_value.vhd
vcom -93 -work ./work ../tb/tb_component/clk_gen.vhd
vcom -93 -work ./work ../tb/tb_component/Data_memory.vhd
vcom -93 -work ./work ../tb/tb_component/Instruction_memory.vhd
vcom -93 -work ./work ../tb/tb_component/data_sink.vhd


# compile verilog file for testbech
vlog -work ./work ../tb/tb_component/tb_RISC_file.v

#lanch simulation 
vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_RISCV_file -t ns

add wave *
add wave sim:/tb_RISCV_file/IM/*
add wave sim:/tb_RISCV_file/DM/*

run 300 ns
