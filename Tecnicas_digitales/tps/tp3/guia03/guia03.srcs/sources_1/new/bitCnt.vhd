library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bitCnt is
    Port ( entrada : in STD_LOGIC_VECTOR (4 downto 0);
           salida : out STD_LOGIC_VECTOR (2 downto 0));
end bitCnt;

architecture Behavioral of bitCnt is
    signal E: std_logic;
    signal D: std_logic;
    signal C: std_logic;
    signal B: std_logic;
    signal A: std_logic;
    
    signal s_E: unsigned (2 downto 0);
    signal s_D: unsigned (2 downto 0);
    signal s_C: unsigned (2 downto 0);
    signal s_B: unsigned (2 downto 0);
    signal s_A: unsigned (2 downto 0);
    
    signal s_sumaAB: unsigned (2 downto 0);
    signal s_sumaCD: unsigned (2 downto 0);
    signal s_sumaABCD: unsigned (2 downto 0);
    signal s_sumaABCDE: unsigned (2 downto 0);

begin
    E <= entrada(4);
    D <= entrada(3);
    C <= entrada(2);
    B <= entrada(1);
    A <= entrada(0);
    
    -- Se revisa que se haya echo correctamente la minimizacion por Karnaugh, y tambien
    -- esta el metodo por sumadores
--    salida(2) <=    (E and D and C and B) or
--                    (E and D and B and A) or
--                    (D and C and B and A) or
--                    (E and D and C and A) or
--                    (E and C and B and A);    
            
--    salida(1) <=    (E and D and not C and not B) or
--                    (E and not D and not C and B) or
--                    (E and not D and C and not B) or
--                    (not E and D and C and not B) or
--                    (not E and not D and C and B) or
--                    (not E and D and not C and B) or
--                    (E and not D and B and not A) or
--                    (E and C and not B and not A) or
--                    (not E and D and C and not A) or
--                    (D and not C and B and not A) or
--                    (D and not C and not B and A) or
--                    (not E and not D and B and A) or
--                    (not E and C and not B and A) or
--                    (E and not D and not C and A);
                                        
--    salida(0) <=    (   (((not E and not D and not C and B) or
--                        (not E and not D and C and not B) or
--                        (not E and D and not C and not B) or
--                        (not E and D and C and B) or
--                        (E and D and not C and B) or
--                        (E and D and C and not B) or
--                        (E and not D and not C and not B) or
--                        (E and not D and C and B)) and not A) or
                        
--                        (((not E and not D and not C and not B) or
--                        (not E and not D and C and B) or
--                        (not E and D and not C and B) or
--                        (not E and D and C and not B) or
--                        (E and D and not C and not B) or
--                        (E and D and C and B) or
--                        (E and not D and not C and B) or
--                        (E and not D and C and not B)) and A) );
                        
    --Metodo por sumadores   
    -- Me aseguro que todos los elementos a sumar tengan 3 bits.  
     s_A <= "00" & A;
     s_B <= "00" & B;
     s_C <= "00" & C;
     s_D <= "00" & D;
     s_E <= "00" & E;
     
     s_sumaAB <= s_A + s_B;
     s_sumaCD <= s_C + s_D;
     s_sumaABCD <= s_sumaAB + s_sumaCD;
     s_sumaABCDE <= s_sumaABCD + s_E;
     
     salida <= std_logic_vector(s_sumaABCDE);

end Behavioral;
