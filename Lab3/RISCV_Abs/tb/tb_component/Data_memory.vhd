library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_memory is
	port(
		clk				: in std_logic;
		rst_n			: in std_logic;
		Address			: in std_logic_vector(31 downto 0);
		write_data		: in std_logic;
		read_data		: in std_logic;
		Data_in			: in std_logic_vector(31 downto 0);
		Data_out		: out std_logic_vector(31 downto 0)
		);
end entity Data_memory;

architecture Structure of Data_memory is

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
	
	type Memoria is ARRAY ( 7 downto 0 ) of std_logic_vector ( 31 downto 0 );
	signal MATRIX						: Memoria;
	signal load_r						: std_logic_vector( 7 downto 0 );
	
	type Start_value is ARRAY ( 7 downto 0) of std_logic_vector (31 downto 0);
	signal values						: Start_value;
	
	begin
	
		values(0)			<=	std_logic_vector(to_signed(10, 32));
		values(1)			<=	std_logic_vector(to_signed(-47, 32));
		values(2)			<=	std_logic_vector(to_signed(22, 32));
		values(3)			<=	std_logic_vector(to_signed(-3, 32));
		values(4)			<=	std_logic_vector(to_signed(15, 32));
		values(5)			<=	std_logic_vector(to_signed(27, 32));
		values(6)			<=	std_logic_vector(to_signed(-4, 32));
		values(7)			<=	std_logic_vector(to_signed(0, 32));
	
		
		reg_gen : for i in 0 to 7 generate
				reg_i :  reg_start_value
				generic map	(
							N 		=> 32 
						    )
				port map	(
							D      		=> Data_in,
							RST_n		=> rst_n,
							start_value	=> values(i),
							en			=> load_r(i),
							clk     	=> clk,
							Q       	=> MATRIX(i)
							);
				end generate;
				
				
		write_process : process(write_data, Address)
							begin
								if write_data = '1' then
									case Address is 
									
										when std_logic_vector(to_unsigned(268500992,32))	=> load_r(0) <= '1';
										
										when std_logic_vector(to_unsigned(268500996,32))	=> load_r(1) <= '1';

										when std_logic_vector(to_unsigned(268501000,32))	=> load_r(2) <= '1';
								
										when std_logic_vector(to_unsigned(268501004,32))	=> load_r(3) <= '1';
										
										when std_logic_vector(to_unsigned(268501008,32))	=> load_r(4) <= '1';
										
										when std_logic_vector(to_unsigned(268501012,32))	=> load_r(5) <= '1';
										
										when std_logic_vector(to_unsigned(268501016,32))	=> load_r(6) <= '1';
										
										when std_logic_vector(to_unsigned(268501020,32))	=> load_r(7) <= '1';
										
										when others											=>
										
									end case;
								else
								
									load_r(0)	<= '0';
									load_r(1)	<= '0';
									load_r(2)	<= '0';
									load_r(3)	<= '0';
									load_r(4)	<= '0';
									load_r(5)	<= '0';
									load_r(6)	<= '0';
									load_r(7)	<= '0';
									
								end if;
								
							end process;
						
		read_process : process(Address, read_data)
							begin
								if read_data = '1' then
									case Address is 
									
										when std_logic_vector(to_unsigned(268500992,32))	=> Data_out	<= MATRIX(0);
										
										when std_logic_vector(to_unsigned(268500996,32))	=> Data_out	<= MATRIX(1);

										when std_logic_vector(to_unsigned(268501000,32))	=> Data_out	<= MATRIX(2);
								
										when std_logic_vector(to_unsigned(268501004,32))	=> Data_out	<= MATRIX(3);
										
										when std_logic_vector(to_unsigned(268501008,32))	=> Data_out	<= MATRIX(4);
										
										when std_logic_vector(to_unsigned(268501012,32))	=> Data_out	<= MATRIX(5);
										
										when std_logic_vector(to_unsigned(268501016,32))	=> Data_out	<= MATRIX(6);
										
										when std_logic_vector(to_unsigned(268501020,32))	=> Data_out	<= MATRIX(7);
										
										when others											=> Data_out	<= (others => '0');
										
									end case;
								else
								
									Data_out	<= (others => '0');
									
								end if;
								
							end process;
							
end architecture Structure;
	
