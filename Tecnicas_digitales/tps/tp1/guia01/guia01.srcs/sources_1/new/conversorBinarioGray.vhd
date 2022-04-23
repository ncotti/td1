library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity conversorBinarioGray is
    Generic (N: integer := 8);
    Port ( entrada : in STD_LOGIC_VECTOR (N-1 downto 0);
           salida : out STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in STD_LOGIC);
end conversorBinarioGray;

architecture Behavioral of conversorBinarioGray is
--Creamos dos seniales que almacenen la salida de ambos conversores
signal output_b_to_g : std_logic_vector (N-1 downto 0);
signal output_g_to_b : std_logic_vector (N-1 downto 0);
begin
    --El generic map parece redundante, pero le asigna al generic del componente
    --el valor que se le pase a esta entidad.
    b_to_g: entity work.binarioGray
        generic map (N => N)
        port map (binario => entrada, gray => output_b_to_g);
        
    g_to_b: entity work.grayBinario
        generic map (N => N)
        port map (gray => entrada, binario => output_g_to_b);
        
    salida <= output_b_to_g when (sel = '1') else
              output_g_to_b;
end Behavioral;
