library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RMUX is
    Port ( A_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           B_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           PC_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           DIN : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL_MUX : in  STD_LOGIC_VECTOR (1 downto 0);
           M_DOUT : out  STD_LOGIC_VECTOR (3 downto 0));
end RMUX;

architecture Behavioral of RMUX is
begin
	process(SEL_MUX,A_DOUT,B_DOUT,PC_DOUT,DIN)
	begin
		case SEL_MUX is
			when "00" => M_DOUT <= A_DOUT;
			when "01" => M_DOUT <= B_DOUT;
			when "10" => M_DOUT <= PC_DOUT;
			when "11" => M_DOUT <= DIN;
			when others => M_DOUT <= "UUUU";
		end case;
	end process;
end Behavioral;

