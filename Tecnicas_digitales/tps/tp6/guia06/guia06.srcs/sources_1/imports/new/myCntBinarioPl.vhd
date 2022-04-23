library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCntBinarioPl is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           dl : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (N-1 downto 0);
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end myCntBinarioPl;

architecture Behavioral of myCntBinarioPl is

    signal s_cont: unsigned(N-1 downto 0) := (others => '0');

begin
    process (clk)
    begin
        if( rising_edge(clk)) then
            if (rst = '1') then
                s_cont <= (others => '0');
                
            elsif (ena = '1') then
                if (dl = '1') then --Tomo valores de d
                    s_cont <= unsigned(d);
                else
                    s_cont <= s_cont + 1;
                end if;
            end if;
            
        end if;
    end process;
    
    q <= std_logic_vector(s_cont);

end Behavioral;
