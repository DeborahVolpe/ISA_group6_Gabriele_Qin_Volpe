library ieee;
use ieee.std_logic_1164.all;

entity Hazard_data_det is
	port(
		Rs1			: in std_logic_vector(4 downto 0);
		Rs2			: in std_logic_vector(4 downto 0);
		Rd1			: in std_logic_vector(4 downto 0);
		Rd2			: in std_logic_vector(4 downto 0);
		wb1			: in std_logic;
		wb2			: in std_logic;
		c1			: out std_logic;
		c2			: out std_logic;
		c3			: out std_logic;
		c4			: out std_logic
		);
end entity Hazard_data_det;

architecture structure of Hazard_data_det is
	
	signal Rs1Rd1			: std_logic_vector(4 downto 0);
	signal Rs1Rd1_equals 	: std_logic;
	signal Rs1Rd2			: std_logic_vector(4 downto 0);
	signal Rs1Rd2_equals	: std_logic;
	signal Rs2Rd1			: std_logic_vector(4 downto 0);
	signal Rs2Rd1_equals	: std_logic;
	signal Rs2Rd2			: std_logic_vector(4 downto 0);
	signal Rs2Rd2_equals	: std_logic;
	signal Rd1_zero			: std_logic;
	signal Rd2_zero			: std_logic;
	
	begin
	
		Rd1_zero	<= not(Rd1(4)) and not(Rd1(3)) and not(Rd1(2)) and not(Rd1(1)) and not(Rd1(0));
		Rd2_zero	<= not(Rd2(4)) and not(Rd2(3)) and not(Rd2(2)) and not(Rd2(1)) and not(Rd2(0));
		
		G : for i in 0 to 4 generate
			Rs1Rd1(i) <= Rs1(i) xnor Rd1(i);
			Rs1Rd2(i) <= Rs1(i) xnor Rd2(i);
			Rs2Rd1(i) <= Rs2(i) xnor Rd1(i);
			Rs2Rd2(i) <= Rs2(i) xnor Rd2(i);
		end generate;
		
		Rs1Rd1_equals <= Rs1Rd1(0) and Rs1Rd1(1) and Rs1Rd1(2) and Rs1Rd1(3) and Rs1Rd1(4) and not(Rd1_zero);
		Rs1Rd2_equals <= Rs1Rd2(0) and Rs1Rd2(1) and Rs1Rd2(2) and Rs1Rd2(3) and Rs1Rd2(4) and not(Rd2_zero);
		Rs2Rd1_equals <= Rs2Rd1(0) and Rs2Rd1(1) and Rs2Rd1(2) and Rs2Rd1(3) and Rs2Rd1(4) and not(Rd1_zero);
		Rs2Rd2_equals <= Rs2Rd2(0) and Rs2Rd2(1) and Rs2Rd2(2) and Rs2Rd2(3) and Rs2Rd2(4) and not(Rd2_zero);
		
		c1 		<= Rs1Rd1_equals and wb1;
		c2		<= Rs1Rd2_equals and wb2;
		c3		<= Rs2Rd1_equals and wb1;
		c4		<= Rs2Rd2_equals and wb2;
		
end architecture structure;
	