library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MP_PACK.ALL;

entity IDEC is
    Port ( DIN : in  STD_LOGIC_VECTOR (3 downto 0);
           RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           LD_IR : in  STD_LOGIC;
           LD_STATE : in  STD_LOGIC;
           MC_STATE : in  MACHINE_STATES; 
           SEL_MUX : out  STD_LOGIC_VECTOR (1 downto 0);
           CLR : out  STD_LOGIC;
           SEL : out  STD_LOGIC;
           HALT : out  STD_LOGIC;
           LD_A : out  STD_LOGIC;
           LD_B : out  STD_LOGIC;
           SAVE : out  STD_LOGIC;
           RESTORE : out  STD_LOGIC;
           SEL_OPER : out  STD_LOGIC_VECTOR (1 downto 0);
           MEM_R_W : out  STD_LOGIC;
           NEXT_FETCH : out  STD_LOGIC);
end IDEC;

architecture Behavioral of IDEC is
	signal IREG     : STD_LOGIC_VECTOR (3 downto 0) := "ZZZZ";
	signal ins_type : STD_LOGIC_VECTOR (1 downto 0) := "ZZ";
	signal operands : STD_LOGIC_VECTOR (1 downto 0) := "ZZ";
	
	signal int_state : MACHINE_STATES := S1;
begin
	process (RESET) begin
		if RESET = '0' then
			SEL_MUX		<= "UU";
			SEL_OPER 	<= "UU";
			CLR			<= 'U';
			SEL 			<= 'U';
			HALT 			<= 'U';
			LD_A 			<= 'U';
			LD_B 			<= 'U';
			SAVE 			<= 'U';
			RESTORE 		<= 'U';
			MEM_R_W 		<= 'U';
			NEXT_FETCH	<= 'U';
		elsif RESET'EVENT then
			SEL_MUX		<= "ZZ";
			SEL_OPER 	<= "ZZ";
			CLR			<= 'Z';
			SEL 			<= 'Z';
			HALT 			<= 'Z';
			LD_A 			<= 'Z';
			LD_B 			<= 'Z';
			SAVE 			<= 'Z';
			RESTORE 		<= 'Z';
			MEM_R_W 		<= 'Z';
			NEXT_FETCH	<= 'Z';
		end if;
end process;

process (LD_STATE)
begin
			if LD_STATE = '1' then
				int_state <= MC_STATE;
			end if;
end process;

process (LD_IR)
begin	
			if LD_IR = '1' then
				IREG <= DIN;
			end if;
end process;
		
process(IREG, int_state)
begin
			ins_type <= IREG (3 downto 2);
			operands <= IREG (1 downto 0);
			
			
			case int_state is
				when S0 => 
					report "In State 0";
					SEL_MUX		<= "UU";
					SEL_OPER 	<= "UU";
					CLR			<= 'U';
					SEL 			<= 'U';
					HALT 			<= 'U';
					LD_A 			<= 'U';
					LD_B 			<= 'U';
					SAVE 			<= 'U';
					RESTORE 		<= 'U';
					MEM_R_W 		<= 'U';
					NEXT_FETCH	<= 'U';
			
				when S1 =>
					report "In State 1";
					
					case ins_type is
						when "00" => --ARITH
							SEL_OPER		<= operands;
							SEL_MUX		<= "11"; -- SEL_DIN
							SEL 			<= '0';
							HALT			<= '0';
							LD_A 			<= '1';
							LD_B 			<= '0';
							SAVE 			<= '0';
							RESTORE 		<= '0';
							MEM_R_W 		<= '1';
							NEXT_FETCH	<= '0';
							
						
						when "11" => --R2R
							SEL_OPER		<= "ZZ";
							
							SAVE 			<= '0';
							RESTORE 		<= '0';
							NEXT_FETCH	<= '0';
							
							case operands is
								when "00" => --A2B 
									SEL_MUX		<= "00";
									LD_A 			<= '0';
									LD_B 			<= '1';
									MEM_R_W 		<= '1';
									SEL 			<= '1';
									HALT			<= '0';
								
								when "01" => --B2A 
									SEL_MUX		<= "01";
									LD_A 			<= '1';
									LD_B 			<= '0';
									MEM_R_W 		<= '1';
									SEL 			<= '0';
									HALT			<= '0';
								
								when others => -- Invalid operand
									SEL_MUX		<= "ZZ";
									LD_A 			<= 'Z';
									LD_B 			<= 'Z';
									MEM_R_W 		<= 'Z';
									SEL 			<= 'Z';
									HALT			<= 'Z';
							end case;
						
						when "01" => --M2R
							SEL_MUX		<= "ZZ";
							SEL_OPER 	<= "ZZ"; --TODO: check operation value
							
							SEL 			<= 'Z';
							HALT			<= '0';
							LD_A 			<= '0';
							LD_B 			<= '0';
							SAVE 			<= '0';
							RESTORE 		<= '0';
							MEM_R_W 		<= '1';
							NEXT_FETCH	<= '1';
						
						when "10" => --R2M
							SEL_MUX		<= "ZZ";
							SEL_OPER 	<= "ZZ"; --TODO: check operation value
							
							SEL 			<= 'Z';
							HALT			<= '0';
							LD_A 			<= '0';
							LD_B 			<= '0';
							SAVE 			<= '0';
							RESTORE 		<= '0';
							MEM_R_W 		<= '0';
							NEXT_FETCH	<= '1';
						
						when others => 
							report "invalid instruction type";
					end case;
			
				when S2 =>
					report "In State 2";
					
					case ins_type is 
						when "01" => --M2R
							case operands is
								when "00" | "01" => --M2A or M2B
									NEXT_FETCH <= '0';
									SAVE       <= '1';
									RESTORE    <= '0';
									SEL_MUX    <= "11"; --SEL_DIN
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '1';
								
								when others =>
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '0';
									SEL_MUX    <= "ZZ";
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '1';
							end case;
						
						when "10" => --R2M
							case operands is
								when "00" | "01" => --M2A or M2B
									NEXT_FETCH <= '0';
									SAVE       <= '1';
									RESTORE    <= '0';
									SEL_MUX    <= "11"; --SEL_DIN
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
								
								when others =>
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '0';
									SEL_MUX    <= "ZZ";
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
							end case;
						
						when others =>
							report "invalid instruction type";
					end case;
				
				when S3 => 
					report "In State 3";
					
					case ins_type is 
						when "01" => --M2R
							case operands is
								when "00" => --M2A
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '1';
									SEL_MUX    <= "11";
									SEL        <= '0';
									LD_A       <= '1';
									LD_B       <= '0';
									MEM_R_W    <= '1';
								
								when "01" => --M2B
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '1';
									SEL_MUX    <= "11";
									SEL        <= '1';
									LD_A       <= '0';
									LD_B       <= '1';
									MEM_R_W    <= '1';
								
								when others =>
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '0';
									SEL_MUX    <= "ZZ";
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
							end case;
						
						when "10" => --R2M
							case operands is
								when "00" => --A2M
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '1';
									SEL_MUX    <= "11";
									SEL        <= '0';
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
								
								when "01" => --B2M
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '1';
									SEL_MUX    <= "11";
									SEL        <= '1';
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
								
								when others =>
									NEXT_FETCH <= '0';
									SAVE       <= '0';
									RESTORE    <= '0';
									SEL_MUX    <= "ZZ";
									LD_A       <= '0';
									LD_B       <= '0';
									MEM_R_W    <= '0';
							end case;
						
						when others =>
							report "invalid instruction type";
					end case;

				
				when others =>
					report "invalid state";
			end case;
	end process;
		
end Behavioral;

