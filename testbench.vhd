LIBRARY IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end entity testbench;

architecture tester of testbench is 
component tbird is
	port(
		rts		: in bit;
		lts		: in bit;
		haz		: in bit;
		clk		: in bit;
		lc,lb,la,ra,rb,rc : OUT bit);
end component;

signal kanan 	: bit_vector(1 to 32) := ('1','1','0','0','0','1','1','0','0','1','0','0','0','1','1','0','0','1','0','1','0','1','1','0','1','0','1','0','0','1','1','0');

signal kiri 	: bit_vector(1 to 32) := ('1','0','0','1','1','1','0','0','1','0','1','0','0','1','0','0','0','0','1','0','0','0','1','0','1','0','1','1','0','1','1','1');

signal hazard 	: bit_vector(1 to 32) := ('0','1','0','0','0','0','1','0','1','1','1','1','0','1','1','1','1','0','1','1','0','1','1','1','0','1','0','0','0','0','0','1');
signal rts, lts, haz,lc,lb,la,ra,rb,rc : bit;
signal clk : bit := '1';
constant td_clk : time := 10 ns;
for all	:tbird use entity work.tbird(kiri_kanan);

begin
portmaptbird : tbird port map(rts,lts,haz,clk,lc,lb,la,ra,rb,rc);
clk <= not clk after td_clk;
	
lampu 	:process
				begin
					wait for 1 ns;
						for i in 1 to 32 loop
							rts <= kanan(i);
							lts <= kiri(i);
							haz <= hazard(i);
					WAIT FOR 10 ns;
			END LOOP;
			WAIT FOR 10 ns;
			WAIT;
	end process lampu;
end tester;
	