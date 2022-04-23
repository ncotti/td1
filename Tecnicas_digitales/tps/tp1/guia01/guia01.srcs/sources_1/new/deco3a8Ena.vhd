library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco3a8Ena is
    Port ( w : in STD_LOGIC_VECTOR (2 downto 0);
           e : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end deco3a8Ena;

architecture Behavioral of deco3a8Ena is

begin
    with (e & w) select
        y <= "00000001" when "1000",
             "00000010" when "1001",
             "00000100" when "1010",
             "00001000" when "1011",
             "00010000" when "1100",
             "00100000" when "1101",
             "01000000" when "1110",
             "10000000" when "1111",
             "00000000" when others;
end Behavioral;

