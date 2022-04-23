library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntGray2Bits_tb is
--  Port ( );
end myCntGray2Bits_tb;

architecture Behavioral of myCntGray2Bits_tb is
    constant PERIOD : time := 10ns;

    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal ena: std_logic;
    signal salida: std_logic_vector (1 downto 0);

begin

edge : entity work.myCntGray2Bits
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
    ena <= '1'; wait for 15ns;
    rst <= '1'; wait for 10ns; wait until falling_edge(clk);
    rst <= '0'; wait for 100ns;
    ena <= '0';

    wait;
end process;
end Behavioral;