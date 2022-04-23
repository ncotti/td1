library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCmp_tb is
    Generic (N: integer := 4);
--  Port ( );
end myCmp_tb;

architecture Behavioral of myCmp_tb is
component myCmp is
        Generic (N: integer := 4);
        Port ( a: in std_logic_vector (N-1 downto 0);
               b: in std_logic_vector (N-1 downto 0);
               c: in std_logic_vector (N-1 downto 0);
               mayor: out std_logic_vector (N-1 downto 0);
               medio: out std_logic_vector (N-1 downto 0);
               menor: out std_logic_vector (N-1 downto 0));
end component;

    signal a, b, c: std_logic_vector (N-1 downto 0);
    signal mayor, medio, menor : std_logic_vector (N-1 downto 0);
begin
uut : myCmp 
        Generic map (N => 4)
        Port map( a => a,
                  b => b,
                  c => c,
                  mayor => mayor,
                  medio => medio,
                  menor => menor);

stim_proc: process
begin
	report "a,b,c" severity note;
	a <= X"7"; b <= X"6"; c <= X"5";   wait for 100 ns;
	report "a,c,b" severity note;
	a <= X"7"; b <= X"5"; c <= X"6";   wait for 100 ns;

	report "b,c,a" severity note;
	a <= X"5"; b <= X"7"; c <= X"6";   wait for 100 ns;
	report "b,a,c" severity note;
	a <= X"6"; b <= X"7"; c <= X"5";   wait for 100 ns;

	report "c,a,b" severity note;
	a <= X"6"; b <= X"5"; c <= X"7";   wait for 100 ns;
	report "c,b,a" severity note;
	a <= X"5"; b <= X"6"; c <= X"7";   wait for 100 ns;
	
	a <= X"0"; b <= X"0"; c <= X"0";   wait for 100 ns;
    report "Fin de la simulacion" severity note;    
    wait;
end process;

    
end Behavioral;
