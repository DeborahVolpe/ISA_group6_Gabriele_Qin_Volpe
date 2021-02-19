library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    CLK     	: in  std_logic;
    RST_n   	: in  std_logic;
	in1			: out std_logic_vector(31 downto 0);
	in2			: out std_logic_vector(31 downto 0);
	PC			: out std_logic_vector(31 downto 0);
	immediate	: out std_logic_vector(19 downto 0);
	sel			: out std_logic_vector(2 downto 0);
	shamt		: out std_logic_vector(4 downto 0);
	opcode2		: out std_logic;
	opcode5		: out std_logic;
	sub_add_n	: out std_logic;
    END_SIM 	: out std_logic
	);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns; --delay 

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 1);  

begin  -- beh

  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "./input.txt";
    variable line_in : line;
	variable space : character;
    variable in1v, in2v	: std_logic_vector(31 downto 0);
	variable PCv		: std_logic_vector(31 downto 0);
	variable immediatev	: std_logic_vector(19 downto 0);
	variable selv		: std_logic_vector(2 downto 0);
	variable shamtv		: std_logic_vector(4 downto 0);
	variable opcode2v	: std_logic;
	variable opcode5v	: std_logic;
	variable sub_add_nv	: std_logic;
	
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      in1 		<= (others => '0') after tco;    
	  in2		<= (others => '0') after tco; 
	  immediate	<= (others => '0') after tco; 
	  sel		<= (others => '0') after tco;
	  shamt		<= (others => '0') after tco;
	  opcode2	<= '0' after tco;
	  opcode5	<= '0' after tco;
	  sub_add_n <= '0' after tco;
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in);
        read(line_in, in1v);
		read(line_in, space);
		read(line_in, in2v);
		read(line_in, space);
		read(line_in, PCv);
		read(line_in, space);
		read(line_in, immediatev);
		read(line_in, space);
		read(line_in, selv);
		read(line_in, space);
		read(line_in, shamtv);
		read(line_in, space);
		read(line_in, opcode2v);
		read(line_in, space);
		read(line_in, opcode5v);
		read(line_in, space);
		read(line_in, sub_add_nv);
		
		in1			<= in1v;
		in2			<= in2v;
		PC			<= PCv;
		immediate	<= immediatev;
		sel			<= selv;
		shamt		<= shamtv;
		opcode2		<= opcode2v;
		opcode5		<= opcode5v;
		sub_add_n	<= sub_add_nv;

        sEndSim <= '0' after tco;
      else       
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1) <= END_SIM_i(0) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(1);  

end beh;
