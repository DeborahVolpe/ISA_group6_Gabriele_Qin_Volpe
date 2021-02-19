# compile verilog netlist
vlog -work ./work ../netlist/synopsys/RISCV.v

# compile testbench component
vcom -93 -work ./work ../src/common_component/reg_start_value.vhd
vcom -93 -work ./work ../tb/tb_component/clk_gen.vhd
vcom -93 -work ./work ../tb/tb_component/Data_memory.vhd
vcom -93 -work ./work ../tb/tb_component/Instruction_memory.vhd


# compile verilog file for testbech
vlog -work ./work ../tb/tb_component/tb_RISC.v

#lanch simulation 
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_RISCV/DUT=../netlist/synopsys/RISCV.sdf work.tb_RISCV -t ns

#to write vcd
vcd file ../vcd/RISCV.vcd
vcd add /tb_RISCV/DUT/*

add wave sim:/tb_RISCV/IM/*
add wave sim:/tb_RISCV/DM/*

run 300 ns
