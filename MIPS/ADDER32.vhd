--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
--Entity Decaration
Entity Adder32 Is
port(
input1 : In STD_LOGIC_VECTOR (31 downto 0);
input2 : In STD_LOGIC_VECTOR (31 downto 0);
Sum	   : OUT STD_LOGIC_VECTOR(31 downto 0)
);
end Adder32;

--Architecture Decaration
architecture Behavioral of Adder32 Is
begin
Sum <= input1 + input2;
end Behavioral;