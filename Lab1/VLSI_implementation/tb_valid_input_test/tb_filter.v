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
			.END_SIM(END_SIM_i), // end simulation
			.CLK(CLK_i),  // clock signal
			.RST_n(RST_n_i) // reset low active
			);

   data_maker SM(
				.CLK(CLK_i),  // clock signal
				.RST_n(RST_n_i), // reset low active
				.VOUT(VIN_i), // valid input signal
				.DOUT(DIN_i),  // data input signal
				.a1(a1_i),  //coefficient
				.b1(b1_i),  //coefficient
				.b0(b0_i),  //coefficient
				.END_SIM(END_SIM_i)); //end simulation signal

   Filter UUT(
			.CLK(CLK_i), //clock signal
			.RST_n(RST_n_i), // reset low active
			.DIN(DIN_i),  // data input
            .VIN(VIN_i), // valid input
			.a1(a1_i), // coefficient
			.b1(b1_i), // coefficient
			.b0(b0_i), // coefficient
            .DOUT(DOUT_i), //data output
            .VOUT(VOUT_i) // valid output
			);

   data_sink DS(
				.CLK(CLK_i), // clock signal
				.RST_n(RST_n_i),  // reset low active
				.VIN(VOUT_i), // valid output signal
				.DIN(DOUT_i) // data output
				);   

endmodule

		   
