library ieee;
use ieee.std_logic_1164.all;

entity mux32to1 is 
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
end entity mux32to1;

architecture structure of mux32to1 is

	begin 
		
		output		<=	
					in1 when sel ="00000" else
					in2 when sel ="00001" else
					in3 when sel ="00010" else
					in4 when sel ="00011" else
					in5 when sel ="00100" else
					in6 when sel ="00101" else
					in7 when sel ="00110" else
					in8 when sel ="00111" else
					in9 when sel ="01000" else
					in10 when sel ="01001" else
					in11 when sel ="01010" else
					in12 when sel ="01011" else
					in13 when sel ="01100" else
					in14 when sel ="01101" else
					in15 when sel ="01110" else
					in16 when sel ="01111" else
					in17 when sel ="10000" else
					in18 when sel ="10001" else
					in19 when sel ="10010" else
					in20 when sel ="10011" else
					in21 when sel ="10100" else
					in22 when sel ="10101" else
					in23 when sel ="10110" else
					in24 when sel ="10111" else
					in25 when sel ="11000" else
					in26 when sel ="11001" else
					in27 when sel ="11010" else
					in28 when sel ="11011" else
					in29 when sel ="11100" else
					in30 when sel ="11101" else
					in31 when sel ="11110" else
					in32 ;

end architecture structure;
