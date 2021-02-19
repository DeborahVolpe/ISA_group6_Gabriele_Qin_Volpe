//`timescale 1ns

module tb_datapath ();

   wire 			CLK_i;
   wire 			RST_n_i;
   wire 	[31:0]	in1_i;
   wire		[31:0]	in2_i;
   wire		[31:0]	PC_i;
   wire		[19:0]	immediate_i;
   wire		[2:0]	sel_i;
   wire 	[4:0]	shamt_i;
   wire 			opcode2_i;
   wire				opcode5_i;
   wire				sub_add_n_i;
   wire 			END_SIM_i;
   wire		[31:0]	outputs_i;
   wire 			zero_i;

   clk_gen CG(
			.END_SIM(END_SIM_i),
			.CLK(CLK_i),
			.RST_n(RST_n_i)
			);

   data_maker SM(
				.CLK(CLK_i),
				.RST_n(RST_n_i),
				.in1(in1_i),
				.in2(in2_i),
				.PC(PC_i),
				.immediate(immediate_i),
				.sel(sel_i),
				.shamt(shamt_i),
				.opcode2(opcode2_i),
				.opcode5(opcode5_i),
				.sub_add_n(sub_add_n_i),
				.END_SIM(END_SIM_i));

   datapath DUT(
				.in1(in1_i),
				.in2(in2_i),
				.PC(PC_i),
				.immediate(immediate_i),
				.sel(sel_i),
				.shamt(shamt_i),
				.opcode2(opcode2_i),
				.opcode5(opcode5_i),
				.sub_add_n(sub_add_n_i),
				.outputs(outputs_i),
				.zero(zero_i)
				);

   data_sink DS(
				.CLK(CLK_i),
				.RST_n(RST_n_i),
				.outputs(outputs_i),
				.zero(zero_i)
				);   

endmodule

		   
