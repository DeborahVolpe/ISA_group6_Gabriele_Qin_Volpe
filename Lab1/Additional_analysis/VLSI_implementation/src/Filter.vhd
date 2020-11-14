library ieee;
use ieee.std_logic_1164.all;
use ieee. numeric_std.all;

-- implementation of an IIR filter of order 1 and number of bit equal to 11

entity Filter is
	port	(
			DIN			: in signed ( 10 downto 0 ); --data input
			VIN			: in std_logic; -- valid input
			RST_n		: in std_logic; -- reset signal, low active
			CLK			: in std_logic; -- clock signal
			b0			: in signed ( 10 downto 0 ); -- coefficient
			c0			: in signed	( 10 downto 0 ); -- coefficient
			c1			: in signed ( 10 downto 0 ); -- coefficient
			c2			: in signed ( 10 downto 0 ); -- coefficient
			DOUT 		: out signed ( 10 downto 0 ); -- output
			VOUT		: out std_logic -- valid output
			);
end entity Filter;

architecture structure of Filter is

	component  reg 
		generic (N : positive := 5);  -- generic for number of bit of input and output
		port(
			D       : in signed (N-1 downto 0); -- input 
			RST_n	: in std_logic; -- reset signal, low active
			en		: in std_logic; -- enable signal
			clk     : in std_logic; -- clock signal
			Q       : out signed (N-1 downto 0) -- output
			);
	end component reg;
	
	component adder
		generic ( N : positive := 8); -- generic for number of bit of inputs and output
		port(
			a			: in signed (N-1 downto 0); -- input
			b 			: in signed (N-1 downto 0); -- input
			sum 		: out signed (N-1 downto 0) -- output a+b
			);
	end component adder;
	
	component subtractor 
		generic ( N : positive := 8); -- generic for number of bit of inputs and output
		port(
			a			: in signed (N-1 downto 0); -- input
			b 			: in signed (N-1 downto 0); -- input
			subtraction	: out signed(N-1 downto 0) -- output a-b
			);
	end component subtractor;
	
	component multiplier_n
		generic ( N : positive:=4); -- generic for number of bit of inputs and output
		port 	( 
				A		: in signed (N-1 downto 0 ); -- input
				B 		: in signed (N-1 downto 0 ); -- input
				P    	: out signed (2*N-1 downto 0) -- output a*b
				);
	end component multiplier_n;
	
	component flip_flop_N_level
		generic	(
				N 		: positive := 32 -- generic for number of pipe level
				);
		port	(
				D   	: in std_logic; --input
				clk 	: in std_logic; -- clock signal
				RST_n	: in std_logic; -- reset signal, low active
				en 		: in std_logic;
				Q  		: out std_logic_vector(N-1 downto 0) -- output
				);
	end component flip_flop_N_level;
	
	signal DIN_int			: signed ( 10 downto 0 );
	signal c2_int			: signed ( 10 downto 0 );
	signal c1_int			: signed ( 10 downto 0 );
	signal c0_int			: signed ( 10 downto 0 );
	signal b0_int			: signed ( 10 downto 0 );
	signal sx_b0			: signed ( 10 downto 0 );
	signal sx_b0_del0		: signed ( 10 downto 0 );
	signal sx_b0_del		: signed ( 10 downto 0 );
	signal sx_b0_temp		: signed ( 21 downto 0 );
	signal sx_c0_c1			: signed ( 10 downto 0 );
	signal sx_c0_c1_del		: signed ( 10 downto 0 );
	signal sx_c0			: signed ( 10 downto 0 );
	signal sx_c0_del		: signed ( 10 downto 0 );
	signal sx_c0_temp		: signed ( 21 downto 0 );
	signal sx_c1			: signed ( 10 downto 0 );
	signal sx_c1_del		: signed ( 10 downto 0 );
	signal sx_c1_temp		: signed ( 21 downto 0 );
	signal sy_c2			: signed ( 10 downto 0 );
	signal sy_c2_del		: signed ( 10 downto 0 );
	signal sy_c2_temp		: signed ( 21 downto 0 );
	signal sx_w				: signed ( 10 downto 0 );
	signal sx_w_del			: signed ( 10 downto 0 );
	signal y				: signed ( 10 downto 0 );
	signal y_del			: signed ( 10 downto 0 );
	signal DIN_del_1		: signed ( 10 downto 0 );
	signal DIN_del_2		: signed ( 10 downto 0 );
	signal VIN_del			: std_logic_vector(4 downto 0);
	
	begin
	
	-- sample input register
	reg_DIN : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> DIN,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> DIN_int
							);
	
	
	-- sample coefficient register
	reg_c0 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> c0,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> c0_int
							);
	
	-- sample coefficient register
	reg_c1 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> c1,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> c1_int
							);
		
		-- sample coefficient register
	reg_c2 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> c2,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> c2_int
							);
	
	-- sample coefficient register
	reg_b0 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> b0,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> b0_int
							);


	mul_b0 : multiplier_n
				generic map	( 
							N			=> 11
							)
				port map 	( 
							A			=> b0_int,
							B 			=> DIN_int,
							P			=> sx_b0_temp
							);
					
	-- keep only the useful part of the output				
	sx_b0		<= sx_b0_temp( 20 downto 10 );
	
	regN_sx_b0:  reg
				generic map	(
							N 			=> 11
							) 
				port map	(	
							D       	=> sx_b0,
							RST_n		=> RST_n,
							en			=> VIN_del(0),
							clk     	=> clk,
							Q     		=> sx_b0_del0
							);

	regN_sx_b02:  reg
				generic map	(
							N 			=> 11
							) 
				port map	(	
							D       	=> sx_b0_del0,
							RST_n		=> RST_n,
							en			=> VIN_del(1),
							clk     	=> clk,
							Q     		=> sx_b0_del
							);
	
	-- sample input register
	reg_DIN_del_1 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> DIN_int,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> DIN_del_1
							);
							
		-- sample input register
	reg_DIN_del_2 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> DIN_del_1,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> DIN_del_2
							);
	
	mul_c0 : multiplier_n
				generic map	( 
							N			=> 11
							)
				port map 	( 
							A			=> c0_int,
							B 			=> DIN_del_1,
							P			=> sx_c0_temp
							);
					
	-- keep only the useful part of the output				
	sx_c0		<= sx_c0_temp( 20 downto 10 );
	
	regN_sx_c0:  reg
				generic map	(
							N 			=> 11
							) 
				port map	(	
							D       	=> sx_c0,
							RST_n		=> RST_n,
							en			=> VIN_del(0),
							clk     	=> clk,
							Q     		=> sx_c0_del
							);
							
	mul_c1 : multiplier_n
				generic map	( 
							N			=> 11
							)
				port map 	( 
							A			=> c1_int,
							B 			=> DIN_del_2,
							P			=> sx_c1_temp
							);
					
	-- keep only the useful part of the output				
	sx_c1		<= sx_c1_temp( 20 downto 10 );
	
	regN_sx_c1:  reg
				generic map	(
							N 			=> 11
							) 
				port map	(	
							D       	=> sx_c1,
							RST_n		=> RST_n,
							en			=> VIN_del(0),
							clk     	=> clk,
							Q     		=> sx_c1_del
							);
	
	
	sub_c1_c0 : subtractor 
				generic map	(
							N			=> 11
							)
				port map	(
							a			=> sx_c0_del,
							b 			=> sx_c1_del,
							subtraction	=> sx_c0_c1
							);
							
	reg_c0_c1 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> sx_c0_c1,
							RST_n		=> RST_n,
							en			=> VIN_del(1),
							clk     	=> clk,
							Q       	=> sx_c0_c1_del
							);
							
	a_sx_w : adder
				generic map ( 
							N 			=> 11
							)
				port map	(
							a			=> sx_b0_del,
							b 			=> sx_c0_c1_del,
							sum 		=> sx_w
							);
							
	reg_sx_w : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> sx_w,
							RST_n		=> RST_n,
							en			=> VIN_del(2),
							clk     	=> clk,
							Q       	=> sx_w_del
							);
							
	reg_y : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> y,
							RST_n		=> RST_n,
							en			=> VIN_del(3),
							clk     	=> clk,
							Q       	=> y_del
							);
							
	mul_c2 : multiplier_n
				generic map	( 
							N			=> 11
							)
				port map 	( 
							A			=> c2_int,
							B 			=> y_del,
							P			=> sy_c2_temp
							);
					
	-- keep only the useful part of the output				
	sy_c2		<= sy_c2_temp( 20 downto 10 );
	
	regN_sy_c2:  reg
				generic map	(
							N 			=> 11
							) 
				port map	(	
							D       	=> sy_c2,
							RST_n		=> RST_n,
							en			=> VIN_del(3),
							clk     	=> clk,
							Q     		=> sy_c2_del
							);
												
	a_Y : adder
				generic map ( 
							N 			=> 11
							)
				port map	(
							a			=> sx_w_del,
							b 			=> sy_c2_del,
							sum 		=> y
							);

	reg_DOUT : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> y,
							RST_n		=> RST_n,
							en			=> VIN_del(3),
							clk     	=> clk,
							Q       	=> DOUT
							);
												
		
    -- delay input validation signal in order to obtain the output validation 
	-- signal with the correct timing
	FF_VOUT : flip_flop_N_level
				generic map	(
							N 			=> 5
							)
				port map	(
							D			=> VIN,
							clk 		=> clk,
							RST_n		=> RST_n,
							en 			=> '1',
							Q  			=> VIN_del
							);

	VOUT <= VIN_del(4);

end architecture structure;
