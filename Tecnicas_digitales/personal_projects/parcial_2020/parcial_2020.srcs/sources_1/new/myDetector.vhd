library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myDetector is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           sync : in STD_LOGIC;
           q : out STD_LOGIC);
end myDetector;

architecture Behavioral of myDetector is

    signal s_q: STD_LOGIC := '0';
    signal last_sync: STD_LOGIC := '0';
    signal serial: STD_LOGIC_VECTOR(3 downto 0) := "0000";
    
begin
    
    process(clk)
        
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_q <= '0';
                serial <= "0000";
                last_sync <= '0';
                
            else
                if(sync = '1' and last_sync = '0') then --Rising edge de sync
                    serial <= serial(2 downto 0) & d; -- EL valor entra por la derecha
                    if (serial = "1010")  then
                        s_q <= '1';
                    else
                        s_q <= '0';
                    end if;
                
                else
                    s_q <= '0';
                end if;
                
                last_sync <= sync;       
                                        
            end if;
        end if;
    end process;
    
    q <= s_q;

end Behavioral;
