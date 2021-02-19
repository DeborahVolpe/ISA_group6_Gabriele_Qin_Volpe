library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISCV is 

	port(
		clk				: in std_logic;
		rst_n			: in std_logic;
		Data_out		: in std_logic_vector(31 downto 0);
		instruction		: in std_logic_vector(31 downto 0);
		StartAddress	: in std_logic_vector(31 downto 0);
		AddressData		: out std_logic_vector(31 downto 0);
		write_data		: out std_logic;
		read_data		: out std_logic;
		Data_in			: out std_logic_vector(31 downto 0);
		PC_out			: out std_logic_vector(31 downto 0)
		);
		
end entity RISCV;

architecture Structure of RISCV is

	component datapath
		port(
			in1					: in std_logic_vector(31 downto 0);
			in2					: in std_logic_vector(31 downto 0);
			PC					: in std_logic_vector(31 downto 0);
			immediate			: in std_logic_vector(19 downto 0);
			sel					: in std_logic_vector(2 downto 0);
			shamt				: in std_logic_vector(4 downto 0);
			sel_LUI_AUIPC		: in std_logic;
			sel_OP_LUI_AUIPC	: in std_logic;
			sub_add_n			: in std_logic;
			zero				: out std_logic;
			outputs				: out std_logic_vector(31 downto 0)	
			);
	end component datapath;
	
	component bN_2to1mux 
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;
	
	component ImmediateGenerator
		port(	
			Instruction					: in std_logic_vector(31 downto 0);
			write_data					: in std_logic;
			cond						: in std_logic;
			Immediate_mux_B				: out std_logic_vector(31 downto 0);
			ImmediateAIUPC_LUI			: out std_logic_vector(19 downto 0);
			Shamt						: out std_logic_vector(4 downto 0);
			Immediate_address_branch	: out std_logic_vector(30 downto 0);
			sel_LUI_AUIPC				: out std_logic;
			sel_OP_LUI_AUIPC			: out std_logic
			);
	end component ImmediateGenerator;
	
	component Controller
		port(
			opcode			: in std_logic_vector(6 downto 0);
			func3			: in std_logic_vector(2 downto 0);
			zero			: in std_logic;
			cond_2D			: in std_logic;
			uncond_2D		: in std_logic;
			cond			: out std_logic;
			uncond			: out std_logic;
			write_data		: out std_logic;
			read_data		: out std_logic;
			Write_RF		: out std_logic;
			PCsrc_out		: out std_logic;
			Sel_ALU			: out std_logic_vector(2 downto 0);
			selMuxEnd		: out std_logic_vector(1 downto 0);
			sub_add_n		: out std_logic
			);
	end component Controller;
	
	component Hazard_unit
		port(
			Rs1				: in std_logic_vector(4 downto 0);
			Rs2				: in std_logic_vector(4 downto 0);
			Rd1				: in std_logic_vector(4 downto 0);
			Rd2				: in std_logic_vector(4 downto 0);
			wb1				: in std_logic;
			wb2				: in std_logic;
			opcode6			: in std_logic; --for jump
			opcode5			: in std_logic; --for jump
			opcode3			: in std_logic; --for jump
			uncond_1D		: in std_logic;
			uncond_2D		: in std_logic;
			cond_2D			: in std_logic;
			zero			: in std_logic;
			load_op			: in std_logic;
			sel_WB_M		: out std_logic;
			enable_PC_NOP	: out std_logic;
			disableLoadOp	: out std_logic;
			c1				: out std_logic;
			c2				: out std_logic;
			c3				: out std_logic;
			c4				: out std_logic
			);
	end component Hazard_unit;
	
	component RegisterFile32 
		generic ( N 	: positive := 32);
		port	(
				Data_in			: in std_logic_vector ( N-1 downto 0 );
				write_enable 	: in std_logic ;
				RD_R1			: in std_logic_vector ( 4 downto 0 );
				RD_R2			: in std_logic_vector ( 4 downto 0 );
				WR_REG			: in std_logic_vector ( 4 downto 0 );
				RESETn			: in std_logic;
				clk				: in std_logic;
				out_R1			: out std_logic_vector( N-1 downto 0);
				out_R2			: out std_logic_vector( N-1 downto 0)
				);
	end component RegisterFile32;
	
	component Forward_unit
		port(
			c1			: in std_logic;
			c2			: in std_logic;
			c3			: in std_logic;
			c4			: in std_logic;
			imm			: in std_logic;
			ForwA		: out std_logic_vector(1 downto 0);
			ForwB		: out std_logic_vector(1 downto 0)
			);
	end component Forward_unit;
	
	component reg
		generic (N : positive := 5); 
		port(
			D       : in std_logic_vector(N-1 downto 0);
			RST_n	: in std_logic;
			en		: in std_logic;
			clk     : in std_logic;
			Q       : out std_logic_vector (N-1 downto 0)
			);
	end component reg;

	
	component bN_3to1mux
		generic	(N : integer := 8);
		port 	(  
				x		: in std_logic_vector (N-1 downto 0); --00
				y		: in std_logic_vector (N-1 downto 0); --01
				z		: in std_logic_vector (N-1 downto 0); --10
				s		: in std_logic_vector (1 downto 0);
				output	: out std_logic_vector (N-1 downto 0)
				);
	end component bN_3to1mux;
	
	component bN_4to1mux
		generic	(N : integer := 8);
		port 	(  
				x		: in std_logic_vector (N-1 downto 0); --00
				y		: in std_logic_vector (N-1 downto 0); --01
				z		: in std_logic_vector (N-1 downto 0); --10
				k		: in std_logic_vector (N-1 downto 0); --11
				s		: in std_logic_vector (1 downto 0);
				output	: out std_logic_vector (N-1 downto 0)
				);
	end component bN_4to1mux;
	
	component  adder
		generic ( N : positive := 8);
		port(
			a			: in std_logic_vector (N-1 downto 0);
			b 			: in std_logic_vector (N-1 downto 0);
			sum 		: out std_logic_vector (N-1 downto 0)
			);
	end component adder;
	
	component  reg_start_value
		generic (N : positive := 5); 
		port(
			D       	: in std_logic_vector (N-1 downto 0);
			start_value	: in std_logic_vector (N-1 downto 0);
			RST_n		: in std_logic;
			en			: in std_logic;
			clk     	: in std_logic;
			Q       	: out std_logic_vector (N-1 downto 0)
			);
	end component reg_start_value;
	
	component reg_N_level
		generic	(
				N : positive := 5;
				M : positive := 1 -- pipeline level
				); 
		port	(	
				D       : in std_logic_vector (N-1 downto 0);
				clk     : in std_logic;
				en		: in std_logic;
				rst_n	: in std_logic;
				Q       : out std_logic_vector (N-1 downto 0)
				);
	end component reg_N_level;
	
	component flipflop 
		port(
			D   	: in std_logic;
			RST_n	: in std_logic;
			en  	: in std_logic;
			clk 	: in std_logic;
			Q   	: out std_logic
			);
	end component flipflop;
		
	signal offset				: std_logic_vector(31 downto 0);		
	signal PC_in				: std_logic_vector(31 downto 0);
	signal enable_PC			: std_logic;
	signal PC					: std_logic_vector(31 downto 0);
	signal four					: std_logic_vector(31 downto 0);
	signal PC_next				: std_logic_vector(31 downto 0);
	signal BranchAddress		: std_logic_vector(31 downto 0);	
	signal PCsrc				: std_logic;
	signal NOP					: std_logic_vector(31 downto 0);
	signal Instruction_in		: std_logic_vector(31 downto 0);
	signal Instruction_out		: std_logic_vector(31 downto 0);
	signal rs1_IF_ID			: std_logic_vector(4 downto 0);
	signal rs2_IF_ID			: std_logic_vector(4 downto 0);
	signal rd_IF_ID				: std_logic_vector(4 downto 0);
	signal opcode_IF_ID			: std_logic_vector(6 downto 0);
	signal ALU_MEM				: std_logic_vector(31 downto 0);
	signal WB_3D				: std_logic;
	signal rs1_ID_EX			: std_logic_vector(31 downto 0);
	signal rs2_ID_EX			: std_logic_vector(31 downto 0);
	signal rs1_ID_EX_out		: std_logic_vector(31 downto 0);
	signal rs2_ID_EX_out		: std_logic_vector(31 downto 0);
	signal rd_ID_EX_out			: std_logic_vector(4 downto 0);
	signal opcode_ID_EX_out 	: std_logic_vector(6 downto 0);
	signal M_write				: std_logic; -- DataMemory write signal
	signal cond					: std_logic; -- conditional branch at Decode stage
	signal imm_B_in				: std_logic_vector(31 downto 0);
	signal imm_AUIPC_LUI_in		: std_logic_vector(19 downto 0);
	signal Shamt_in				: std_logic_vector(4 downto 0);
	signal imm_branch_addr_in	: std_logic_vector(30 downto 0);
	signal sel_LUI_AUIPC_in		: std_logic;
	signal sel_OP_LUI_AUIPC_in	: std_logic;
	signal sel_LUI_AUIPC_out	: std_logic;
	signal sel_OP_LUI_AUIPC_out	: std_logic;
	signal PC_2D				: std_logic_vector(31 downto 0);
	signal imm_B_out			: std_logic_vector(31 downto 0);
	signal imm_AUIPC_LUI_out	: std_logic_vector(19 downto 0);
	signal Shamt_out			: std_logic_vector(4 downto 0);
	signal imm_branch_addr_out	: std_logic_vector(30 downto 0);
	signal A					: std_logic_vector(31 downto 0);
	signal B					: std_logic_vector(31 downto 0);
	signal ALU_output			: std_logic_vector(31 downto 0);
	signal zero					: std_logic;
	signal zero_out				: std_logic;
	signal Sel_ALU_out			: std_logic_vector(2 downto 0);
	signal Sel_ALU_in			: std_logic_vector(2 downto 0);
	signal sub_add_n_in			: std_logic;
	signal sub_add_n_out		: std_logic;
	signal ALU_output_EX_MEM	: std_logic_vector(31 downto 0);
	signal ForwA				: std_logic_vector(1 downto 0);
	signal ForwB				: std_logic_vector(1 downto 0);
	signal BranchAddress_in		: std_logic_vector(31 downto 0);
	signal M_read_1D			: std_logic;
	signal M_write_1D			: std_logic;
	signal c1_out				: std_logic;
	signal c2_out				: std_logic;
	signal c3_out				: std_logic;
	signal c4_out				: std_logic;
	signal c1_in				: std_logic;
	signal c2_in				: std_logic;
	signal c3_in				: std_logic;
	signal c4_in				: std_logic;
	signal uncond				: std_logic;
	signal M_read				: std_logic;
	signal WB					: std_logic;
	signal cond_1D				: std_logic;
	signal cond_2D				: std_logic;
	signal uncond_1D			: std_logic;
	signal uncond_2D			: std_logic;
	signal Mem_WB				: std_logic_vector(3 downto 0);
	signal Mem_WB_sel			: std_logic_vector(3 downto 0);
	signal Mem_WB_1D			: std_logic_vector(3 downto 0);
	signal Mem_WB_sel_1D		: std_logic_vector(3 downto 0);
	signal uncond_temp			: std_logic;
	signal uncond_1D_temp		: std_logic;
	signal sel_uncond			: std_logic;
	signal WB_1D				: std_logic;
	signal WB_2D				: std_logic;
	signal M_read_2D			: std_logic;
	signal M_write_2D			: std_logic;
	signal selMuxEnd_in         : std_logic_vector(1 downto 0);
	signal selMuxEnd_1D			: std_logic_vector(1 downto 0);
	signal selMuxEnd_2D			: std_logic_vector(1 downto 0);
	signal selMuxEnd_3D			: std_logic_vector(1 downto 0);
	signal rd_EX_MEM_out		: std_logic_vector(4 downto 0);
	signal rd_MEM_WB_out		: std_logic_vector(4 downto 0);
	signal opcode_EX_MEM_out	: std_logic_vector(6 downto 0);
	signal opcode_MEM_WB_out	: std_logic_vector(6 downto 0);
	signal DataMem				: std_logic_vector(31 downto 0);
	signal DataALU				: std_logic_vector(31 downto 0);
	signal sel_WB_M				: std_logic;
	signal imm					: std_logic;
	signal PcFirstStageDisable  : std_logic;
	signal disableLoadOp		: std_logic;
	signal sel_WB_M_load		: std_logic;
	signal rd_temp				: std_logic_vector(4 downto 0);
	signal uncond_3D			: std_logic;
	signal PC_3D				: std_logic_vector(31 downto 0);
	signal NOPSel				: std_logic;


	
	begin
	
	PcFirstStageDisable  <=  not(disableLoadOp) or PCsrc; 
	
	---------------------------------------PC_Management-------------------------------------------------------------------------
	PC_reg :  reg_start_value
					generic map	(
								N				=> 32
								)
					port map	(
								D       		=> 	PC_in,
								start_value		=> StartAddress,
								RST_n			=> rst_n,
								en				=> PcFirstStageDisable,
								clk     		=> clk,
								Q       		=> PC
								);
								
	PC_out		<= PC;
	four		<= std_logic_vector(to_unsigned(4, 32));
	
	-- Adder to obtain next address
	AdderSeq :  adder
					generic map	(
								N 				=> 32
								)
					port map	(
								a				=> PC,
								b 				=> four,
								sum 			=> PC_next
								);
								
	-- if PCsrs = '1' jump is needed(BranchAddress) else in sequence (PC_next) 							
	PCmux : bN_2to1mux 
					generic map	(
								N 				=> 32
								)
					port map	( 
								x				=> PC_next,
								y				=> BranchAddress,
								s				=> PCsrc, 
								output			=> PC_in
								);
								
	NOP(31 downto 7) 		<= (others => '0'); -- X0, X0, 0
	NOP(6 downto 0)			<= "0010011"; -- ADDI

	NOPSel	<= enable_PC and not(PCsrc);
		
	-- if enable_PC= '0' NOP  							
	InstructionMux : bN_2to1mux 
					generic map	(
								N 				=> 32
								)
					port map	( 
								x				=> NOP,
								y				=> Instruction,
								s				=> NOPSel, 
								output			=> Instruction_in
								);
		
	IF_ID : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> Instruction_in,
							RST_n				=> rst_n,
							en					=> PcFirstStageDisable,
							clk    				=> clk,
							Q       			=> Instruction_out
							);
	-----------------------------------------------------------------------------------------------------------------------------------------------
			
	----------------------------------------------------PC_delay-----------------------------------------------------------------------------------
	
	regPC	: reg_N_level
				generic map	(
							N 			=> 32,
							M 			=> 2
							) 
				port map	(	
							D       	=> PC,
							clk     	=> clk,
							en			=> '1',
							rst_n		=> rst_n,
							Q       	=> PC_2D
							);
							
	regPC2 : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> PC_2D,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> PC_3D
							);
					
	-----------------------------------------------------------------------------------------------------------------------------------------------
							
	--------------------------------------------InstructionDecode-----------------------------------------------------------------------------------
	rs1_IF_ID		<= Instruction_out(19 downto 15);
	rs2_IF_ID		<= Instruction_out(24 downto 20);
	
	rd_IF_ID		<= Instruction_out(11 downto 7);
	
	opcode_IF_ID	<= Instruction_out(6 downto 0);
	
	
	RegisterFile_instance : RegisterFile32 
				generic map(
							N					=> 32
							)
				port map 	(
							Data_in				=> ALU_MEM,
							write_enable 		=> WB_3D,
							RD_R1				=> rs1_IF_ID,
							RD_R2				=> rs2_IF_ID,
							WR_REG				=> rd_MEM_WB_out,
							RESETn				=> rst_n,
							clk					=> clk,
							out_R1				=> rs1_ID_EX,
							out_R2				=> rs2_ID_EX
							);
							
	IMGen : ImmediateGenerator
				port map	(	
							Instruction					=> Instruction_out,
							write_data					=> M_write,
							cond						=> cond,
							Immediate_mux_B				=> imm_B_in,
							ImmediateAIUPC_LUI			=> imm_AUIPC_LUI_in,
							Shamt						=> Shamt_in,
							Immediate_address_branch	=> imm_branch_addr_in,
							sel_LUI_AUIPC				=> sel_LUI_AUIPC_in,
							sel_OP_LUI_AUIPC			=> sel_OP_LUI_AUIPC_in
							);
							
	Control : Controller
				port map 	(
							opcode						=> opcode_IF_ID,
							func3						=> Instruction_out(14 downto 12),
							zero						=> zero_out, 
							cond_2D						=> cond_2D,
							uncond_2D					=> uncond_2D,
							cond						=> cond,
							uncond						=> uncond,
							write_data					=> M_write,
							read_data					=> M_read,
							Write_RF					=> WB,
							PCsrc_out					=> PCsrc,
							Sel_ALU						=> Sel_ALU_in,
							selMuxEnd					=> selMuxEnd_in,
							sub_add_n					=> sub_add_n_in
							);
							
	Hazard : Hazard_unit
				port map (
							Rs1							=> rs1_IF_ID,
							Rs2							=> rs2_IF_ID,
							Rd1							=> rd_ID_EX_out,
							Rd2							=> rd_EX_MEM_out,
							wb1							=> WB_1D,
							wb2							=> WB_2D,
							opcode6						=> opcode_IF_ID(6),
							opcode5						=> opcode_IF_ID(5),
							opcode3						=> opcode_IF_ID(3),
							uncond_1D					=> uncond_1D,
							uncond_2D					=> uncond_2D,
							cond_2D						=> cond_2D,
							zero						=> zero_out,
							load_op						=> M_read_1D,
							sel_WB_M					=> sel_WB_M,
							enable_PC_NOP				=> enable_PC,
							disableLoadOp				=> disableLoadOp,
							c1							=> c1_in,
							c2							=> c2_in,
							c3							=> c3_in,
							c4							=> c4_in
						);
						
								
	FF_uncond3 : flipflop 
						port map 	(
									D   		=> uncond_2D,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> uncond_3D
									);
									
	Mem_WB			<= cond & M_write & M_read & WB;
	sel_WB_M_load	<= sel_WB_M or disableLoadOp;
									
	mux_Mem1 :  bN_2to1mux 
						generic map (
									N 			=>  4
									)
						port map 	( 
									x			=> Mem_WB,
									y			=> "0000",
									s			=> sel_WB_M_load,
									output		=> Mem_WB_sel
									);							
									
	FF_M_write1 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel(2),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> M_write_1D
									);
									
	FF_M_read1 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel(1),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> M_read_1D
									);
									
	FF_M_WB1 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel(0),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> WB_1D
									);
									
									
	FF_cond : flipflop 
						port map 	(
									D   		=> MEM_WB_sel(3),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> cond_1D
									);

	sel_uncond  <= sel_WB_M_load;
	uncond_temp <= (uncond and not (sel_uncond)); 
									
	FF_uncond : flipflop 
						port map 	(
									D   		=> uncond_temp,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> uncond_1D
									);

	Mem_WB_1D			<= cond_1D & M_write_1D & M_read_1D & WB_1D;
	
	
	mux_Mem2 :  bN_2to1mux 
						generic map (
									N 			=>  4
									)
						port map 	( 
									x			=> Mem_WB_1D,
									y			=> "0000",
									s			=> sel_WB_M,
									output		=> Mem_WB_sel_1D
									);							
									
	FF_M_write2 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel_1D(2),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> M_write_2D
									);
									
	FF_M_read2 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel_1D(1),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> M_read_2D
									);
									
									
								
									
	FF_M_WB2 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel_1D(0),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> WB_2D
									);
									
									
	FF_cond2 : flipflop 
						port map 	(
									D   		=> Mem_WB_sel_1D(3),
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> cond_2D
									);

	uncond_1D_temp <= (uncond_1D and not (sel_uncond));
									
	FF_uncond2 : flipflop 
						port map 	(
									D   		=> uncond_1D_temp,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> uncond_2D
									);
									
							
									
	FF_M_WB3 : flipflop 
						port map 	(
									D   		=> WB_2D,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> WB_3D
									);
	
	FF_sel_LUI_AIUPC : flipflop 
						port map 	(
									D   		=> sel_LUI_AUIPC_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> sel_LUI_AUIPC_out
									);
									
	FF_sel_OP_LUI_AIUPC : flipflop 
						port map 	(
									D   		=> sel_OP_LUI_AUIPC_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> sel_OP_LUI_AUIPC_out
									);
									
	FF_sub_add_n : flipflop 
						port map 	(
									D   		=> sub_add_n_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> sub_add_n_out
									);
									
	FF_MuxEnd :  reg
				generic map	(
							N					=> 2
							)
				port map	(
							D       			=> selMuxEnd_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> selMuxEnd_1D
							);
									
	FF_MuxEnd2 :  reg
				generic map	(
							N					=> 2
							)
				port map	(
							D       			=> selMuxEnd_1D,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> selMuxEnd_2D
							);
									
	FF_MuxEnd3 :  reg
				generic map	(
							N					=> 2
							)
				port map	(
							D       			=> selMuxEnd_2D,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> selMuxEnd_3D
							);
									
	FF_c1 : flipflop 
						port map 	(
									D   		=> c1_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> c1_out
									);
								
	FF_c2 : flipflop 
						port map 	(
									D   		=> c2_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> c2_out
									);
									
	FF_c3 : flipflop 
						port map 	(
									D   		=> c3_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> c3_out
									);
									
	FF_c4 : flipflop 
						port map 	(
									D   		=> c4_in,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> c4_out
									);
									
	ID_selALU : reg
				generic map	(
							N					=> 3
							)
				port map	(
							D       			=> Sel_ALU_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> Sel_ALU_out
							);
									
	ID_EX_immB : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> imm_B_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> imm_B_out
							);
							
	ID_EX_immAUIPC_LUI : reg
				generic map	(
							N					=> 20
							)
				port map	(
							D       			=> imm_AUIPC_LUI_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> imm_AUIPC_LUI_out
							);
							
	ID_EX_Shamt : reg
				generic map	(
							N					=> 5
							)
				port map	(
							D       			=> Shamt_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> Shamt_out
							);
							
	ID_EX_BranchAddre : reg
				generic map	(
							N					=> 31
							)
				port map	(
							D       			=> imm_branch_addr_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> imm_branch_addr_out
							);
							
	ID_EX_rs1 : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> rs1_ID_EX,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> rs1_ID_EX_out
							);
							
	ID_EX_rs2 : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> rs2_ID_EX,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> rs2_ID_EX_out
							);
							
	mux_rd :  bN_2to1mux 
						generic map (
									N 			=>  5
									)
						port map 	( 
									x			=> rd_IF_ID,
									y			=> "00000",
									s			=> disableLoadOp,
									output		=> rd_temp
									);		
							
	ID_EX_rd : reg
				generic map	(
							N					=> 5
							)
				port map	(
							D       			=> rd_temp,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> rd_ID_EX_out
							);
							
	ID_EX_rd1 : reg
				generic map	(
							N					=> 5
							)
				port map	(
							D       			=> rd_ID_EX_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> rd_EX_MEM_out
							);
							
	ID_EX_rd2 : reg
				generic map	(
							N					=> 5
							)
				port map	(
							D       			=> rd_EX_MEM_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> rd_MEM_WB_out
							);
							
	
							
	ID_EX_opcode : reg
				generic map	(
							N					=> 7
							)
				port map	(
							D       			=> opcode_IF_ID,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> opcode_ID_EX_out
							);

	ID_MEM_opcode : reg
				generic map	(
							N					=> 7
							)
				port map	(
							D       			=> opcode_ID_EX_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> opcode_EX_MEM_out
							);	
							
	ID_WB_opcode : reg
				generic map	(
							N					=> 7
							)
				port map	(
							D       			=> opcode_EX_MEM_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> opcode_MEM_WB_out
							);	

-------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------Alu_Execution_stage---------------------------------------------------------------

	muxA : bN_3to1mux
				generic map	(
							N 					=> 32
							)
				port map	(  
							x					=> rs1_ID_EX_out, --00
							y					=>  ALU_MEM, --01
							z					=> ALU_output_EX_MEM, --10
							s					=> ForwA,
							output				=> A
							);

	muxB : bN_4to1mux
				generic	map (
							N 					=> 32
							)
				port map	(  
							x					=> rs2_ID_EX_out, --00
							y					=> imm_B_out, --01
							z					=> ALU_output_EX_MEM, --10
							k					=> ALU_MEM, --11
							s					=> ForwB,
							output				=> B
							);

	ALU : datapath
				port map (
							in1					=> A,
							in2					=> B,
							PC					=> PC_2D,
							immediate			=> imm_AUIPC_LUI_out,
							sel					=> Sel_ALU_out,
							shamt				=> Shamt_out,
							sel_LUI_AUIPC		=> sel_LUI_AUIPC_out,
							sel_OP_LUI_AUIPC	=> sel_OP_LUI_AUIPC_out,
							sub_add_n			=> sub_add_n_out,
							zero				=> zero,
							outputs				=> ALU_output
						);	
						
	FF_zero : flipflop 
						port map 	(
									D   		=> zero,
									RST_n		=> rst_n,
									en  		=> '1',
									clk 		=> clk,
									Q   		=> zero_out
									);

	offset			<= imm_branch_addr_out & "0";

	AddressAdder : adder
				generic map (
							N					=> 32
							)
				port map 	(
							a					=> PC_2D,
							b 					=> offset,
							sum 				=> BranchAddress_in 
							);
							
	imm		<= not(opcode_ID_EX_out(5)) or M_write_1D or M_read_1D;
							
	ForwardUnit :  Forward_unit
				port map (
						c1						=> c1_out,
						c2						=> c2_out,
						c3						=> c3_out,
						c4						=> c4_out,
						imm						=> imm,
						ForwA					=> ForwA,
						ForwB					=> ForwB
						);
						
	regAddress : reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> BranchAddress_in,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> BranchAddress
							);
							
	regALU_OUT: reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> ALU_output,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> ALU_output_EX_MEM
							);
	
	AddressData			<= ALU_output_EX_MEM;
	write_data			<= M_write_2D;
	read_data			<= M_read_2D;
	
	reg_rs2MEM: reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> rs2_ID_EX_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> Data_in
							);
							
-----------------------------------------------------------------------------------------------------------------------------------------------------------
							
							
--------------------------------------------------------------MEM_WB---------------------------------------------------------------------------------------
	
	
	reg_dataMEM: reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> Data_out,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> DataMem
							);
							
	regALU_MeM: reg
				generic map	(
							N					=> 32
							)
				port map	(
							D       			=> ALU_output_EX_MEM,
							RST_n				=> rst_n,
							en					=> '1',
							clk    				=> clk,
							Q       			=> DataALU
							);
							
							
	MuxEnd : bN_3to1mux
				generic map (
							N 					=> 32
							)
			port map		(  
							x					=> DataMem,
							y					=> DataAlu,
							z					=> PC_3D,
							s					=> selMuxEnd_3D,
							output				=> ALU_MEM
							);
						
	
end architecture Structure;
	
