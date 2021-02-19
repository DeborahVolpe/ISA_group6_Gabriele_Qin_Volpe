ungroup -all -flatten 
change_names -hierarchy -rules verilog

# create .sdf, .sdc and netlist of the RISCV
write_sdf ../netlist/synopsys/RISCV.sdf
write -f verilog -hierarchy -output ../netlist/synopsys/RISCV.v
write_sdc ../netlist/synopsys/RISCV.sdc
