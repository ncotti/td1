library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myDeco7Seg_tb is
--  Port ( );
end myDeco7Seg_tb;

architecture Behavioral of myDeco7Seg_tb is

component myDeco7Seg is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           a, b, c, d, e, f, g : out STD_LOGIC);
end component;

    signal entrada : STD_LOGIC_VECTOR (3 downto 0);
    signal a, b, c, d, e, f, g : STD_LOGIC;

begin

   uut: myDeco7Seg PORT MAP (
          entrada => entrada,
          a => a,                    
          b => b,
          c => c,
          d => d,
          e => e,
          f => f,          
          g => g
        );

stim_proc: process
begin
		
	entrada <= "0000";	wait for 100 ns;
	entrada <= "0001";	wait for 100 ns;
	entrada <= "0010";	wait for 100 ns;
	entrada <= "0011";	wait for 100 ns;
	
	entrada <= "0100";	wait for 100 ns;
	entrada <= "0101";	wait for 100 ns;
	entrada <= "0110";	wait for 100 ns;
	entrada <= "0111";	wait for 100 ns;

	entrada <= "1000";	wait for 100 ns;
	entrada <= "1001";	wait for 100 ns;
	entrada <= "1010";	wait for 100 ns;
	entrada <= "1011";	wait for 100 ns;
	
	entrada <= "1100";	wait for 100 ns;
	entrada <= "1101";	wait for 100 ns;
	entrada <= "1110";	wait for 100 ns;
	entrada <= "1111";	wait for 100 ns;

    wait;
end process;

end Behavioral;
