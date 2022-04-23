----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.06.2021 18:14:33
-- Design Name: 
-- Module Name: signal_sample - Behavioral
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

entity signal_sample is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           e : in STD_LOGIC;
           f : in STD_LOGIC;
           y : out STD_LOGIC;
           w : out STD_LOGIC);
end signal_sample;

architecture Behavioral of signal_sample is

    signal cable : std_logic;

begin
    y <= (a and b) and c;
    
    cable <= d and e;
    w <= cable and f;

end Behavioral;
