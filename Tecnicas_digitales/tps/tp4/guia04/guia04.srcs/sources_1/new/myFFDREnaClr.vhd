library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDREnaClr is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           clr : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end myFFDREnaClr;

architecture Behavioral of myFFDREnaClr is

begin

    process (clk, clr)
    begin
        if( clr = '1') then
            q <= '0';
        elsif( rising_edge(clk)) then
            if (rst = '1') then
                q <= '0';
            elsif( ena = '1') then
                q <= d;
            end if;
        end if;
    end process;


end Behavioral;
