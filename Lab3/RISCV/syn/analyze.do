# to remove eventually previous designs 
remove_design -designs

source analyze_common_component.do
source analyze_controller.do
source analyze_datapath.do
source analyze_registerfile.do

analyze -f vhdl -lib WORK ../src/RISCV.vhd

# the HDL compiler preserves the hierarchy information of the RTL objects in the RTL design
set power_preserve_rtl_hier_names true

# allows the VHDL architecture selection and translates the design into a technology-independent design from the
#intermediate files produced during analysis.
elaborate RISCV -arch structure -lib WORK > ./elaborate.txt

# clock signal is created
create_clock -name clk -period 1.94 clk
set_dont_touch_network clk
set_clock_uncertainty 0.07 [get_clocks clk]
set_input_delay 0.5 -max -clock clk [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock clk [all_outputs]

# input capacitance of the available buffer in the
# used technology is set, as the load of each output
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

report_timing > ./timing_clock_1_9.txt
report_area > ./area_clock_1_9.txt

source generate_netlist.do
