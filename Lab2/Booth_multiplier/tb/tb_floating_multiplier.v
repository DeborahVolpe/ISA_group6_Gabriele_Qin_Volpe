//`timescale 1ns

module tb_floating_multiplier ();

   wire CLK_i;
   wire RST_n_i;
   wire [31:0] DATA_i;
   wire [31:0] FP_Z_i;

   clk_gen CG(
			.CLK(CLK_i), // clock signal
			.RST_n(RST_n_i) // reset low active
			);

   data_maker SM(
				.CLK(CLK_i), // clock signal
				.RST_n(RST_n_i), // reset low active
				.DATA(DATA_i)); // input


   FPmul DUT(
			.FP_A(DATA_i), // input A
			.FP_B(DATA_i), // input B
			.clk(CLK_i),  // clock signal
			.FP_Z(FP_Z_i) // product 
			);

   data_sink DS(
				.CLK(CLK_i), // clock signal
				.RST_n(RST_n_i), // reset low active
				.FP_Z(FP_Z_i) // product
				);   

endmodule

		   
