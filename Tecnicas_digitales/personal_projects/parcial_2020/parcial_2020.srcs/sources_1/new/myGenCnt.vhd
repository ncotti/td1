library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity myGenCnt is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (2 downto 0));
end myGenCnt;

architecture Behavioral of myGenCnt is

    signal s_q: STD_LOGIC_VECTOR(2 downto 0);

begin

    process(clk)
        variable cont: unsigned(3 downto 0) := "0000";
    begin
        if (rising_edge(clk)) then
            if(rst = '1') then
                s_q <= "000";
                cont := "0000";
                
            else
                cont := cont + 1;
                if (cont = "1010") then --El contador vale 10
                    cont := "0000";
                    s_q <= not s_q(2) & ( (s_q(2) and not s_q(0)) or (not s_q(2) and s_q(1) and not s_q(0)) ) & (not s_q(2) and s_q(1));
                end if;
            
            end if;
            
        end if;
    end process;
    
    q <= s_q;

end Behavioral;
