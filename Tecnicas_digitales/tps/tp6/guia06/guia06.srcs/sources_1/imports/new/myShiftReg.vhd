library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myShiftReg is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           si : in STD_LOGIC;
           so : out STD_LOGIC;
           po : out STD_LOGIC_VECTOR (N-1 downto 0);
           pi : in STD_LOGIC_VECTOR (N-1 downto 0);
           pl : in STD_LOGIC);
end myShiftReg;

architecture Behavioral of myShiftReg is
    signal s_register: std_logic_vector(N-1 downto 0);

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if( rst = '1') then
                s_register <= (others => '0');
            elsif (ena = '1') then
                if (pl = '1') then --Tomar valores paralelos
                    s_register <= pi;
                else --Desplazar
                    s_register <= s_register(N-2 downto 0) & si;
                end if;
            end if;
        end if;
    end process;
    
    po <= s_register;
    so <= s_register(N-1);

end Behavioral;
