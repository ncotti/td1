library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coder8a3eg is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           e : in STD_LOGIC;
           gs : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (2 downto 0));
end coder8a3eg;

architecture Behavioral of coder8a3eg is

begin
    y <= "000" when (e = '0') else --If the enable is off, i will return "000"
         "111" when (w(7) = '1') else
         "110" when (w(6) = '1') else
         "101" when (w(5) = '1') else
         "100" when (w(4) = '1') else
         "011" when (w(3) = '1') else
         "010" when (w(2) = '1') else
         "001" when (w(1) = '1') else
         "000";
  
  --For the group, it will be zero if the enable is zero or there are no high pins.
    gs <= '0' when ((w = x"00") or (e = '0')) else
          '1';   
         
end Behavioral;
