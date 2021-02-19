In this folder are present all the VHDL files necessary for the Controller, Hazard_unit, Forward_unit and ImmediateGenerator implementation:

- Branch.vhd that generates the signal cond and uncond;

- Controller.vhd that implements the control unit;

- Data_mem_signal.vhd that generates signal for memory control;

- Forward_unit.vhd that generates control signal for datapath's multiplexers;

- Hazard_control_det.vhd that manages control hazards;

- Hazard_data_det.vhd that manages data hazards;

- Hazard_unit.vhd that includes Hazard_control_det.vhd and Hazard_data_det.vhd;

- ImmediateGenerator.vhd that from instruction extracts immediate fields;

- PCsrc.vhd that generates control for Program counter multiplexer;

- RF_gen.vhd that generates control signal for register file;

- Selector_generator.vhd that generates selector for multiplexer inside datapath;

- WriteBackMux.vhd that generates selector of the write back multiplexer.