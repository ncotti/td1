library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generadorSecuencia is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           gen : in STD_LOGIC;
           salida : out STD_LOGIC);
end generadorSecuencia;

architecture Behavioral of generadorSecuencia is
    constant N: integer := 4;
    constant SEQ: std_logic_vector (N-1 downto 0) := "1010";

begin
    process (clk)
        variable v_index: integer := 0;
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                salida <= '0';
                v_index := 0;
                
            else 
                if(gen = '1') then
                    v_index := 0;
                    
                elsif(v_index < N) then
                    salida <= SEQ(v_index);
                    v_index := v_index + 1;
                    
                else
                    salida <= '0';
                end if;
                
            end if;
        end if;
    end process;
    


end Behavioral;
