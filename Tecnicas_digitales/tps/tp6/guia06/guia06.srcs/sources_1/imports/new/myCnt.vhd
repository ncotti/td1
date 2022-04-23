library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity myCnt is
    Generic (M: integer := 100);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           salidaM_2 : out STD_LOGIC;
           salidaM : out STD_LOGIC);
end myCnt;

architecture Behavioral of myCnt is
    constant N : integer := integer(ceil(log2(real (M))));
    constant M_2: unsigned (N-1 downto 0) := to_unsigned(M-1, N)/2;
    
    signal s_cont: unsigned(N-1 downto 0) := (others => '0');
    signal s_half_m: std_logic := '0'; --Detecta cual fue el último ciclo que levante (es un latch).

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            
            if (rst = '1') then
                s_cont <= (others => '0');
                salidaM_2 <= '0';
                salidaM <= '0';
                
            elsif (ena = '1') then
                s_cont <= s_cont + 1;   --La asignación de la suma ocurre al terminar el process
                salidaM_2 <= '0';
                salidaM <= '0';
                
                if (s_cont = M_2) then --Paso M_2 ciclos de clock
                    
                    if (s_half_m = '0') then --El ultimo que levante no fue el de M_2, levantar ese.
                        salidaM_2 <= '1';
                    else
                        salidaM <= '1';
                    end if;
                    
                    s_half_m <= not s_half_m;
                    s_cont <= (others => '0');
                end if;
                              
            end if;
            
        end if;
    end process;


end Behavioral;
