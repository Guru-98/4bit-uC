library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           B_DOUT : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL_OPER : in  STD_LOGIC_VECTOR (1 downto 0);
           Y_DOUT : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is begin
	
	process (SEL_OPER, A_DOUT, B_DOUT) begin
		
		case SEL_OPER is
			when "00" => Y_DOUT <= A_DOUT + B_DOUT;
			when "01" => Y_DOUT <= A_DOUT - B_DOUT;
			when "10" => Y_DOUT <= A_DOUT and B_DOUT;
			when "11" => Y_DOUT <= A_DOUT or B_DOUT;
			when others => Y_DOUT <= "ZZZZ";
		end case;
		
	end process;
end Behavioral;

