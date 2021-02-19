# Script used for the backannotation

# read Verilog netlist to restore the design
read_verilog -netlist ../netlist/synopsys/RISCV.v

# read saif file to obtain switching activity information
read_saif -input ../saif/RISCV.saif -instance tb_RISCV/DUT -unit ns -scale 1

# clock creation
create_clock -name clk clk

report_power > ./report_power_1_96.txt

