library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sat16a8 is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : out STD_LOGIC_VECTOR (7 downto 0));
end sat16a8;

architecture Behavioral of sat16a8 is

-- 0111 1111
constant max_8 : std_logic_vector (7 downto 0) := (7 => '0',
                                                  others => '1');
-- 1000 0000                                                
constant min_8 : std_logic_vector (7 downto 0) := (7 => '1',
                                                   others => '0');
        
 -- 0000 0000 0111 1111                                           
constant max_16 : std_logic_vector (15 downto 0) := (15 downto 7 => '0',
                                                     others => '1');

-- 1111 1111 1000 0000                                                    
constant min_16 : std_logic_vector (15 downto 0) := (15 downto 7 => '1',
                                                     others => '0');

begin
    --Entiendo por saturación que si el número está fuera del rango, trunque el valor del número al valor de
    --8 bits más cercano 
      
    --La salida puedo formarla con los primeros 7 bits, y el bit de signo del número grande.
    b <= max_8 when ( signed(a) > signed (max_16)) else
         min_8 when ( signed(a) < signed (min_16)) else
         a(15) & a(6 downto 0);

end Behavioral;
