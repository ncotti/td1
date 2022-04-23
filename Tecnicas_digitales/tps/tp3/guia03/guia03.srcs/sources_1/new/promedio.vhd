library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity promedio is
    Generic (N: integer := 4);
    Port ( entradaA : in STD_LOGIC_VECTOR (3 downto 0);
           entradaB : in STD_LOGIC_VECTOR (3 downto 0);
           entradaC : in STD_LOGIC_VECTOR (3 downto 0);
           entradaD : in STD_LOGIC_VECTOR (3 downto 0);
           salida : out STD_LOGIC_VECTOR (N-1 downto 0));
end promedio;

architecture Behavioral of promedio is
    signal s_sumaAB, s_sumaCD, s_sumaABCD: signed (5 downto 0);
    signal s_a, s_b, s_c, s_d: signed (5 downto 0);
begin
    --Hago todos los numeros de 5 bits, completando los bits mas
    --significativos de acuerdo al signo.
    
    s_a <= (3 => entradaA(3),
            2 => entradaA(2),
            1 => entradaA(1),
            0 => entradaA(0),
            others => entradaA(3) );
                
    s_b <= (3 => entradaB(3),
            2 => entradaB(2),
            1 => entradaB(1),
            0 => entradaB(0),
            others => entradaB(3) );
            
    s_c <= (3 => entradaC(3),
            2 => entradaC(2),
            1 => entradaC(1),
            0 => entradaC(0),
            others => entradaC(3) );
            
     s_d <= (3 => entradaD(3),
             2 => entradaD(2),
             1 => entradaD(1),
             0 => entradaD(0),
             others => entradaD(3) );           
            
    s_sumaAB <= s_a + s_b;
    s_sumaCD <= s_c + s_d;
    s_sumaABCD <= s_sumaAB + s_sumaCD;
    
    bucle2: for i in 0 to N-1 generate
    begin
        salida(i) <= std_logic(s_sumaABCD(i+2));
    end generate; 

end Behavioral;
