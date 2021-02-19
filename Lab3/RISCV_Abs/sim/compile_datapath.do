# Compile all datapath VHDL files
vcom -93 -work ./work ../src/datapath/component/adder_subtractor.vhd
vcom -93 -work ./work ../src/datapath/component/AndN_bit.vhd
vcom -93 -work ./work ../src/datapath/component/barrel_shifter.vhd
vcom -93 -work ./work ../src/datapath/component/bN_6to1.vhd
vcom -93 -work ./work ../src/datapath/component/abs.vhd
vcom -93 -work ./work ../src/datapath/component/LUI_AUIPC.vhd
vcom -93 -work ./work ../src/datapath/component/XorN_bit.vhd
vcom -93 -work ./work ../src/datapath/component/ZeroN_bit.vhd
vcom -93 -work ./work ../src/datapath/component/datapath.vhd
