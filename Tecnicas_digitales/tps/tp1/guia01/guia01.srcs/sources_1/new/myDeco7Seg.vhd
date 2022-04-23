library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myDeco7Seg is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           a, b, c, d, e, f, g : out STD_LOGIC);
end myDeco7Seg;

architecture Behavioral of myDeco7Seg is
    --Como no puedo usar un std_logic_vector, me creo una señal que sea un vector--
    signal output : std_logic_vector (6 downto 0);
begin
   with entrada select
        output <= "1111110" when "0000",
                  "0110000" when "0001",
                  "1101101" when "0010",
                  "1111001" when "0011",
                  "0110011" when "0100",
                  "1011011" when "0101",
                  "1011111" when "0110",
                  "1110000" when "0111",
                  "1111111" when "1000",
                  "1111011" when "1001",
                  "1001111" when others;
     
    --Ahora, le asigno a cada salida el valor de la señal-- 
    a <= output(6);
    b <= output(5);
    c <= output(4);
    d <= output(3);
    e <= output(2);
    f <= output(1);
    g <= output(0);  
end Behavioral;
