library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myAnd2 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           y : out STD_LOGIC);
end myAnd2;

architecture Behavioral of myAnd2 is

begin
    y <= a and b;
  
end Behavioral;
