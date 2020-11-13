//`timescale 1ns

module tb_filter ();

   wire CLK_i;
   wire RST_n_i;
   wire [10:0] DIN_i;
   wire VIN_i;
   wire [10:0] a1_i;
   wire [10:0] b1_i;
   wire [10:0] b0_i;
   wire [10:0] DOUT_i;
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(
			.END_SIM(END_SIM_i),
			.CLK(CLK_i),
			.RST_n(RST_n_i)
			);

   data_maker SM(
				.CLK(CLK_i),
				.RST_n(RST_n_i),
				.VOUT(VIN_i),
				.DOUT(DIN_i),
				.a1(a1_i),
				.b1(b1_i),
				.b0(b0_i),
				.END_SIM(END_SIM_i));

   Filter UUT(
			.CLK(CLK_i),
			.RST_n(RST_n_i),
			.DIN(DIN_i),
            .VIN(VIN_i),
			.a1(a1_i),
			.b1(b1_i),
			.b0(b0_i),
            .DOUT(DOUT_i),
            .VOUT(VOUT_i)
			);

   data_sink DS(
				.CLK(CLK_i),
				.RST_n(RST_n_i),
				.VIN(VOUT_i),
				.DIN(DOUT_i)
				);   

endmodule

		   
