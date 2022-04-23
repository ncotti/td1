library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multFrac is
    Generic (N: integer := 6);
    Port ( entrada : in STD_LOGIC_VECTOR (N-2 downto 0);
           salida : out STD_LOGIC_VECTOR (N-1 downto 0));
end multFrac;

architecture Behavioral of multFrac is
    --Todas las signals tienen que tener el mismo tamaño, y el maximo tamaño es 2 bits
    --más grande que el tamaño de entrada
    signal s_entrada_resized: std_logic_vector(entrada'length +1 downto 0);
    signal s_x2: std_logic_vector(entrada'length + 1 downto 0);
    signal s_suma: signed(entrada'length + 1 downto 0);

begin
    --Inicializo la entrada, agregando 2 bits extra de signo a los MSB
    s_entrada_resized <= entrada(entrada'length -1) & entrada(entrada'length -1) & entrada; 
    
    --Defino la entrada desplazada s_x2 = entrada << 1, agregando un bit de signo al MSB
    s_x2 <= entrada(entrada'length - 1) & entrada & '0';
       
    --Sumo la entrada y el desplazamiento
    s_suma <= signed(s_x2) + signed(s_entrada_resized);
    
    --La salida es un shift derecho 
    salida <= std_logic_vector(s_suma(entrada'length+1 downto 1));
    
end Behavioral;
