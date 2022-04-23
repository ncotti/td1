library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity deco3a8_tb is
--  Port ( );
end deco3a8_tb;

architecture Behavioral of deco3a8_tb is

component deco3a8 is
    Port ( w : in STD_LOGIC_VECTOR (2 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

    signal w : STD_LOGIC_VECTOR (2 downto 0);
    signal y : STD_LOGIC_VECTOR (7 downto 0);

begin

-- Instancia del dispositivo a testear --
uut : deco3a8 port map (
        w => w,
        y => y
    );

stim_proc: process
begin
		
	w <= "000";	wait for 100 ns;
	w <= "001";	wait for 100 ns;
	w <= "010";	wait for 100 ns;
	w <= "011";	wait for 100 ns;
	
	w <= "100";	wait for 100 ns;
	w <= "101";	wait for 100 ns;
	w <= "110";	wait for 100 ns;
	w <= "111";	wait for 100 ns;

    wait;
end process;


end Behavioral;
