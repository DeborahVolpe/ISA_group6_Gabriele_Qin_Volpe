library ieee;
use ieee.std_logic_1164.all;

entity Selector_generator is
	port(
		func3		: in std_logic_vector(2 downto 0);
		opcode		: in std_logic_vector(6 downto 0);
		Sel			: out std_logic_vector(2 downto 0);
		sub_add_n	: out std_logic
		);
end entity Selector_generator;

architecture structure of Selector_generator is

	signal code		: std_logic_vector(9 downto 0);

	begin
		
		code  <= func3 & opcode;
	
		conversion_process: process(code)
								begin
									case code is 
										when "0000110011"	=> Sel <= "000";
															   sub_add_n <= '0'; --ADD
										when "0000010011"	=> Sel <= "000";
															   sub_add_n <= '0';  --ADDI
										when "0100000011"	=> Sel <= "000"; 
															   sub_add_n <= '0'; --LW
										when "1010010011"	=> Sel <= "010"; 
															   sub_add_n <= '0'; --SRAI
										when "1110010011"   => Sel <= "011"; --ANDi
															   sub_add_n <= '0'; 
										when "1000110011"   => Sel <= "100"; --XOR
															   sub_add_n <= '0'; 
										when "0100110011"	=> Sel <= "001"; --SLT
															   sub_add_n <= '1'; 
										when "0100100011"   => Sel <= "000"; --SW
															   sub_add_n <= '0'; 
										when others			=> Sel <= "000"; --Default
															   sub_add_n <= '0'; 
									end case;
							end process;
							
end architecture structure;
							
