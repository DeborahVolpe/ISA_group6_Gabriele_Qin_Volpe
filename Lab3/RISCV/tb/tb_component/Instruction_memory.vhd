library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_memory is
	port(
		PC				: in std_logic_vector(31 downto 0);
		instruction		: out std_logic_vector(31 downto 0);
		StartAddress	: out std_logic_vector(31 downto 0)
		);
end entity Instruction_memory;

architecture Structure of Instruction_memory is

	begin

		StartAddress <= std_logic_vector(to_unsigned(4194304,32));
		
		read_process: process(PC)
						begin	
								case PC is
								
									when std_logic_vector(to_unsigned(4194304,32))	=> instruction	<= "00000000011100000000100000010011";
									
									when std_logic_vector(to_unsigned(4194308,32))	=> instruction	<= "00001111110000010000001000010111";
									
									when std_logic_vector(to_unsigned(4194312,32))	=> instruction	<= "11111111110000100000001000010011";
									
									when std_logic_vector(to_unsigned(4194316,32))	=> instruction	<= "00001111110000010000001010010111";
									
									when std_logic_vector(to_unsigned(4194320,32))	=> instruction	<= "00000001000000101000001010010011";
									
									when std_logic_vector(to_unsigned(4194324,32))	=> instruction	<= "01000000000000000000011010110111";
									
									when std_logic_vector(to_unsigned(4194328,32))	=> instruction	<= "11111111111101101000011010010011";
									
									when std_logic_vector(to_unsigned(4194332,32))	=> instruction	<= "00000010000010000000100001100011";
									
									when std_logic_vector(to_unsigned(4194336,32))	=> instruction	<= "00000000000000100010010000000011";
									
									when std_logic_vector(to_unsigned(4194340,32))	=> instruction	<= "01000001111101000101010010010011";
									
									when std_logic_vector(to_unsigned(4194344,32))	=> instruction	<= "00000000100101000100010100110011";
									
									when std_logic_vector(to_unsigned(4194348,32))	=> instruction	<= "00000000000101001111010010010011";
									
									when std_logic_vector(to_unsigned(4194352,32))	=> instruction	<= "00000000100101010000010100110011";
									
									when std_logic_vector(to_unsigned(4194356,32))	=> instruction	<= "00000000010000100000001000010011";
									
									when std_logic_vector(to_unsigned(4194360,32))	=> instruction	<= "11111111111110000000100000010011";
									
									when std_logic_vector(to_unsigned(4194364,32))	=> instruction	<= "00000000110101010010010110110011";
									
									when std_logic_vector(to_unsigned(4194368,32))	=> instruction	<= "11111100000001011000111011100011";
									
									when std_logic_vector(to_unsigned(4194372,32))	=> instruction	<= "00000000000001010000011010110011";
									
									when std_logic_vector(to_unsigned(4194376,32))	=> instruction	<= "11111101010111111111000011101111";
									
									when std_logic_vector(to_unsigned(4194380,32))	=> instruction	<= "00000000110100101010000000100011";
									
									when std_logic_vector(to_unsigned(4194384,32))	=> instruction	<= "00000000000000000000000011101111";
									
									when std_logic_vector(to_unsigned(4194388,32))	=> instruction	<= "00000000000000000000000000010011";
									
									when others										=> instruction	<= "00000000011100000000100000010011"; -- VALUTARE SE SIA MEGLIO METTERE NOP
									
								end case;
						
						end process;
						
end architecture Structure;
									
									
									
