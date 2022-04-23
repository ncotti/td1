library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myDivMag8 is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
           div : in STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC_VECTOR (7 downto 0));
end myDivMag8;

architecture Behavioral of myDivMag8 is
    
begin
    --Asumo que div = "00" se quiere dividir por '1', y que cuando
    -- div = "11" se quiere dividir por '8'.
    --Esta operación sería en C++:  salida = entrada >> div; Con shift_right el desplazamiento bit a bit.
    
    --LO QUE ME GUSTARÏA IMPLEMENTAR
    --salida <= std_logic_vector( shift_right(unsigned(entrada), TO_INTEGER(unsigned(div))) );
    
    --LO QUE ME OBLIGA LA CONSIGNA
    salida <= entrada when (div = "00") else
              '0' & entrada(7 downto 1) when (div = "01") else
              "00" & entrada(7 downto 2) when (div = "10") else
              "000" & entrada(7 downto 3) when (div = "11");
    
end Behavioral;
