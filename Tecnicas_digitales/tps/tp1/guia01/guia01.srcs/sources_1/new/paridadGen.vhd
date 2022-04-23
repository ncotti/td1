library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity paridadGen is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in STD_LOGIC;
           p : out STD_LOGIC);
end paridadGen;

architecture Behavioral of paridadGen is
--Representa los cables de salida de los XOR.
signal s_xor : std_logic_vector (N-2 downto 0);
begin
    --La salida de la primera XOR se forma con las primeras dos entradas
    s_xor(0) <= a(0) xor a(1);
    
    bucle: for i in 1 to N-2 generate
    begin
        --La salida de la XOR siguiente se forma con la salida de la XOR anterior y la siguiente entrada.
        s_xor(i) <= s_xor(i-1) xor a(i+1); 
    end generate;
    
    --La output final se forma con la salida de la última XOR y el bit de seleccion
    p <= s_xor(N-2) xor sel;

end Behavioral;
