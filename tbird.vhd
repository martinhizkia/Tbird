library ieee;
use ieee.std_logic_1164.all;

entity tbird is
	port(
		rts	: in bit;
		lts	: in bit;
		haz	: in bit;
		clk		: in bit;
		lc,lb,la,ra,rb,rc : OUT bit);
end entity tbird;

architecture kiri_kanan of tbird is
	TYPE state_type IS (idle,l1,l2,l3,r1,r2,r3,lr3);
	SIGNAL state,next_state : state_type;
begin

first : process(clk) begin
		if(clk = '1' and clk'event) then
			state <= next_state;
		end if;
end process first;

PROCESS (state,rts,lts,haz) BEGIN 
CASE state IS 
	WHEN idle => IF (haz='1' OR (lts='1' AND rts='1')) THEN next_state <= lr3; 
						ELSIF (haz='0' AND lts='0' AND rts='1') THEN next_state <= r1; 
						ELSIF (haz='0' AND lts='1' AND rts='0') THEN next_state <= l1; 
						ELSE next_state <= idle; 
					END IF; 
					WHEN l1 => IF (haz='1') THEN next_state <= lr3; 
									ELSE next_state <= l2; 
								END IF; 
					WHEN l2 => IF (haz='1') THEN next_state <= lr3; ELSE next_state <= l3; 
									END IF; 
					WHEN l3 => next_state <= idle; 
					WHEN r1 => IF (haz='1') THEN next_state <= lr3; 
									ELSE next_state <= r2; 
									END IF; 
					WHEN r2 => IF (haz='1') THEN next_state <= lr3; 
									ELSE next_state <= r3; 
									END IF; 
					WHEN r3 => next_state <= idle; WHEN lr3 => next_state <= idle; 
	END CASE; 
END PROCESS;
	
third:	PROCESS (state) BEGIN 
	CASE state IS 
	WHEN idle => lc<='0'; lb<='0'; la<='0'; ra<='0'; rb<='0'; rc<='0'; 
	WHEN l1 => lc<='0'; lb<='0'; la<='1'; ra<='0'; rb<='0'; rc<='0';
	WHEN l2 => lc<='0'; lb<='1'; la<='1'; ra<='0'; rb<='0'; rc<='0';
	WHEN l3 => lc<='1'; lb<='1'; la<='1'; ra<='0'; rb<='0'; rc<='0'; 
	WHEN r1 => lc<='0'; lb<='0'; la<='0'; ra<='1'; rb<='0'; rc<='0'; 
	WHEN r2 => lc<='0'; lb<='0'; la<='0'; ra<='1'; rb<='1'; rc<='0'; 
	WHEN r3 => lc<='0'; lb<='0'; la<='0'; ra<='1'; rb<='1'; rc<='1'; 
	WHEN lr3 => lc<='1'; lb<='1'; la<='1'; ra<='1'; rb<='1'; rc<='1'; 
	END CASE; 
END PROCESS;
end kiri_kanan;