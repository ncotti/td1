library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFT is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           t : in STD_LOGIC;
           q : out STD_LOGIC);
end FFT;

architecture Behavioral of FFT is
    signal s_q: std_logic;
begin
    process (clk)
    begin
        if( rising_edge(clk)) then
            if (rst = '1') then
                s_q <= '0';
            elsif (t = '1') then
                s_q <= not s_q;
            end if;
        end if;
    end process;
    
    q <= s_q;


end Behavioral;
