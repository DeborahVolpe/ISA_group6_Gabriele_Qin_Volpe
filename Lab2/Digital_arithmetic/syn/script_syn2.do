remove_design -designs

source analyze.do

# set variable power_preserve_rtl_hier_names at true. In this way HDL compiler
# preserve the information of the RTL objects in the RTL design
set power_preserve_rtl_hier_names true

# elaborate filter architecture and it put the output in a file
elaborate FPmul -arch pipeline -lib WORK > ./elaborate.txt

# clock signal is created
create_clock -name clk -period 0 clk
set_dont_touch_network clk
set_clock_uncertainty 0.07 [get_clocks clk]
set_input_delay 0.5 -max -clock clk [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock clk [all_outputs]

# input capacitance of the available buffer in the
# used technology is set, as the load of each output
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

ungroup -all -flatten
set_implementation DW02_mult/csa [find cell *mult*]

compile

report_timing > ./timing2.txt
report_area > ./area2.txt
