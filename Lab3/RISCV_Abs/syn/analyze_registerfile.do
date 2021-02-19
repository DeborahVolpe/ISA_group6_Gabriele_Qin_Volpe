# Compile all datapath VHDL files
analyze -f vhdl -lib WORK ../src/register_file/Decoder.vhd
analyze -f vhdl -lib WORK ../src/register_file/mux32to1.vhd
analyze -f vhdl -lib WORK ../src/register_file/Register_file.vhd
