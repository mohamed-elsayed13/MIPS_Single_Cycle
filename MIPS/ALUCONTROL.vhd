--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Decaration
Entity ALUControl Is
port(
Func : In STD_LOGIC_VECTOR(5 downto 0);
ALUOP : IN STD_LOGIC_VECTOR(1 downto 0);
ALUOPERATION : OUT STD_LOGIC_VECTOR(3 downto 0)
);
end ALUControl;

--Architecture Decaration
architecture Behavioral of ALUControl Is
begin
Process(Func,ALUOP)
begin
if ALUOP="00" then
ALUOPERATION<= "0010"; --  Add
elsif ALUOP="01" then
ALUOPERATION<= "0110"; -- subtract
elsif ALUOP="10" and Func="100000" then
ALUOPERATION<= "0010"; --  Add
elsif ALUOP="10" and Func="100010" then
ALUOPERATION<= "0110"; -- subtract
elsif ALUOP="10" and Func="100100" then
ALUOPERATION<= "0000"; --  AND
elsif ALUOP="10" and Func="100101" then
ALUOPERATION<= "0001"; --  OR
elsif ALUOP="10" and Func="101010" then
ALUOPERATION<= "0111"; --  Set on less than
else 
ALUOPERATION<="0000";
end if;
end process; 
end Behavioral;