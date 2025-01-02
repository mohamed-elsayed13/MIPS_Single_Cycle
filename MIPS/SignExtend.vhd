--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Decaration
Entity SignExtend Is
port(
input : In STD_LOGIC_VECTOR (15 downto 0);
OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0)
);
end SignExtend;

--Architecture Decaration
architecture Behavioral of SignExtend Is
begin
OUTPUT(15 downto 0)<=input;
OUTPUT(31 downto 16)<=(31 downto 16=> input(15));
end Behavioral;