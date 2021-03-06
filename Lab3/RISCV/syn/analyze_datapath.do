# Compile all datapath VHDL files
analyze -f vhdl -lib WORK ../src/datapath/component/adder_subtractor.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/AndN_bit.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/barrel_shifter.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/bN_5to1.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/LUI_AUIPC.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/XorN_bit.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/ZeroN_bit.vhd
analyze -f vhdl -lib WORK ../src/datapath/component/datapath.vhd