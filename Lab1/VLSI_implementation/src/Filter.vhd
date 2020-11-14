library ieee;
use ieee.std_logic_1164.all;
use ieee. numeric_std.all;

-- implementation of an IIR filter of order 1 and number of bit equal to 11

entity Filter is
	port	(
			DIN			: in signed ( 10 downto 0 ); -- data input
			VIN			: in std_logic; -- valid input
			RST_n		: in std_logic; -- reset signal, low active
			CLK			: in std_logic; -- clock signal
			b0			: in signed ( 10 downto 0 ); -- coefficient
			b1			: in signed	( 10 downto 0 ); -- coefficient
			a1			: in signed ( 10 downto 0 ); -- coefficient
			DOUT 		: out signed ( 10 downto 0 ); -- data output
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
	signal DIN_guard		: signed ( 11 downto 0 );
	signal a1_int			: signed ( 10 downto 0 );
	signal a1_guard			: signed ( 11 downto 0 );
	signal b1_int			: signed ( 10 downto 0 );
	signal b1_guard			: signed ( 11 downto 0 );
	signal b0_int			: signed ( 10 downto 0 );
	signal b0_guard			: signed ( 11 downto 0 );
	signal fb				: signed ( 11 downto 0 );
	signal fb_temp			: signed ( 23 downto 0 );
	signal sw				: signed ( 11 downto 0 );
	signal w				: signed ( 11 downto 0 ); 
	signal ff				: signed ( 10 downto 0 );
	signal ff_temp			: signed ( 23 downto 0 );
	signal y				: signed ( 10 downto 0 );
	signal y_temp			: signed ( 23 downto 0 );
	signal DOUT_int			: signed ( 10 downto 0 );
	signal VIN_del 			: std_logic_vector(1 downto 0);
	
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
	
	-- insertion of guard bit in order to not have overflow in 
	-- the follow operation
	DIN_guard	<= DIN_int(10) & DIN_int;
	
	-- sample coefficient register
	reg_a1 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> a1,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> a1_int
							);
							
	-- insertion of guard bit in order to not have overflow in 
	-- the follow operation						
	a1_guard	<= a1_int(10) & a1_int;
	
	-- sample coefficient register
	reg_b1 : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> b1,
							RST_n		=> RST_n,
							en			=> VIN,
							clk     	=> clk,
							Q       	=> b1_int
							);
							
	-- insertion of guard bit in order to not have overflow in 
	-- the follow operation						
	b1_guard	<= b1_int(10) & b1_int;
	
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
	
	-- insertion of guard bit in order to not have overflow in 
	-- the follow operation	
	b0_guard	<= b0_int(10) & b0_int;

	mul_a1 : multiplier_n
				generic map	( 
							N			=> 12
							)
				port map 	( 
							A			=> a1_guard,
							B 			=> sw,
							P			=> fb_temp
							);
					
	-- keep only the useful part of the output				
	fb			<= fb_temp( 21 downto 10 );
	
	sub_fb : subtractor 
				generic map	(
							N			=> 12
							)
				port map	(
							a			=> DIN_guard,
							b 			=> fb,
							subtraction	=> w
							);
							
	reg_w : reg 
				generic map	(
							N			=> 12
							)
				port map	(
							D			=> w,
							RST_n		=> RST_n,
							en			=> VIN_del(0),
							clk     	=> clk,
							Q       	=> sw
							);
							
	mul_b1 : multiplier_n
				generic map	( 
							N			=> 12
							)
				port map 	( 
							A			=> b1_guard,
							B 			=> sw,
							P			=> ff_temp
							);
	
	-- keep only the useful part of the output	
	ff			<= ff_temp( 20 downto 10 );
	
	mul_b0 : multiplier_n
				generic map	( 
							N			=> 12
							)
				port map 	( 
							A			=> b0_guard,
							B 			=> w,
							P			=> y_temp
							);
	
	-- keep only the useful part of the output	
	y			<= y_temp( 20 downto 10 );
							
	a_Y : adder
				generic map ( 
							N 			=> 11
							)
				port map	(
							a			=> ff,
							b 			=> y,
							sum 		=> DOUT_int
							);
							
	reg_DOUT : reg 
				generic map	(
							N			=> 11
							)
				port map	(
							D			=> DOUT_int,
							RST_n		=> RST_n,
							en			=> VIN_del(0),
							clk     	=> clk,
							Q       	=> DOUT
							);
		
    -- delay input validation signal in order to obtain the output validation 
	-- signal with the correct timing
	FF_VOUT : flip_flop_N_level
				generic map	(
							N 			=> 2
							)
				port map	(
							D			=> VIN,
							clk 		=> clk,
							RST_n		=> RST_n,
							en 			=> '1',
							Q  			=> VIN_del
							);

	VOUT <= VIN_del(1);

end architecture structure;
