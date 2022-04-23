----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 04:20:58 PM
-- Design Name: 
-- Module Name: myDiv8_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myDiv8_tb is
--  Port ( );
end myDiv8_tb;

architecture Behavioral of myDiv8_tb is


component myDiv8 is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
           div : in STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC_VECTOR (7 downto 0));
end component;

    signal entrada : STD_LOGIC_VECTOR (7 downto 0);
    signal div : STD_LOGIC_VECTOR (1 downto 0);
    signal salida : STD_LOGIC_VECTOR (7 downto 0);

begin


uut: myDiv8 PORT MAP (
      entrada => entrada,          
      div => div,
      salida => salida
    );

stim_proc: process
begin
		
	entrada <= X"01"; div <= "00";    wait for 100 ns;
	entrada <= X"01"; div <= "01";    wait for 100 ns;
	entrada <= X"01"; div <= "10";    wait for 100 ns;
	entrada <= X"01"; div <= "11";    wait for 100 ns;
	
	entrada <= X"81"; div <= "00";    wait for 100 ns;
	entrada <= X"81"; div <= "01";    wait for 100 ns;
	entrada <= X"81"; div <= "10";    wait for 100 ns;
	entrada <= X"81"; div <= "11";    wait for 100 ns;
    
    wait;
end process;


end Behavioral;
