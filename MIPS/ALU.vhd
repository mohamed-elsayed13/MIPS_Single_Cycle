--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--use IEEE.NUMERIC_STD.all;

--Entity Decaration
Entity ALU Is
port(
A      : In STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
B 	   : In STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
CONTROL: In STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
RESULT : Out STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
ZERO   : OUT STD_LOGIC
);
end ALU;

--Architecture Decaration
architecture Behavioral of ALU Is
begin
process(A,B,CONTROL)
begin
	if    CONTROL = "0000" then RESULT <= A and B;
	elsif CONTROL = "0001" then RESULT <= A or B;
	elsif CONTROL = "0010" then RESULT <= A + B;
	elsif CONTROL = "0110" then RESULT <= A - B;
	elsif CONTROL = "0111" then 
		if A < B then RESULT <= X"00000001";
		else RESULT <= X"00000000";
		end if;
	elsif CONTROL = "1100" then RESULT <= A nor B;	
	end if;
	
	if A = B then ZERO <= '1';
	else ZERO <= '0';
	end if;
end process;
end Behavioral;