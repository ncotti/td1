library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myEdgeDetector is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           ascendente : out STD_LOGIC;
           descendente : out STD_LOGIC);
end myEdgeDetector;

architecture Behavioral of myEdgeDetector is
    signal last_d: std_logic;
begin
    --Restricción, no puedo llamar a ascendente'event (que es lo mismo que rising_edge())
    --Tendría que almacenar el valor de d del ciclo anterior, y compararlo con el actual.
    --Son dos flip-flops en serie, el primero tiene a la salida el valor anterior de D, que en el próximo
    --ciclo de clock lo compara con el valor actual, y lo mete en la entrada del próximo
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                ascendente <= '0';
                descendente <= '0';
            else
                --Flanco ascendente, antes valia "0" y ahora vale "1"
                ascendente <= not last_d and d;
                --Flanco descendente, antes valia "1" y ahora vale "0"
                descendente <= last_d and not d; 
            end if;
            last_d <= d;
        end if;   
    end process;

end Behavioral;
