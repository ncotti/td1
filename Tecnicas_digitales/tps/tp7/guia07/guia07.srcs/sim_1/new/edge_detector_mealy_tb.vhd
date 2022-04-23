library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector_mealy_tb is
--  Port ( );
end edge_detector_mealy_tb;

architecture Behavioral of edge_detector_mealy_tb is
    constant PERIOD : time := 10ns;

    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal input: std_logic;
    signal output: std_logic;

begin

edge : entity work.edge_detector_mealy
       port map (clk => clk, rst => rst, input => input, output => output);
   
clk_proc : process
begin
    wait for PERIOD/2;
    clk <= not clk;
end process;      

stimulus : process
begin
    rst <= '1'; 
    input <= '0'; wait for 10ns;
    rst <= '0'; wait until falling_edge(clk);
    input <= '1'; wait for 20ns;
    input <= '0'; wait for 20ns;
    input <= '1'; wait for 20ns;
    input <= '0'; wait for 20ns;
    input <= '1'; wait for 20ns;
    input <= '0'; wait for 20ns;
    input <= '1'; wait for 20ns;
    wait;
end process;
end Behavioral;
