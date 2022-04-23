library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coder8a3_tb is
--  Port ( );
end coder8a3_tb;

architecture Behavioral of coder8a3_tb is

component coder8a3 is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

    signal y : STD_LOGIC_VECTOR (2 downto 0);
    signal w : STD_LOGIC_VECTOR (7 downto 0);

begin


-- Instancia del dispositivo a testear --
uut : coder8a3 port map (
        w => w,
        y => y
    );

stim_proc: process
begin

	w <= X"01";	wait for 100 ns;
	w <= X"02";	wait for 100 ns;
	w <= X"04";	wait for 100 ns;
	w <= X"08";	wait for 100 ns;

	w <= X"10";	wait for 100 ns;
	w <= X"20";	wait for 100 ns;
	w <= X"40";	wait for 100 ns;
	w <= X"80";	wait for 100 ns;

	w <= X"00";	wait for 100 ns;
    wait;
end process;

end Behavioral;
