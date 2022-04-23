library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parpadeo1S is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           salida : out STD_LOGIC);
end parpadeo1S;

architecture Behavioral of parpadeo1S is
    --Cantidad máxima de bits de la suma. Si el ciclo de clock es de 10ns, necesito 100 E+6 ciclos para
    --un ciclo de medio segundo prendido, medio segundo apagado.
    --En binario: log2(100E+6) = 26,57 => neesito 27 bits
    constant N: integer := 27;
    constant HALF_SECOND: unsigned(N-1 downto 0) := b"010_1111_1010_1111_0000_1000_0000";
    constant SECOND: unsigned(N-1 downto 0) := HALF_SECOND(N-2 downto 0) & '0'; --Un segundo es medio segundo desplazado a la izquierda.
    
    signal s_rst: std_logic;
    signal s_cont: std_logic_vector (N-1 downto 0);

begin

    cont: entity    work.myCntBinarioSimple
                    generic map (N => N)
                    port map (clk => clk, rst => s_rst, ena => '1', q => s_cont);

    salida <= '1' when (unsigned(s_cont) >= HALF_SECOND) else
              '0';
                
    --Reseteo en 1seg - 1 porque recién en el siguiente ciclo de clock se va a resetear, que es cuando pasa 1 seg exacto.            
    s_rst <= '1' when (unsigned(s_cont) = SECOND - 1) else
              rst;
end Behavioral;
