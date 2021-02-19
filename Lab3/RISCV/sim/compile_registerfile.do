# Compile all datapath VHDL files
vcom -93 -work ./work ../src/register_file/Decoder.vhd
vcom -93 -work ./work ../src/register_file/mux32to1.vhd
vcom -93 -work ./work ../src/register_file/Register_file.vhd
