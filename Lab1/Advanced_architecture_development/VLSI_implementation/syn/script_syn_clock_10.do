# to remove eventually previous designs
remove_design -designs

# analyze all vhdl filter file
analyze -f vhdl -lib WORK ../src/flipflop.vhd
analyze -f vhdl -lib WORK ../src/flip_flop_N_level.vhd
analyze -f vhdl -lib WORK ../src/reg.vhd
analyze -f vhdl -lib WORK ../src/adder.vhd
analyze -f vhdl -lib WORK ../src/multiplier_n.vhd
analyze -f vhdl -lib WORK ../src/subtractor.vhd
analyze -f vhdl -lib WORK ../src/Filter.vhd

# set variable power_preserve_rtl_hier_names at true. In this way HDL compiler
# preserve the information of the RTL objects in the RTL design
set power_preserve_rtl_hier_names true

# elaborate filter architecture and it put the output in a file
elaborate Filter -arch structure -lib WORK > ./elaborate.txt

create_clock -name CLK -period 10.0 CLK
set_dont_touch_network CLK
set_clock_uncertainty 0.07 [get_clocks CLK]
set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock CLK [all_outputs]

# input capacitance of the available buffer in the
# used technology is set, as the load of each output
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

report_timing > ./timing.txt
report_area > ./area.txt




