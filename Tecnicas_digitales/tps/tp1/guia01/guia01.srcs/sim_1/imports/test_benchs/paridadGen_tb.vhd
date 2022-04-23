library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity paridadGen_tb is
    generic (N: integer := 4);
--  Port ( );
end paridadGen_tb;

architecture Behavioral of paridadGen_tb is

component paridadGen is
    generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           sel : in STD_LOGIC;
           p : out STD_LOGIC);
end component;

    signal a : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal sel : STD_LOGIC := '0';
    signal p : STD_LOGIC;

begin

uut: paridadGen 
generic map (N => N)
PORT MAP (
    a => a,          
    sel => sel,
    p => p
);

stim_proc: process
begin
		
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0011";	wait for 100 ns;
		
	a <= "0100";	wait for 100 ns;
	a <= "0101";	wait for 100 ns;
	a <= "0110";	wait for 100 ns;
	a <= "0111";	wait for 100 ns;

	a <= "1000";	wait for 100 ns;
	a <= "1001";	wait for 100 ns;
	a <= "1010";	wait for 100 ns;
	a <= "1011";	wait for 100 ns;
		
	a <= "1100";	wait for 100 ns;
	a <= "1101";	wait for 100 ns;
	a <= "1110";	wait for 100 ns;
	a <= "1111";	wait for 100 ns;

    sel <= not sel;
end process;

end Behavioral;
