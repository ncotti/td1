library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           ci : in STD_LOGIC;
           s : out STD_LOGIC;
           co : out STD_LOGIC);
end fa;

architecture Behavioral of fa is

begin
    s <= a xor b xor ci;
    co <= (a and b) or (b and ci) or (a and ci);

end Behavioral;
