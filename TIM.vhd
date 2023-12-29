library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MP_PACK.ALL;

entity TIM is
    Port ( NEXT_FETCH : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           MEM_R_W : in  STD_LOGIC;
           HALT : in  STD_LOGIC;
           LD_PC : out  STD_LOGIC;
           P_D : out  STD_LOGIC;
           RDBAR : out  STD_LOGIC;
           WRBAR : out  STD_LOGIC;
           INC_PC : out  STD_LOGIC;
           LD_IR : out  STD_LOGIC;
           MC_STATES : out  MACHINE_STATES;
           LD_STATES : out  STD_LOGIC);
end TIM;

architecture Behavioral of TIM is
type TIM_STATES is (init, FET_T1, FET_T2, FET_T3, FET_T4, FET2_T1, FET2_T2, FET2_T3, FET2_T4, MEM_T1, MEM_T2, MEM_T3, MEM_T4, haltd);
signal STATE : TIM_STATES := init;

begin
	process begin
		wait on RESET , CLK;
		if RESET = '0' then
			LD_PC			<= 'U';
			P_D			<= 'U';
			RDBAR			<= 'U';
			WRBAR			<= 'U';
			INC_PC		<= 'U';
			LD_IR			<= 'U';
			LD_STATES	<= 'U';
			MC_STATES	<= S0;
			
			STATE 		<= init;
		
		elsif RESET'EVENT then
			LD_PC			<= '0';
			P_D			<= '1';
			RDBAR			<= '1';
			WRBAR			<= '1';
			INC_PC		<= '0';
			LD_IR			<= '0';
			LD_STATES	<= '0';
			MC_STATES	<= S0;
			
			STATE 		<= init;
		
		elsif CLK'EVENT and CLK = '1' then
			case STATE is
				when init =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S1;
					
					STATE			<= FET_T1;
				
				when FET_T1 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S1;
					
					STATE			<= FET_T2;
				
				when FET_T2 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '0';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '1';
					LD_STATES	<= '0';
					MC_STATES	<= S1;
					
					STATE 		<= FET_T3;
			
				when FET_T3 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '1';
					LD_IR			<= '0';
					LD_STATES	<= '1';
					MC_STATES	<= S1;
					
					STATE 		<= FET_T4;
				
				when FET_T4 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S1;
					
					if HALT = '1' then
						STATE 		<= haltd;
					elsif NEXT_FETCH = '1' then
						STATE 		<= FET2_T1;
					else
						STATE			<= FET_T1;
					end if;
				
				when FET2_T1 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S2;
					
					STATE 		<= FET2_T2;
				
				when FET2_T2 =>
					LD_PC			<= '1';
					P_D			<= '1';
					RDBAR			<= '0';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S2;
					
					STATE 		<= FET2_T3;
				
				when FET2_T3 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '1';
					LD_IR			<= '0';
					LD_STATES	<= '1';
					MC_STATES	<= S2;
					
					STATE 		<= FET2_T4;
				
				when FET2_T4 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S2;
					
					STATE 		<= MEM_T1;
				
				when MEM_T1 =>
					LD_PC			<= '0';
					P_D			<= '1';
					RDBAR			<= '1';
					WRBAR			<= '1';
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S3;
					
					STATE 		<= MEM_T2;
				
				when MEM_T2 =>
					LD_PC			<= '0';
					P_D			<= '0';
					if MEM_R_W = '0' then
						RDBAR			<= '0';
						WRBAR			<= '1';
					else
						RDBAR			<= '1';
						WRBAR			<= '0';
					end if;
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S3;
					
					STATE 		<= MEM_T3;
				
				when MEM_T3 =>
					LD_PC			<= '0';
					P_D			<= '0';
					if MEM_R_W = '0' then
						RDBAR			<= '0';
						WRBAR			<= '1';
					else
						RDBAR			<= '1';
						WRBAR			<= '0';
					end if;
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '1';
					MC_STATES	<= S3;
					
					STATE 		<= MEM_T4;
				
				when MEM_T4 =>
					LD_PC			<= '0';
					P_D			<= '0';
					if MEM_R_W = '0' then
						RDBAR			<= '0';
						WRBAR			<= '1';
					else
						RDBAR			<= '1';
						WRBAR			<= '0';
					end if;
					INC_PC		<= '0';
					LD_IR			<= '0';
					LD_STATES	<= '0';
					MC_STATES	<= S3;
					
					STATE 		<= FET_T1;
				
				when haltd =>
					MC_STATES    <= S0;
					report "I: uP Halted";
				
			end case;
		end if;
	end process;

end Behavioral;

