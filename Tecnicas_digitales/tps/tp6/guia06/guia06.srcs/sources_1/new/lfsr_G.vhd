library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr_G is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           inits : in STD_LOGIC_VECTOR (N-1 downto 0);
           taps : in STD_LOGIC_VECTOR (N-1 downto 0);
           salida : out STD_LOGIC_VECTOR (N-1 downto 0));
end lfsr_G;

architecture Behavioral of lfsr_G is
    signal s_salida: std_logic_vector(N-1 downto 0);
    
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_salida <= inits;
                
            else
                --Cada salida es la salida anterior XOR la ultima salida, si el tap está activo.
                for i in N-1 downto 1 loop
                    s_salida(i) <= s_salida(i-1) xor (s_salida(N-1) and taps(i));
                end loop;
                s_salida(0) <= s_salida(N-1); --La última salida se iguala a la primera entrada
                
            end if;
        end if;
    end process;
    
    salida <= s_salida;
end Behavioral;
