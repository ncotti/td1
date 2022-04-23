library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity myGenCnt_tb is
--  Port ( );
end myGenCnt_tb;

architecture Behavioral of myGenCnt_tb is
    
    signal clk : STD_LOGIC;
    signal rst : STD_LOGIC;
    signal q : STD_LOGIC_VECTOR (2 downto 0);

begin

    instA:  entity work.myGenCnt
            port map(clk => clk, rst => rst, q => q);
    
    clock: process
    begin
        clk <= '0'; wait for 5ns;
        clk <= not clk; wait for 5ns;
    end process;
    
    input: process
    begin
        rst <= '1'; wait for 15ns;
        rst <= '0'; wait for 500ns;
        rst <= '1'; wait for 20ns;
        rst <= '0'; wait;
    end process;

end Behavioral;