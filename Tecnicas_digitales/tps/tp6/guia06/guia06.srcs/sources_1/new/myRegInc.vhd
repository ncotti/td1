library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity myRegInc is
    Generic (N: integer := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           dataUp : in STD_LOGIC;
           dataDown : in STD_LOGIC;
           regOut : out STD_LOGIC_VECTOR (N-1 downto 0));
end myRegInc;

architecture Behavioral of myRegInc is
    signal s_regOut: std_logic_vector(N-1 downto 0);

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_regOut <= (others => '0');
                
            elsif (dataUp = '1' and dataDown = '0') then
                s_regOut <= std_logic_vector(signed(s_regOut) + 1);
            
            elsif (dataUp = '0' and dataDown = '1') then
                s_regOut <= std_logic_vector(signed(s_regOut) - 1);
            end if;
            
        end if;
    end process;

    regOut <= s_regOut;

end Behavioral;
