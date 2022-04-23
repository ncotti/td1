library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conversorBinarioGray_tb is
    generic (N: integer := 4);
--  Port ( );
end conversorBinarioGray_tb;

architecture Behavioral of conversorBinarioGray_tb is

component conversorBinarioGray is
    generic (N: integer := 4);
    Port ( entrada : in STD_LOGIC_VECTOR (N - 1 downto 0);
           salida : out STD_LOGIC_VECTOR (N - 1 downto 0);
           sel : in STD_LOGIC);
end component;

    signal entrada : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal salida : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal sel : STD_LOGIC := '0';
begin

uut: conversorBinarioGray 
generic map (N => N)
PORT MAP (              
    entrada => entrada,
    salida => salida,
    sel => sel
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
    
    sel <= not (sel);
    --wait;
end process;


end Behavioral;
