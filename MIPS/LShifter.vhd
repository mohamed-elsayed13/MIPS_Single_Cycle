--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Decaration
Entity LShifter Is
port(
input : In STD_LOGIC_VECTOR (31 downto 0);
OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0)
);
end LShifter;

--Architecture Decaration
architecture Behavioral of LShifter Is
begin
OUTPUT<=input(29 downto 0)&"00";
-- OUTPUT(1 downto 0)<="00";
end Behavioral;