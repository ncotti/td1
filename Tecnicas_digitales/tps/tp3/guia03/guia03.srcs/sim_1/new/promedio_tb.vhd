library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity promedio_tb is
--  empty
end promedio_tb;

architecture Behavioral of promedio_tb is
    signal A: std_logic_vector (3 downto 0);
    signal B: std_logic_vector (3 downto 0);
    signal C: std_logic_vector (3 downto 0);
    signal D: std_logic_vector (3 downto 0);
    signal salida: std_logic_vector (3 downto 0);
begin
    inst:   entity work.promedio
            port map (entradaA => A, entradaB => B, entradaC => C, entradaD => D, salida => salida);
            
    test: process
        variable v_a, v_b, v_c, v_d: signed(4 downto 0) := "11000";
    begin
        while (v_a /= "01000") loop
            while (v_b /= "01000") loop
                while (v_c /= "01000") loop
                
                    while (v_d /= "01000") loop
                        A <= std_logic_vector (v_a(3 downto 0));
                        B <= std_logic_vector (v_b(3 downto 0));
                        C <= std_logic_vector (v_c(3 downto 0));
                        D <= std_logic_vector (v_d(3 downto 0)); wait for (100 ns);
                        v_d := v_d + 1;
                    end loop;
                 
                    v_c := v_c + 1;
                    v_d := "11000";
                    
                end loop;
                
                v_b := v_b + 1;
                v_c := "11000";
                v_d := "11000";
                
            end loop;
            
            v_a := v_a + 1;
            v_b := "11000";
            v_c := "11000";
            v_d := "11000";
        end loop;
        wait;
    end process;
    

end Behavioral;
