library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity myDetector_tb is
--  Port ( );
end myDetector_tb;

architecture Behavioral of myDetector_tb is
    
    signal clk : STD_LOGIC := '1';
    signal rst : STD_LOGIC;
    signal d : STD_LOGIC;
    signal sync : STD_LOGIC := '1';
    signal q : STD_LOGIC;

begin

    instA:  entity work.myDetector
            port map(clk => clk, rst => rst, d => d, sync => sync, q => q);
    
    clock: process
    begin
        clk <= not clk; wait for 5ns;
    end process;
    
    syncro: process
    begin
        sync <= not sync; wait for 10ns;
    end process;
    
    input: process
    begin
        rst <= '1'; wait for 5ns;
        rst <= '0'; d <= '1'; wait for 20ns;
        d <= '1'; wait for 20ns;
        d <= '0'; wait for 20ns;
        d <= '1'; wait for 20ns;
        d <= '0'; wait for 20ns;
        d <= '1'; wait for 20ns;
        d <= '1'; wait for 20ns;
        d <= '0'; wait for 20ns;
        d <= '1'; wait for 20ns;
        d <= '0'; wait for 20ns;
        d <= '1'; wait for 20ns; 
        wait;
    end process;

end Behavioral;