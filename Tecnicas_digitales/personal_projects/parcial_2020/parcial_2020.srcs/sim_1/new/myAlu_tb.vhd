library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity myAlu_tb is
    generic (N: integer := 4);
end myAlu_tb;

architecture Behavioral of myAlu_tb is
    signal a : STD_LOGIC_VECTOR (N-1 downto 0);
    signal b : STD_LOGIC_VECTOR (N-1 downto 0);
    signal op: STD_LOGIC_VECTOR (1 downto 0);
    signal r : STD_LOGIC_VECTOR (N-1 downto 0);
    signal ov: STD_LOGIC;

begin

    inst:   entity work.myAlu
            generic map (N => N)
            port map (a => a, b => b, op => op, r => r, ov => ov);
            
    process
    begin
        op <= "00";
        a <= "0110"; b <= "0001"; wait for 100ns;
        a <= "0010"; b <= "1000"; wait for 100ns;
        a <= "0110"; b <= "0010"; wait for 100ns;
        a <= "1001"; b <= "1010"; wait for 100ns;
        
        op <= "01";
        a <= "0000"; wait for 100ns;
        a <= "1000"; wait for 100ns;
        
        op <= "10";
        a <= "0110"; wait for 100ns;
        a <= "1110"; wait for 100ns;
        
        op <= "11";
        a <= "0000"; b <= "1111"; wait for 100ns;
        a <= "0101"; b <= "0110"; wait for 100ns;
        a <= "1011"; b <= "1011"; wait for 100ns; 
    end process;

end Behavioral;
