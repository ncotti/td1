library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco3a8Ena_tb is
--  Port ( );
end deco3a8Ena_tb;

architecture Behavioral of deco3a8Ena_tb is
component deco3a8Ena is
    Port ( w : in STD_LOGIC_VECTOR (2 downto 0);
           e : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

    signal we : STD_LOGIC_VECTOR (3 downto 0);
    signal w : STD_LOGIC_VECTOR (2 downto 0);    
    signal e : STD_LOGIC;
    signal y : STD_LOGIC_VECTOR (7 downto 0);
    

begin


-- Instancia del dispositivo a testear --
uut : deco3a8Ena port map (
        w => w,
        e => e,
        y => y
    );

    w <= we (2 downto 0);
    e <= we (3);

stim_proc: process
begin
		
	we <= "0000";	wait for 100 ns;
	we <= "0001";	wait for 100 ns;
	we <= "0010";	wait for 100 ns;
	we <= "0011";	wait for 100 ns;
	
	we <= "0100";	wait for 100 ns;
	we <= "0101";	wait for 100 ns;
	we <= "0110";	wait for 100 ns;
	we <= "0111";	wait for 100 ns;

	we <= "1000";	wait for 100 ns;
	we <= "1001";	wait for 100 ns;
	we <= "1010";	wait for 100 ns;
	we <= "1011";	wait for 100 ns;
	
	we <= "1100";	wait for 100 ns;
	we <= "1101";	wait for 100 ns;
	we <= "1110";	wait for 100 ns;
	we <= "1111";	wait for 100 ns;

    wait;
end process;


end Behavioral;
