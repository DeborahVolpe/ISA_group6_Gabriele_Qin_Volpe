# compile controller VHDL files
analyze -f vhdl -lib WORK ../src/controller/Branch.vhd
analyze -f vhdl -lib WORK ../src/controller/Data_mem_signal.vhd
analyze -f vhdl -lib WORK ../src/controller/Forward_unit.vhd
analyze -f vhdl -lib WORK ../src/controller/Hazard_control_det.vhd
analyze -f vhdl -lib WORK ../src/controller/Hazard_data_det.vhd
analyze -f vhdl -lib WORK ../src/controller/Hazard_unit.vhd
analyze -f vhdl -lib WORK ../src/controller/ImmediateGenerator.vhd
analyze -f vhdl -lib WORK ../src/controller/PCsrc.vhd
analyze -f vhdl -lib WORK ../src/controller/RF_gen.vhd
analyze -f vhdl -lib WORK ../src/controller/Selector_generator.vhd
analyze -f vhdl -lib WORK ../src/controller/WriteBackMux.vhd
analyze -f vhdl -lib WORK ../src/controller/Controller.vhd