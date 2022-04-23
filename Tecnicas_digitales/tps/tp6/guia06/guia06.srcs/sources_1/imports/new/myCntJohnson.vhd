library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntJohnson is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end myCntJohnson;

architecture Behavioral of myCntJohnson is
    signal s_q: std_logic_vector (N-1 downto 0);

begin
    process (clk)
    begin
        if( rising_edge(clk)) then
            if (rst = '1') then
                s_q <= (others => '0');
            elsif (ena = '1') then
                s_q <= s_q(N-2 downto 0) & not s_q(N-1);
            end if;
        end if;
    end process;

    q <= s_q;

end Behavioral;
