library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntMoore_tb is
--  Port ( );
end myCntMoore_tb;

architecture Behavioral of myCntMoore_tb is
    constant PERIOD : time := 10ns;

    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal ena: std_logic;
    signal salida: std_logic_vector (2 downto 0);

begin

edge : entity work.myCntMoore
       port map (clk => clk, rst => rst, ena => ena, salida => salida);
   
clk_proc : process
begin
    wait for PERIOD/2;
    clk <= not clk;
end process;      

stimulus : process
begin
    rst <= '1'; 
    ena <= '0'; wait for 10ns;
    rst <= '0'; wait until falling_edge(clk);
    ena <= '1'; wait until falling_edge(clk);
    ena <= '0'; wait until falling_edge(clk); wait until falling_edge(clk);
    ena <= '1'; wait until falling_edge(clk);
    ena <= '0'; wait until falling_edge(clk);
    ena <= '1';

    wait;
end process;
end Behavioral;
