library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCnt2_bis is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           p : in STD_LOGIC_VECTOR (N-1 downto 0);
           salida : out STD_LOGIC);
end myCnt2_bis;

architecture Behavioral of myCnt2_bis is
    signal s_cont: unsigned(N-1 downto 0) := (others => '0');
begin

    --En esta simulación, todos los pulsos son 7 ciclos.

    cont: process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_cont <= (others => '0');
                salida <= '0';
                       
            --La asignacion de la suma ocurre después de que termina el process. Por lo tanto, cuando la suma vale "2" y entra acá, ya
            --estamos en el tercer ciclo. Cuando s_cont = '0' y entra acá, ya pasó un ciclo.      
            elsif (ena = '1') then            
                if (s_cont = (unsigned(p)-1)) then
                    s_cont <= (others => '0');
                    salida <= '1';

                    
                else
                    s_cont <= s_cont + 1;
                    salida <= '0';
                end if;
                
            end if;
            
        end if;
    end process;
    

end Behavioral;
