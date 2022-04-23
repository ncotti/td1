library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coder8a3 is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (2 downto 0));
end coder8a3;

architecture Behavioral of coder8a3 is

begin
    y <= "111" when (w(7) = '1') else
         "110" when (w(6) = '1') else
         "101" when (w(5) = '1') else
         "100" when (w(4) = '1') else
         "011" when (w(3) = '1') else
         "010" when (w(2) = '1') else
         "001" when (w(1) = '1') else
         "000";

end Behavioral;
