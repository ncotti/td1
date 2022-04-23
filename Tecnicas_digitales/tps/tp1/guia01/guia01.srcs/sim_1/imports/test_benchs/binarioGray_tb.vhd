library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binarioGray_tb is
    generic (N: integer := 4);
--  Port ( );
end binarioGray_tb;

architecture Behavioral of binarioGray_tb is

component binarioGray is
   generic (N: integer := 4);
   Port ( binario : in STD_LOGIC_VECTOR (N - 1 downto 0);
          gray : out STD_LOGIC_VECTOR (N - 1 downto 0));
end component;

    signal gray : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal binario : STD_LOGIC_VECTOR (N - 1 downto 0);

begin

uut: binarioGray 
generic map (N => N)
PORT MAP (              
    binario => binario,
    gray => gray    
);

stim_proc: process
begin
		
	binario <= "0000";	wait for 100 ns;
	binario <= "0001";	wait for 100 ns;
	binario <= "0010";	wait for 100 ns;
	binario <= "0011";	wait for 100 ns;
		
	binario <= "0100";	wait for 100 ns;
	binario <= "0101";	wait for 100 ns;
	binario <= "0110";	wait for 100 ns;
	binario <= "0111";	wait for 100 ns;

	binario <= "1000";	wait for 100 ns;
	binario <= "1001";	wait for 100 ns;
	binario <= "1010";	wait for 100 ns;
	binario <= "1011";	wait for 100 ns;
		
    binario <= "1100";	wait for 100 ns;
	binario <= "1101";	wait for 100 ns;
	binario <= "1110";	wait for 100 ns;
	binario <= "1111";	wait for 100 ns;
    
    wait;
end process;


end Behavioral;
