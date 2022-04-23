library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCalc_tb is
    Generic (N: integer := 4);
end myCalc_tb;

architecture Behavioral of myCalc_tb is

    signal d: STD_LOGIC_VECTOR(N-1 downto 0);
    signal r: STD_LOGIC_VECTOR(N downto 0);

begin
    
    instA:  entity work.myCalc
            generic map (N => N)
            port map (d => d, r => r);
            
    process
        variable cont: signed(N-1 downto 0) := (N-1 => '1', others => '0');
    begin
        d <= std_logic_vector(cont); 
        cont := cont + 1;
        wait for 100ns;
    end process;

end Behavioral;
