# analyze all vhdl filter file
analyze -f vhdl -lib WORK ../fpuvhdl/common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/common/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/multiplier/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/multiplier/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../fpuvhdl/multiplier/fpmul_pipeline.vhd
