library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detectorSecuencia is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           salida : out STD_LOGIC);
end detectorSecuencia;

architecture Behavioral of detectorSecuencia is
    constant N: integer := 4;
    constant SEQ: std_logic_vector(N-1 downto 0) := "1010";
    signal s_seq: std_logic_vector(N-1 downto 0);

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_seq <= (others => '0');
                salida <= '0';
                
            else
                salida <= '0';
                s_seq <= s_seq(N-2 downto 0) & d; --Desplazo hacia la izquierda, y agrego la entrada al principio del número
                
                if (s_seq = SEQ) then --Esta comprobación se hace en el próximo ciclo de la asignación.
                    salida <= '1';
                end if;
                
            end if;
        end if;
    end process;

end Behavioral;
