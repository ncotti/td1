library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mySec_tb is
--  Port ( );
end mySec_tb;

architecture Behavioral of mySec_tb is
    constant PERIOD : time := 10ns;

    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal start: std_logic;
    signal salida: std_logic;

begin

edge : entity work.mySec
       port map (clk => clk, rst => rst, start => start, salida => salida);
   
clk_proc : process
begin
    wait for PERIOD/2;
    clk <= not clk;
end process;      

stimulus : process
begin
    rst <= '1'; 
    start <= '0'; wait for 10ns;
    rst <= '0'; wait until falling_edge(clk);
    start <= '1'; wait for 157ns;
    start <= '0'; wait for 30ns; wait until rising_edge(clk);
    start <= '1';
    wait;
end process;
end Behavioral;