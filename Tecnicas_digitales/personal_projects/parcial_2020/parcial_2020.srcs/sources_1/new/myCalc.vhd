library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCalc is
    Generic (N: integer := 4);
    Port ( d : in STD_LOGIC_VECTOR (N-1 downto 0);
           r : out STD_LOGIC_VECTOR (N downto 0));
end myCalc;

architecture Behavioral of myCalc is

    --Al multiplicar por tres, el tamaño máximo es de dos bits extras. "111" * 3 = "10101"
    signal s_x2: std_logic_vector(N+1 downto 0); 
    signal s_x3: std_logic_vector(N+1 downto 0);

begin
    --Multiplicar por dos es hacer d << 1: E.g 110 << 1 = 1100
    s_x2 <= d(N-1) & d(N-1 downto 0) & '0';
    
    --Al sumarle el valor original, es como si estuviera multiplicando por 3.
    s_x3 <= std_logic_vector(signed(s_x2) + signed( d(N-1) & d(N-1) & d(N-1 downto 0) ) );
    
    --Dividir por dos el lo mismo que hacer s_x3 >> 1. E.g 11100 >> 1 = 1 1110. El bit de signo no lo incluyo, y descarto el valor LSB.
    r <= s_x3(N+1 downto 1);

end Behavioral;
