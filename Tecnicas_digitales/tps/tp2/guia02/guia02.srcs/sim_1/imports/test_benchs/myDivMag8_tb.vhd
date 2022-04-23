library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myDivMag8_tb is
--  Port ( );
end myDivMag8_tb;

architecture Behavioral of myDivMag8_tb is

component myDivMag8 is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
           div : in STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC_VECTOR (7 downto 0));
end component;

    signal entrada : STD_LOGIC_VECTOR (7 downto 0);
    signal div : STD_LOGIC_VECTOR (1 downto 0);
    signal salida : STD_LOGIC_VECTOR (7 downto 0);

begin


uut: myDivMag8 PORT MAP (
      entrada => entrada,          
      div => div,
      salida => salida
    );

stim_proc: process
begin
		
	entrada <= X"01"; div <= "00";    wait for 100 ns;
	entrada <= X"01"; div <= "01";    wait for 100 ns;
	entrada <= X"01"; div <= "10";    wait for 100 ns;
	entrada <= X"01"; div <= "11";    wait for 100 ns;
	
	entrada <= X"81"; div <= "00";    wait for 100 ns;
	entrada <= X"81"; div <= "01";    wait for 100 ns;
	entrada <= X"81"; div <= "10";    wait for 100 ns;
	entrada <= X"81"; div <= "11";    wait for 100 ns;
    
    wait;
end process;


end Behavioral;
