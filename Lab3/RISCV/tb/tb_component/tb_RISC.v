//`timescale 1ns

module tb_RISCV ();

   wire 			CLK_i;
   wire 			RST_n_i;
   wire		[31:0]	Data_out_i;
   wire		[31:0]  instruction_i;
   wire		[31:0] 	StartAddress_i;
   wire				write_data_i;
   wire 			read_data_i;
   wire 	[31:0]	Data_in_i;
   wire		[31:0]	PC_out_i;
   wire     [31:0]  AddressData_i; 

   clk_gen CG(
			.CLK(CLK_i),
			.RST_n(RST_n_i)
			);

   RISCV DUT(
			.clk(CLK_i),
			.rst_n(RST_n_i),
			.Data_out(Data_out_i),
			.instruction(instruction_i),
			.StartAddress(StartAddress_i),
			.AddressData(AddressData_i),
			.write_data(write_data_i),
			.read_data(read_data_i),
			.Data_in(Data_in_i),
			.PC_out(PC_out_i)
			);

  Data_memory DM(
				.clk(CLK_i),
				.rst_n(RST_n_i),
				.Address(AddressData_i),
				.write_data(write_data_i),
				.read_data(read_data_i),
				.Data_in(Data_in_i),
				.Data_out(Data_out_i)
				);   
				
   Instruction_memory IM(
				.PC(PC_out_i),
				.instruction(instruction_i),
				.StartAddress(StartAddress_i)
				);  

endmodule

		   
