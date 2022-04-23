library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myLatchD_Clr is
    Port ( ena : in STD_LOGIC;
           clr : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end myLatchD_Clr;

architecture Behavioral of myLatchD_Clr is

begin

    process (ena, clr, d)
    begin
        if (clr = '1') then
            q <= '0';
        elsif (ena = '1') then
            q <= d;
        end if;
         
    end process;

end Behavioral;
