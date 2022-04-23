library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binarioGray is
    Generic (N: integer := 4);
    Port ( binario : in STD_LOGIC_VECTOR (N-1 downto 0);
           gray : out STD_LOGIC_VECTOR (N-1 downto 0));
end binarioGray;

architecture Behavioral of binarioGray is
signal buffer_gray : std_logic_vector (N-1 downto 0);
begin
    
    buffer_gray(N-1) <= binario(N-1);
    bucle: for i in N-2 downto 0 generate
    begin
        buffer_gray(i) <= binario (i + 1) xor binario(i);
    end generate;

    gray <= buffer_gray;
end Behavioral;
