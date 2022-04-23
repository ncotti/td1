library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity grayBinario is
    Generic (N : integer := 4);
    Port ( gray : in STD_LOGIC_VECTOR (N-1 downto 0);
           binario : out STD_LOGIC_VECTOR (N-1 downto 0));
end grayBinario;

architecture Behavioral of grayBinario is
signal buffer_binario : std_logic_vector (N-1 downto 0);     
begin
    --Le asigno el bit más significativo primero
    buffer_binario(N-1) <= gray (N-1);
   
    bucle: for i in N-2 downto 0 generate
    begin
        buffer_binario(i) <= buffer_binario (i+1) xor gray(i);
    end generate;

    binario <= buffer_binario;
end Behavioral;
