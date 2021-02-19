library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile32 is
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
end RegisterFile32;

architecture Structure of RegisterFile32 is

	component reg
		generic (N : positive := 5); 
		port(
			D       : in std_logic_vector (N-1 downto 0);
			RST_n	: in std_logic;
			en		: in std_logic;
			clk     : in std_logic;
			Q       : out std_logic_vector (N-1 downto 0)
			);
	end component reg;
	
	component reg_start_value
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
	
	component Decoder
		port( 
			write_enable 		: in std_logic;
			write_reg			: in std_logic_vector( 4 downto 0);
			load_r				: out std_logic_vector(31 downto 0)
			);
	end component Decoder;
	
	component mux32to1
		generic ( N		: positive := 32);
		port	(
				in1		: in std_logic_vector( N-1 downto 0 );
				in2		: in std_logic_vector( N-1 downto 0 );
				in3		: in std_logic_vector( N-1 downto 0 );
				in4		: in std_logic_vector( N-1 downto 0 );
				in5		: in std_logic_vector( N-1 downto 0 );
				in6		: in std_logic_vector( N-1 downto 0 );
				in7		: in std_logic_vector( N-1 downto 0 );
				in8		: in std_logic_vector( N-1 downto 0 );
				in9		: in std_logic_vector( N-1 downto 0 );
				in10	: in std_logic_vector( N-1 downto 0 );
				in11	: in std_logic_vector( N-1 downto 0 );
				in12	: in std_logic_vector( N-1 downto 0 );
				in13	: in std_logic_vector( N-1 downto 0 );
				in14	: in std_logic_vector( N-1 downto 0 );
				in15	: in std_logic_vector( N-1 downto 0 );
				in16	: in std_logic_vector( N-1 downto 0 );
				in17	: in std_logic_vector( N-1 downto 0 );
				in18	: in std_logic_vector( N-1 downto 0 );
				in19	: in std_logic_vector( N-1 downto 0 );
				in20	: in std_logic_vector( N-1 downto 0 );
				in21	: in std_logic_vector( N-1 downto 0 );
				in22	: in std_logic_vector( N-1 downto 0 );
				in23	: in std_logic_vector( N-1 downto 0 );
				in24	: in std_logic_vector( N-1 downto 0 );
				in25	: in std_logic_vector( N-1 downto 0 );
				in26	: in std_logic_vector( N-1 downto 0 );
				in27	: in std_logic_vector( N-1 downto 0 );
				in28	: in std_logic_vector( N-1 downto 0 );
				in29	: in std_logic_vector( N-1 downto 0 );
				in30	: in std_logic_vector( N-1 downto 0 );
				in31	: in std_logic_vector( N-1 downto 0 );
				in32	: in std_logic_vector( N-1 downto 0 );
				sel 	: in std_logic_vector( 4 downto 0 );
				output	: out std_logic_vector( N-1 downto 0 )
				);
	end component mux32to1;

	type Register32 is ARRAY ( 31 downto 0 ) of std_logic_vector ( N-1 downto 0 );
	signal MATRIX						: Register32;
	signal out_R1_temp, out_R2_temp		: std_logic_vector( N-1 downto 0 );
	signal load_r						: std_logic_vector( 31 downto 0 );
	
	begin
	
		reg0 :  reg
				generic map	(
							N 		=> N 
						    )
				port map	(
							D      	=> Data_in,
							RST_n	=> RESETn,
							en		=> '0',
							clk     => clk,
							Q       => MATRIX(0)
							);
							
		reg1 :  reg
				generic map	(
							N 		=> N 
						    )
				port map	(
							D      	=> Data_in,
							RST_n	=> RESETn,
							en		=> load_r(1),
							clk     => clk,
							Q       => MATRIX(1)
							);
							
		reg2 :  reg_start_value
				generic map	(
							N 		=> N 
						    )
				port map	(
							D      		=> Data_in,
							RST_n		=> RESETn,
							start_value => std_logic_vector(to_signed(2147479548,32)),
							en			=> load_r(2),
							clk     	=> clk,
							Q      		=> MATRIX(2)
							);
							
		reg3 :  reg_start_value
				generic map	(
							N 		=> N 
						    )
				port map	(
							D      		=> Data_in,
							RST_n		=> RESETn,
							start_value => std_logic_vector(to_signed(268468224,32)),
							en			=> load_r(3),
							clk     	=> clk,
							Q      		=> MATRIX(3)
							);					
							
		reg_gen : for i in 4 to 31 generate
				reg_i :  reg
				generic map	(
							N 		=> N 
						    )
				port map	(
							D      	=> Data_in,
							RST_n	=> RESETn,
							en		=> load_r(i),
							clk     => clk,
							Q       => MATRIX(i)
							);
		end generate;
		
		Dec : Decoder
				port map	( 
							write_enable 		=> write_enable,
							write_reg			=> WR_REG,
							load_r				=> load_r
							);

		mux1 : mux32to1 
				port map (
						in1 		=> MATRIX (0 ),
						in2 		=> MATRIX (1 ),
						in3 		=> MATRIX (2 ),
						in4 		=> MATRIX (3 ),
						in5 		=> MATRIX (4 ),
						in6 		=> MATRIX (5 ),
						in7 		=> MATRIX (6 ),	
						in8 		=> MATRIX (7 ),
						in9 		=> MATRIX (8 ),
						in10 		=> MATRIX (9 ),
						in11 		=> MATRIX (10) ,
						in12 		=> MATRIX (11) ,
						in13 		=> MATRIX (12) ,
						in14 		=> MATRIX (13) ,
						in15 		=> MATRIX (14) ,
						in16 		=> MATRIX (15) ,
						in17 		=> MATRIX (16) ,
						in18 		=> MATRIX (17) ,
						in19 		=> MATRIX (18) ,
						in20 		=> MATRIX (19) ,
						in21 		=> MATRIX (20) ,
						in22 		=> MATRIX (21) ,
						in23 		=> MATRIX (22) ,
						in24 		=> MATRIX (23) ,
						in25 		=> MATRIX (24) ,
						in26		=> MATRIX (25) ,	
						in27 		=> MATRIX (26) ,
						in28 		=> MATRIX (27) ,
						in29 		=> MATRIX (28) ,
						in30 		=> MATRIX (29) ,
						in31		=> MATRIX (30) ,
						in32		=> MATRIX (31) ,
						sel			=> RD_R1 ,
						output		=> out_R1_temp
						);

		mux2 : mux32to1 
				port map (
						in1 		=> MATRIX (0 ),
						in2 		=> MATRIX (1 ),
						in3 		=> MATRIX (2 ),
						in4 		=> MATRIX (3 ),
						in5 		=> MATRIX (4 ),
						in6 		=> MATRIX (5 ),
						in7 		=> MATRIX (6 ),	
						in8 		=> MATRIX (7 ),
						in9 		=> MATRIX (8 ),
						in10 		=> MATRIX (9 ),
						in11 		=> MATRIX (10) ,
						in12 		=> MATRIX (11) ,
						in13 		=> MATRIX (12) ,
						in14 		=> MATRIX (13) ,
						in15 		=> MATRIX (14) ,
						in16 		=> MATRIX (15) ,
						in17 		=> MATRIX (16) ,
						in18 		=> MATRIX (17) ,
						in19 		=> MATRIX (18) ,
						in20 		=> MATRIX (19) ,
						in21 		=> MATRIX (20) ,
						in22 		=> MATRIX (21) ,
						in23 		=> MATRIX (22) ,
						in24 		=> MATRIX (23) ,
						in25 		=> MATRIX (24) ,
						in26		=> MATRIX (25) ,	
						in27 		=> MATRIX (26) ,
						in28 		=> MATRIX (27) ,
						in29 		=> MATRIX (28) ,
						in30 		=> MATRIX (29) ,
						in31		=> MATRIX (30) ,
						in32		=> MATRIX (31) ,
						sel			=> RD_R2 ,
						output		=> out_R2_temp
						);

	OUT_R1	<=	Data_in when RD_R1 = WR_REG and write_enable ='1' else out_R1_temp ;

	OUT_R2	<=	Data_in when RD_R2 = WR_REG and write_enable ='1' else out_R2_temp;

end architecture Structure;
	
