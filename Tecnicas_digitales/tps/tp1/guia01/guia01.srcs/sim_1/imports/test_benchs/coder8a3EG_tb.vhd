library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coder8a3EG_tb is
--  Port ( );
end coder8a3EG_tb;

architecture Behavioral of coder8a3EG_tb is

component coder8a3EG is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           e : in STD_LOGIC;
           gs : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

    signal w : STD_LOGIC_VECTOR (7 downto 0);
    signal e : STD_LOGIC;
    signal gs : STD_LOGIC;
    signal y : STD_LOGIC_VECTOR (2 downto 0);

begin

uut : coder8a3EG port map (
        w => w,
        e => e,
        gs => gs,
        y => y
    );
    
stim_proc: process
begin
		
	e <= '0';  w <= X"00";	wait for 100 ns;
	e <= '0';  w <= X"01";	wait for 100 ns;
	e <= '0';  w <= X"80";	wait for 100 ns;
	e <= '0';  w <= X"61";	wait for 100 ns;
	
    e <= '1';  w <= X"00";	wait for 100 ns;
	e <= '1';  w <= X"01";	wait for 100 ns;
	e <= '1';  w <= X"80";	wait for 100 ns;
	e <= '1';  w <= X"61";	wait for 100 ns;

    wait;
end process;

end Behavioral;
