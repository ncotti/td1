library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntBinGray_tb is
--  Port ( );
end myCntBinGray_tb;

architecture Behavioral of myCntBinGray_tb is
    constant PERIOD : time := 10ns;

    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal c: std_logic;
    signal salida: std_logic_vector (2 downto 0);

begin

edge : entity work.myCntBinGray
       port map (clk => clk, rst => rst, c => c, salida => salida);
   
clk_proc : process
begin
    wait for PERIOD/2;
    clk <= not clk;
end process;      

stimulus : process
begin
    rst <= '1'; 
    c <= '0'; wait for 10ns;
    rst <= '0'; wait for 200ns;
    c <= '1';
    wait;
end process;
end Behavioral;