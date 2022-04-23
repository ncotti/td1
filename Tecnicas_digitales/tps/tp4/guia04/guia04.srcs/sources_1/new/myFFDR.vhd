library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDR is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end myFFDR;

architecture Behavioral of myFFDR is

begin
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                q <= '0';
            else
                q <= d;            
            end if;
        end if;
    end process;


end Behavioral;
