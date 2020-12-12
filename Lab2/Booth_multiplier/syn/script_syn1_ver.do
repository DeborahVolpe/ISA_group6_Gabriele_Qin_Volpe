remove_design -designs

source analyze.do

# set variable power_preserve_rtl_hier_names at true. In this way HDL compiler
# preserve the information of the RTL objects in the RTL design
set power_preserve_rtl_hier_names true

# elaborate filter architecture and it put the output in a file
elaborate FPmul -arch pipeline -lib WORK > ./elaborate.txt

create_clock -name clk -period 2.74 clk
set_dont_touch_network clk
set_clock_uncertainty 0.07 [get_clocks clk]
set_input_delay 0.5 -max -clock clk [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock clk [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

ungroup -all -flatten

compile

report_timing > ./timing1_max.txt
report_area > ./area1_max.txt
