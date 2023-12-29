library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    Port ( ADR_IN : in  STD_LOGIC_VECTOR (3 downto 0);
           CS_BAR : in  STD_LOGIC;
           WR_BAR : in  STD_LOGIC;
           RD_BAR : in  STD_LOGIC;
           D : inout  STD_LOGIC_VECTOR (3 downto 0));
end RAM;

architecture Behavioral of RAM is
	type RAM_ARRAY is array(0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
	signal RAM_DATA: RAM_ARRAY := (0 => "0001",1 => "0001", others => "0000");

begin
	process( CS_BAR , RAM_DATA, WR_BAR, RD_BAR) begin		
			if CS_BAR = '0' then
					if WR_BAR = '0' then
						RAM_DATA(conv_integer(ADR_IN)) <= D;
					end if;
					
					if RD_BAR ='0' then
						D <= RAM_DATA(conv_integer(ADR_IN));
					end if;
			else
					D <= "ZZZZ";
			end if;
			
	end process;
	
end Behavioral;

