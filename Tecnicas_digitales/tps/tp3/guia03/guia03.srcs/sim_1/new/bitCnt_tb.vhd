library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;



entity bitCnt_tb is
    --Empty
end bitCnt_tb;

architecture Behavioral of bitCnt_tb is
    signal s_entrada : std_logic_vector (4 downto 0);
    signal s_salida : std_logic_vector (2 downto 0);
begin

    inst: entity work.bitCnt
          port map (entrada => s_entrada, salida => s_salida); 

    test: process
        variable v_input : unsigned (4 downto 0) := "00000";
    begin
        while (v_input /= "11111") loop
            s_entrada <= std_logic_vector(v_input); wait for (100 ns);
            v_input := v_input + 1;
        end loop;
        
        s_entrada <= "11111"; wait for (100 ns);
        wait;
    end process;

end Behavioral;
