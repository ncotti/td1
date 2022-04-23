library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myDiv8 is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
           div : in STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC_VECTOR (7 downto 0));
end myDiv8;

architecture Behavioral of myDiv8 is

begin

    --LO QUE ME GUSTARIA IMPLEMENTAR
    --salida <= std_logic_vector( shift_right(signed(entrada), TO_INTEGER(unsigned(div)) ) );
    
    --LO QUE ME OBLIGA LA CONSIGNA              
    salida <= entrada when (div = "00") else
              '1' & entrada(7 downto 1) when (div = "01") else
              "11" & entrada(7 downto 2) when (div = "10") else
              "111" & entrada(7 downto 3) when (div = "11");
end Behavioral;
