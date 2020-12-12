//`timescale 1ns

module tb_multiplier ();

   wire CLK_i;
   wire RST_n_i;
   wire Errore_i;
   wire [23:0] A_i;
   wire [23:0] B_i;
   wire [47:0] P_i;
   wire [47:0] P_test_i;

   clk_gen CG(
			.CLK(CLK_i), // clock signal
			.RST_n(RST_n_i) // reset low active
			);

   data_maker SM(
				.CLK(CLK_i), // clock signal
				.RST_n(RST_n_i), // reset low active
				.A(A_i), // input A
				.B(B_i)); // input B

   significant_multiplier DUT(
			.A(A_i), // input A
			.B(B_i), // input B
			.P(P_i) // product
			);
			
   multiplier_test TEST(
			.A(A_i), // input A
			.B(B_i), // input B
			.P(P_test_i) // product of beahvioural multiplier
			);

   data_sink DS(
				.CLK(CLK_i), // clock signal
				.RST_n(RST_n_i), // reset low active
				.P_test(P_test_i), //  product of beahvioural multiplier
				.P(P_i), // product
				.Errore(Errore_i) // Error signal
				);   

endmodule

		   
