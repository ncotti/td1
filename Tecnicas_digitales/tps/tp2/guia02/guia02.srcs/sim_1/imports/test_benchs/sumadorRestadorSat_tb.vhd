----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 03:55:26 PM
-- Design Name: 
-- Module Name: sumadorRestadorSat_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity sumadorRestadorSat_tb is
Generic (N: integer := 4);
end sumadorRestadorSat_tb;

architecture Behavioral of sumadorRestadorSat_tb is


component sumadorRestadorSat is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           b : in STD_LOGIC_VECTOR (N - 1 downto 0);
           s_r : in STD_LOGIC;
           ov : out STD_LOGIC;
           resultado : out STD_LOGIC_VECTOR (N - 1 downto 0));
end component;

    signal a : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal b : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal s_r : STD_LOGIC;
    signal ov : STD_LOGIC;
    signal resultado : STD_LOGIC_VECTOR (N - 1 downto 0);

begin

uut: sumadorRestadorSat PORT MAP (
      a => a,          
      b => b,
      s_r => s_r,
      ov => ov,
      resultado => resultado
    );

stim_proc: process
begin
	
	-- SUMA --
	b <= X"1"; a <= X"1"; s_r <='1';    wait for 100 ns; -- 1 + 1
	b <= X"7"; a <= X"1"; s_r <='1';    wait for 100 ns; -- 7 + 1 (overflow)
	b <= X"7"; a <= X"F"; s_r <='1';    wait for 100 ns; -- 7 + - 1
    
    -- Resta --
	b <= X"F"; a <= X"F"; s_r <='0';    wait for 100 ns; -- -1 - -1
	b <= X"8"; a <= X"F"; s_r <='0';    wait for 100 ns; -- -8 - -1 
	b <= X"8"; a <= X"1"; s_r <='0';    wait for 100 ns; -- -8 - 1 (overflow)
    wait;
    
end process;

end Behavioral;
