# compile all vhdl filter file
vcom -93 -work ./work ../multiplier_24bit/src/adder.vhd
vcom -93 -work ./work ../multiplier_24bit/src/bN_2to1mux.vhd
vcom -93 -work ./work ../multiplier_24bit/src/bN_3to1mux.vhd
vcom -93 -work ./work ../multiplier_24bit/src/full_adder.vhd
vcom -93 -work ./work ../multiplier_24bit/src/half_adder.vhd
vcom -93 -work ./work ../multiplier_24bit/src/CSA.vhd
vcom -93 -work ./work ../multiplier_24bit/src/partial_product_generator.vhd
vcom -93 -work ./work ../multiplier_24bit/src/significant_multiplier.vhd
vcom -93 -work ./work ../fpuvhdl/common/packfp_packfp.vhd
vcom -93 -work ./work ../fpuvhdl/common/fpround_fpround.vhd
vcom -93 -work ./work ../fpuvhdl/common/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../fpuvhdl/common/unpackfp_unpackfp.vhd
vcom -93 -work ./work ../fpuvhdl/multiplier/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../fpuvhdl/multiplier/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../fpuvhdl/multiplier/fpmul_stage2_struct.vhd
vcom -93 -work ./work ../fpuvhdl/multiplier/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../fpuvhdl/multiplier/fpmul_pipeline.vhd

# compile vhdl testbench file
vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker.vhd
vcom -93 -work ./work ../tb/data_sink.vhd

# compile verilog file for twwstbech
vlog -work ./work ../tb/tb_floating_multiplier.v

# start_simulation
vsim work.tb_floating_multiplier

add wave *

run 180 ns
