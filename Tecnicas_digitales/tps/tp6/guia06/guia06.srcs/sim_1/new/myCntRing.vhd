library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntRing is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end myCntRing;

architecture Behavioral of myCntRing is
    
    signal s_q: std_logic_vector(N-1 downto 0);
begin

    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_q <= (  N-1     =>  '1',
                        others  =>  '0');
                
            elsif (ena = '1') then
                s_q <= s_q(N-2 downto 0) & s_q(N-1);
            end if;
        end if;
    end process;
    
    q <= s_q;


end Behavioral;
