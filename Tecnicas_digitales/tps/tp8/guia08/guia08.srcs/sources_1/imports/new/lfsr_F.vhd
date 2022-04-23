library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;

entity lfsr_F is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           inits : in STD_LOGIC_VECTOR (N-1 downto 0);
           taps : in STD_LOGIC_VECTOR (N-1 downto 0);
           salida : out STD_LOGIC_VECTOR (N-1 downto 0));
end lfsr_F;

architecture Behavioral of lfsr_F is
    signal s_salida: std_logic_vector(N-1 downto 0);
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_salida <= inits;
                       
            else
                s_salida(0) <=  xor_reduce((taps and s_salida)); --Pongo en la XOR los elementos que tengan taps activado
                s_salida(N-1 downto 1) <= s_salida(N-2 downto 0); -- Desplazo la salida hacia la derecha
                
            end if;
        end if;
    end process;
    
    salida <= s_salida;

end Behavioral;
