library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myLatchD is
    Port ( ena : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end myLatchD;

architecture Behavioral of myLatchD is
begin

    process (ena, d)
    begin
        if (ena = '1') then
            q <= d;
        end if;
    end process;

end Behavioral;
