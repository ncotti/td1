library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myMux4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           c : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);
end myMux4;

architecture Behavioral of myMux4 is

begin
    y <= a(0) when (c = "00") else
         a(1) when (c = "01") else
         a(2) when (c = "10") else
         a(3) when (c = "11") else
         '0';

end Behavioral;
