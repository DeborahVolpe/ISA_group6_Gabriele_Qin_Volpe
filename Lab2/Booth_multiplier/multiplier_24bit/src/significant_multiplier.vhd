library ieee; 
use ieee.std_logic_1164.all;

entity significant_multiplier is

	port(
			A		: in std_logic_vector ( 23 downto 0 );
			B 		: in std_logic_vector ( 23 downto 0 );
			P		: out std_logic_vector ( 47 downto 0 )
		);
		
end entity significant_multiplier;

architecture structure of significant_multiplier is

	component partial_product_generator 

		generic ( N : positive := 24 );
		port(
				b2j_plus_1		: in std_logic;
				b2j				: in std_logic;
				b2j_minus_1		: in std_logic;
				A				: in std_logic_vector ( N-1 downto 0 );
				p				: out std_logic_vector ( N downto 0 );
				s				: out std_logic
			);
		
	end component partial_product_generator;

	component CSA 
	
		generic ( N		: positive := 8 );
		port(
				a		: in std_logic_vector ( N-1 downto 0 );
				b		: in std_logic_vector ( N-1 downto 0 );
				c		: in std_logic_vector ( N-1 downto 0 );
				sum		: out std_logic_vector ( N-1 downto 0 );
				carry	: out std_logic_vector ( N-1 downto 0 )
			);
			
	end component CSA;
	
	component half_adder 
	
		port(
				a		: in std_logic;
				b		: in std_logic;
				s		: out std_logic;
				c_out	: out std_logic
			);
			
	end component half_adder;
	
	component full_adder
		port(
				a		: in std_logic;
				b		: in std_logic;
				c_in	: in std_logic;
				s		: out std_logic;
				c_out	: out std_logic
			);
	end component full_adder;
	
	component adder 
		generic ( N : positive := 8);
		port(
			a			: in std_logic_vector (N-1 downto 0);
			b 			: in std_logic_vector (N-1 downto 0);
			sum 		: out std_logic_vector (N-1 downto 0)
			);
	end component adder;
		
	
	signal P0, 	P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12	: std_logic_vector (24 downto 0);
	signal s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12	: std_logic;
	signal sum0_2, carry0_2											: std_logic_vector (9 downto 0);
	signal a_add0_2, b_add0_2										: std_logic_vector (9 downto 0);
	signal sum3_5, carry3_5											: std_logic_vector (8 downto 0);
	signal sum6_8, carry6_8											: std_logic_vector (12 downto 0);
	signal sum1, carry1, sum2, carry2, sum3, carry3, a_fa8 			: std_logic;
	signal sum4, carry4, sum5, carry5, sum6, carry6, a_ha4			: std_logic;
	signal sum7, carry7, sum8, carry8, sum9, carry9					: std_logic;
	signal sum10, carry10, sum11, carry11, a_ha41bis				: std_logic;
	signal sum12, carry12, sum13, carry13							: std_logic;
	signal sum14, carry14, a_add14, b_add14, c_add14				: std_logic_vector (27 downto 0);
	signal sum17, carry17, a_add17, b_add17, c_add17 				: std_logic_vector (23 downto 0);
	signal sum23, carry23, a_add23, b_add23, c_add23				: std_logic_vector (19 downto 0);
	signal sum15, carry15, sum16, carry16							: std_logic;
	signal sum18, carry18, sum19, carry19							: std_logic;
	signal sum20, carry20, sum21, carry21							: std_logic;
	signal sum22, carry22, sum24, carry24							: std_logic;
	signal sum25, carry25, sum26, carry26							: std_logic;
	signal sum27, carry27, sum28, carry28							: std_logic;
	signal sum29, carry29, a_add29, b_add29, c_add29				: std_logic_vector(35 downto 0);
	signal sum30, carry30, sum30bis, carry30bis						: std_logic;
	signal sum31, carry31, a_add31, b_add31, c_add31				: std_logic_vector(31 downto 0);
	signal sum32, carry32, sum33, carry33							: std_logic;
	signal sum34, carry34, sum35, carry35							: std_logic;
	signal sum36, carry36, a_add36, b_add36, c_add36				: std_logic_vector(39 downto 0);
	signal sum37, carry37, sum38, carry38, sum39, carry39			: std_logic;
	signal sum40, carry40, a_add40, b_add40, c_add40				: std_logic_vector(43 downto 0);
	signal sum41, carry41, sum41bis, carry41bis						: std_logic;
	signal sum42, carry42, sum43, carry43							: std_logic;
	signal sum44, a_add44, b_add44									: std_logic_vector(48 downto 0);
	signal sum46, carry46											: std_logic_vector(6 downto 0);
	signal sum45, carry45, sum47, carry47							: std_logic;
	signal sum48, carry48, sum49, carry49							: std_logic;
	signal sum50, carry50, sum51 , carry51							: std_logic;
	signal sum12bis, carry12bis										: std_logic;
	
	begin
	
		PP0 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(1),
									b2j				=> B(0),
									b2j_minus_1		=> '0',
									A				=> A,
									p				=> P0,
									s				=> s0
									);
									
		PP1 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(3),
									b2j				=> B(2),
									b2j_minus_1		=> B(1),
									A				=> A,
									p				=> P1,
									s				=> s1
									);
									
		PP2 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(5),
									b2j				=> B(4),
									b2j_minus_1		=> B(3),
									A				=> A,
									p				=> P2,
									s				=> s2
									);
									
		PP3 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(7),
									b2j				=> B(6),
									b2j_minus_1		=> B(5),
									A				=> A,
									p				=> P3,
									s				=> s3
									);
									
		PP4 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(9),
									b2j				=> B(8),
									b2j_minus_1		=> B(7),
									A				=> A,
									p				=> P4,
									s				=> s4
									);
									
		PP5 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(11),
									b2j				=> B(10),
									b2j_minus_1		=> B(9),
									A				=> A,
									p				=> P5,
									s				=> s5
									);
									
		PP6 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(13),
									b2j				=> B(12),
									b2j_minus_1		=> B(11),
									A				=> A,
									p				=> P6,
									s				=> s6
									);
									
		PP7 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(15),
									b2j				=> B(14),
									b2j_minus_1		=> B(13),
									A				=> A,
									p				=> P7,
									s				=> s7
									);
									
		PP8 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(17),
									b2j				=> B(16),
									b2j_minus_1		=> B(15),
									A				=> A,
									p				=> P8,
									s				=> s8
									);
									
		PP9 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(19),
									b2j				=> B(18),
									b2j_minus_1		=> B(17),
									A				=> A,
									p				=> P9,
									s				=> s9
									);
									
											
		PP10 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(21),
									b2j				=> B(20),
									b2j_minus_1		=> B(19),
									A				=> A,
									p				=> P10,
									s				=> s10
									);
									
		PP11 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> B(23),
									b2j				=> B(22),
									b2j_minus_1		=> B(21),
									A				=> A,
									p				=> P11,
									s				=> s11
									);
									
		PP12 : partial_product_generator 
						generic map ( N				=> 24 )
						port map	(
									b2j_plus_1		=> '0',
									b2j				=> '0',
									b2j_minus_1		=> B(23),
									A				=> A,
									p				=> P12,
									s				=> s12
									);
									
---------------------------------Layer1-----------------------------------------

	a_add0_2 <= not(s0) & s0 & s0 & P0(24 downto 18) ;
	b_add0_2 <= not(s1) & P1(24 downto 16);



	add0_2: CSA 
			generic map  ( N		=> 10 )	
			port map	(
						a			=> a_add0_2,
						b			=> b_add0_2,
						c			=> P2(23 downto 14),
						sum			=> sum0_2,
						carry		=> carry0_2
						);
						
	add3_5: CSA 
			generic map  ( N		=> 9 )	
			port map	(
						a			=> P3 (22 downto 14),
						b			=> P4 (20 downto 12),
						c			=> P5 (18 downto 10),
						sum			=> sum3_5,
						carry		=> carry3_5
						);
						
	add6_8: CSA 
			generic map  ( N		=> 13 )	
			port map	(
						a			=> P6 (21 downto 9),
						b			=> P7 (19 downto 7),
						c			=> P8 (17 downto 5),
						sum			=> sum6_8,
						carry		=> carry6_8
						);
						
	add46: CSA 
			generic map  ( N		=> 7 )	
			port map	(
						a			=> P9 (12 downto 6),
						b			=> P10 (10 downto 4),
						c			=> P11 (8 downto 2),
						sum			=> sum46,
						carry		=> carry46
						);
						
	HA1 : half_adder 
			port map (
						a			=> '1',
						b			=> P2(24),
						s			=> sum1,
						c_out		=> carry1
					);
					
	HA2 : half_adder 
			port map (
						a			=> P0(17),
						b			=> P1(15),
						s			=> sum2,
						c_out		=> carry2
					);
					
	HA3 : half_adder 
			port map (
						a			=> P0(16),
						b			=> P1(14),
						s			=> sum3,
						c_out		=> carry3
					);
	a_ha4 <= not(s2);	
			
	HA4 : half_adder 
			port map (
						a			=> a_ha4,
						b			=> P3(23),
						s			=> sum4,
						c_out		=> carry4
					);
			
	HA5 : half_adder 
			port map 	(
						a			=> P3(13),
						b			=> P4(11),
						s			=> sum5,
						c_out		=> carry5
						);
						
	HA6 : half_adder 
			port map 	(
						a			=> P3(12),
						b			=> P4(10),
						s			=> sum6,
						c_out		=> carry6
						);
						
	HA7 : half_adder 
			port map 	(
						a			=> '1',
						b			=> P3(24),
						s			=> sum7,
						c_out		=> carry7
						);
					
	a_fa8 <= not(s3);	
	
	FA8	: full_adder
			port map(
					a				=>  a_fa8,
					b				=> P4(23),
					c_in			=> P5(21),
					s				=> sum8,
					c_out			=> carry8
					);
			
	FA9	: full_adder
			port map(
					a				=> '1',
					b				=> P4(24),
					c_in			=> P5(22),
					s				=> sum9,
					c_out			=> carry9
					);

	HA10 : half_adder 
			port map 	(
						a			=> P4(22),
						b			=> P5(20),
						s			=> sum10,
						c_out		=> carry10
						);
						
	HA11 : half_adder 
			port map 	(
						a			=> P4(21),
						b			=> P5(19),
						s			=> sum11,
						c_out		=> carry11
						);
						
	HA12 : half_adder 
			port map 	(
						a			=> P9(13),
						b			=> P10(11),
						s			=> sum12,
						c_out		=> carry12
						);
						
	HA12bis : half_adder 
			port map 	(
						a			=> P6(22),
						b			=> P7(20),
						s			=> sum12bis,
						c_out		=> carry12bis
						);
						
	HA13 : half_adder 
			port map 	(
						a			=> P6(8),
						b			=> P7(6),
						s			=> sum13,
						c_out		=> carry13
						);
	HA45 : half_adder 
			port map 	(
						a			=> P9(5),
						b			=> P10(3),
						s			=> sum45,
						c_out		=> carry45
						);
						
	HA47 : half_adder 
			port map 	(
						a			=> P9(4),
						b			=> P10(2),
						s			=> sum47,
						c_out		=> carry47
						);
						
											
---------------------------------Layer2-----------------------------------------

	a_add14 <= not(s7) & '1' & not(s6) & '1' & not(s5) & '1' & not(s4) & sum9 & sum8 & sum7 & sum4 & sum1 & sum0_2 & sum2 & sum3 & P0(15 downto 12);	
	b_add14 <= P8(23) & P7(24 downto 23) & P6(24 downto 23) & P5(24) & carry9 & carry8 & carry7 & carry4 & carry1 & carry0_2 & carry2 & carry3 & P2(12) & P1(13 downto 10);	
	c_add14 <= P9(21) & P8(22 downto 21) & P7(22 downto 21) & sum12bis & P5(23) & P9(14) & sum12 & sum10 & sum11 & sum3_5 & sum5 & sum6 & P2(13) & P3(10) & P2(11 downto 8);
		

	add14: CSA
			generic map  ( N		=> 28 )	
			port map	(
						a			=> a_add14,
						b			=> b_add14,
						c			=> c_add14,
						sum			=> sum14,
						carry		=> carry14
						);
				
	a_add17 <= P9(19) & P8(20) & carry12bis & P8(18) & P9(15) & carry12 & carry10 & carry11 & carry3_5 & carry5 & carry6 & P5(8) & P3(11) & P4(8) & P3(9 downto 8);
	b_add17 <= P10(17) & P9(18) & P8(19) & P9(16) & sum6_8 & sum13 & P5(9) & P6(6) & P4(9) & P5(6) & P4(7 downto 6);
	c_add17 <= P11(15) & P10(16) & P9(17) & carry6_8 & carry13 & P8(4) & P6(7) & P7(4) & P5(7) & P6(4) & P5(5 downto 4);

			
	add17: CSA
			generic map  ( N		=> 24 )	
			port map	(
						a			=> a_add17,
						b			=> b_add17,
						c			=> c_add17,
						sum			=> sum17,
						carry		=> carry17
						);
					
	a_add23 <= P10(15 downto 12) & P11(9) & sum46 & sum45 & sum47 & P9(3 downto 2) & P7(5) & P8(2) & P6(5) & P7(2);
	b_add23 <= P11(13 downto 10) & carry46 & carry45 & carry47 & P11(0) & P10(1 downto 0) & P8(3) & P9(0) & P7(3) & P8(0) ;
	c_add23 <= P12(11 downto 0) & P11(1) & s11 & '0' & s10 & P9(1) & s9 & P8(1) & s8;
	
	add23: CSA
			generic map  ( N		=> 20 )	
			port map	(
						a			=> a_add23,
						b			=> b_add23,
						c			=> c_add23,
						sum			=> sum23,
						carry		=> carry23
						);
							
	
	HA15 : half_adder 
			port map 	(
						a			=> P0(11),
						b			=> P1(9),
						s			=> sum15,
						c_out		=> carry15
						);
					
	HA16 : half_adder 
			port map 	(
						a			=> P0(10),
						b			=> P1(8),
						s			=> sum16,
						c_out		=> carry16
						);

	HA21 : half_adder 
			port map 	(
						a			=> P3(7),
						b			=> P4(5),
						s			=> sum21,
						c_out		=> carry21
						);
						
	HA22 : half_adder 
			port map 	(
						a			=> P3(6),
						b			=> P4(4),
						s			=> sum22,
						c_out		=> carry22
						);
						
	HA24 : half_adder 
			port map 	(
						a			=> P11(14),
						b			=> P12(12),
						s			=> sum24,
						c_out		=> carry24
						);
						
	HA27 : half_adder 
			port map 	(
						a			=> P6(3),
						b			=> P7(1),
						s			=> sum27,
						c_out		=> carry27
						);
						
	HA28 : half_adder 
			port map 	(
						a			=> P6(2),
						b			=> P7(0),
						s			=> sum28,
						c_out		=> carry28
						);
						
	HA48 : half_adder 
			port map 	(
						a			=> P9(20),
						b			=> P10(18),
						s			=> sum48,
						c_out		=> carry48
						);
						
	HA49 : half_adder 
			port map 	(
						a			=> '1',
						b			=> P8(24),
						s			=> sum49,
						c_out		=> carry49
						);
					
---------------------------------Layer3---------------------------------------------
	
	a_add29 <= not(s9) & '1' & not(s8) & sum49 & sum14 & sum15 & sum16 & P0(9 downto 8);
	b_add29 <= P10(23) & P9(24) & carry49 & carry14 & carry15 & carry16 & P2(6) & P1(7 downto 6);
	c_add29 <= P11(21) & P10(22) & P9(23 downto 22) & p10(19) & sum48 & sum17 & sum21 & sum22 & P2(7) & P3(4) & P2(5 downto 4);


	add29: CSA
			generic map  ( N		=> 36 )	
			port map	(
						a			=> a_add29,
						b			=> b_add29,
						c			=> c_add29,
						sum			=> sum29,
						carry		=> carry29
						);
						
	HA30 : half_adder 
			port map 	(
						a			=> P11(20),
						b			=> P12(18),
						s			=> sum30,
						c_out		=> carry30
						);
	
	a_add31 <= P10(21 downto 20 ) & carry48 & carry17 & carry21 & carry22 & P5(2) & P3(5) & P4(2);
	b_add31 <= P11(19 downto 16) & P12(13) & sum24 & sum23 & sum27 & sum28 & P5(3) & P6(0) & P4(3) & P5(0);
	c_add31 <= P12(17 downto 14) & carry24 & carry23 & carry27 & carry28 & s7 & P6(1) & s6 & P5(1) & s5;			
		
	add31: CSA
			generic map  ( N		=> 32 )	
			port map	(
						a			=> a_add31,
						b			=> b_add31,
						c			=> c_add31,
						sum			=> sum31,
						carry		=> carry31
						);

	HA32 : half_adder 
			port map 	(
						a			=> P3(3),
						b			=> P4(1),
						s			=> sum32,
						c_out		=> carry32
						);
						
	HA33 : half_adder 
			port map 	(
						a			=> P3(2),
						b			=> P4(0),
						s			=> sum33,
						c_out		=> carry33
						);
						
	HA34 : half_adder 
			port map 	(
						a			=> P0(7),
						b			=> P1(5),
						s			=> sum34,
						c_out		=> carry34
						);
						
	HA35 : half_adder 
			port map 	(
						a			=> P0(6),
						b			=> P1(4),
						s			=> sum35,
						c_out		=> carry35
						);
						
	HA50 : half_adder 
			port map 	(
						a			=> '1',
						b			=> P10(24),
						s			=> sum50,
						c_out		=> carry50
						);
						
---------------------------------Layer4---------------------------------------------

	a_add36 <= not(s10) & sum50 & sum29 & sum34 & sum35;
	b_add36 <= carry50 & carry29 & carry34 & carry35 & P2(2);
	c_add36 <= P11(23 downto 22) & P12(19) & sum30 & sum31 & sum32 & sum33 & P2(3) & P3(0);

	add36: CSA
			generic map  ( N		=> 40 )	
			port map	(
						a			=> a_add36,
						b			=> b_add36,
						c			=> c_add36,
						sum			=> sum36,
						carry		=> carry36
						);
						

						
	HA38 : half_adder 
			port map 	(
						a			=> P0(5),
						b			=> P1(3),
						s			=> sum38,
						c_out		=> carry38
						);
						
	HA39 : half_adder 
			port map 	(
						a			=> P0(4),
						b			=> P1(2),
						s			=> sum39,
						c_out		=> carry39
						);
						
	HA51 : half_adder 
			port map 	(
						a			=> '1',
						b			=> P11(24),
						s			=> sum51,
						c_out		=> carry51
						);
						
---------------------------------Layer5---------------------------------------------

	a_add40 <= not(s11) & sum51 & sum36 & sum38 & sum39;
	b_add40 <= carry51 & carry36 & carry38 & carry39 & P2(0);
	c_add40 <= P12(23 downto 20) & carry30  & carry31 & carry32 & carry33 & s4 & P3(1) & s3 & P2(1) & s2;

	add40: CSA
			generic map  ( N		=> 44 )	
			port map	(
						a			=> a_add40,
						b			=> b_add40,
						c			=> c_add40,
						sum			=> sum40,
						carry		=> carry40
						);
						
	HA42 : half_adder 
			port map 	(
						a			=> P0(3),
						b			=> P1(1),
						s			=> sum42,
						c_out		=> carry42
						);
						
	HA43 : half_adder 
			port map 	(
						a			=> P0(2),
						b			=> P1(0),
						s			=> sum43,
						c_out		=> carry43
						);
						
---------------------------------Layer6---------------------------------------------

	
	a_add44 <= '0'  & sum40 & sum42 & sum43 & P0(1) & P0(0);
	b_add44 <=  carry40 & carry42 & carry43 & s1 & '0' & s0;

	add44: adder 
			generic map ( N 		=> 49 )
			port map	(
						a			=> a_add44,
						b 			=> b_add44,
						sum 		=> sum44
						);
						
	P <= sum44(47 downto 0);
	
end architecture structure;
