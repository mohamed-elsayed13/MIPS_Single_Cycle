--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Decaration
Entity PC Is
port(
clk   : in STD_LOGIC;
reset : in STD_LOGIC;
input : In STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0):= (others => '0')
);
end PC;

--Architecture Decaration
architecture Behavioral of PC Is
begin
	-- process(clk)
	-- begin
		-- if rising_edge(clk) then
			-- OUTPUT<=input;
		-- end if;
	-- end process;
	process(clk, reset)
	begin
		if reset = '1' then
			OUTPUT <= (others => '0'); -- Force to zero on reset
		elsif rising_edge(clk) then
			OUTPUT <= input; -- Update on clock edge
		end if;
	end process;

end Behavioral;