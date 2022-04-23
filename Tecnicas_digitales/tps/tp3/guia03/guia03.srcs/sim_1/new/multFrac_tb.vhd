library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multFrac_tb is
    Generic (N: integer := 6);
end multFrac_tb;

architecture Behavioral of multFrac_tb is
    signal entrada: std_logic_vector (N-2 downto 0);
    signal salida: std_logic_vector (N-1 downto 0);

begin

    tester: entity work.multFrac
            generic map (N => N)
            port map (entrada => entrada, salida => salida);
            
    test: process
        variable var: signed(N-2 downto 0) := (N-2 => '1', others => '0');
        variable max: signed(N-2 downto 0) := (N-2 => '0', others => '1');
    begin
        while (var /= max) loop
            entrada <= std_logic_vector(var); wait for (100 ns);
            var := var + 1;
        end loop;
        entrada <= std_logic_vector(max); wait for (100 ns);
        wait;
    end process;
                 
        
    
end Behavioral;
