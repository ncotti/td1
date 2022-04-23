library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity grayBinario_tb is
    generic (N: integer := 4);
--  Port ( );
end grayBinario_tb;

architecture Behavioral of grayBinario_tb is


component grayBinario is
    generic (N: integer := 4);
   Port ( gray : in STD_LOGIC_VECTOR (N - 1 downto 0);
           binario : out STD_LOGIC_VECTOR (N - 1 downto 0));
end component;

    signal gray : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal binario : STD_LOGIC_VECTOR (N - 1 downto 0);

begin

uut: grayBinario 
generic map (N => N)
PORT MAP (
    gray => gray,          
    binario => binario    
);

stim_proc: process
begin
		
	gray <= "0000";	wait for 100 ns;
	gray <= "0001";	wait for 100 ns;
	gray <= "0010";	wait for 100 ns;
	gray <= "0011";	wait for 100 ns;
		
	gray <= "0100";	wait for 100 ns;
	gray <= "0101";	wait for 100 ns;
	gray <= "0110";	wait for 100 ns;
	gray <= "0111";	wait for 100 ns;

	gray <= "1000";	wait for 100 ns;
	gray <= "1001";	wait for 100 ns;
	gray <= "1010";	wait for 100 ns;
	gray <= "1011";	wait for 100 ns;
		
    gray <= "1100";	wait for 100 ns;
	gray <= "1101";	wait for 100 ns;
	gray <= "1110";	wait for 100 ns;
	gray <= "1111";	wait for 100 ns;
    
    wait;
end process;

end Behavioral;
