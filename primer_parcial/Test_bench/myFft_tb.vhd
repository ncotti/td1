----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/17/2021 11:28:50 PM
-- Design Name: 
-- Module Name: myFft_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFft_tb is
--  Port ( );
end myFft_tb;

architecture Behavioral of myFft_tb is

component myFft is
Port ( t: in std_logic;
       ena: in std_logic;
       rst: in std_logic;
       clk: in std_logic;
       q: out std_logic);
end component;

signal t, ena, rst: std_logic;
signal q: std_logic;
    
    signal clk: std_logic;
    constant clk_period : time := 10 ns;

begin

uut: myFft 
Port map ( t => t,
           ena => ena,
           rst => rst,
           clk => clk,
           q => q);

-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 50 ns;
    rst <= '0';     wait;
end process;

-- Ena process --
enaProc :process
begin  
    ena <= '0'; t <= '0';
    wait until falling_edge (rst);
    wait until rising_edge (clk);         
    ena <= '0'; t <= '1';     wait for 10 ns;
    ena <= '1'; t <= '0';     wait for 100 ns;
    ena <= '1'; t <= '1';     wait for 100 ns;
    ena <= '1'; t <= '0';
    wait;
    
end process;



end Behavioral;
