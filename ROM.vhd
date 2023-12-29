library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( CS : in  STD_LOGIC;
           RD_BAR : in  STD_LOGIC;
           ADR_IN : in  STD_LOGIC_VECTOR (3 downto 0);
           D : out  STD_LOGIC_VECTOR (3 downto 0));
end ROM;

architecture Behavioral of ROM is
	type ROM_ARRAY is array(0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
	signal ROM_DATA: ROM_ARRAY := (0 => "0101",
											 1 => "0000",
											 2 => "0100",
											 3 => "0001",
											 4 => "0000",
											 5 => "1000",
											 6 => "0001",
											 7 => "1111",
											 others => "1111");

begin
	process( CS , ROM_DATA, RD_BAR) begin		
		if CS = '1' then
			if RD_BAR='0' then
				D <= ROM_DATA(conv_integer(ADR_IN));
			end if;
		else
			D <= "ZZZZ";	
		end if;

	end process;

end Behavioral;

