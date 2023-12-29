library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TRIBUF is
    Port ( DIN : out  STD_LOGIC_VECTOR (3 downto 0);
           D : inout  STD_LOGIC_VECTOR (3 downto 0);
           M_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           WR_BAR : in  STD_LOGIC);
end TRIBUF;

architecture Behavioral of TRIBUF is begin
	DIN <= D;
	D <= M_DOUT when (WR_BAR = '0') else "ZZZZ";
end Behavioral;

