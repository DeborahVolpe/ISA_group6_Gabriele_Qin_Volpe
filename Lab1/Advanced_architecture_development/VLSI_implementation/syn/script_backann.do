# Script used for the backannotation

# read Verilog netlist to restore the design
read_verilog -netlist ../netlist/Filter.v

# read saif file to obtain switching activity information
read_saif -input ../saif/filter_syn.saif -instance tb_filter/UUT -unit ns -scale 1

# clock creation
create_clock -name CLK CLK

report_power > ./report_power.txt