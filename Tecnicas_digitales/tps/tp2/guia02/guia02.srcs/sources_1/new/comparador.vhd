library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparador is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           magCa2 : in STD_LOGIC;
           aMayorQueB : out STD_LOGIC;
           aMenorQueB : out STD_LOGIC;
           aIgualB : out STD_LOGIC);
end comparador;

architecture Behavioral of comparador is

begin
    aMayorQueB <= '1' when ( ( (magCa2 = '0') and (unsigned(a) > unsigned(b)) ) or 
                             ( (magCa2 = '1') and (signed(a) > signed(b)) ) ) else
                  '0';
                  
    aMenorQueB <= '1' when ( ( (magCa2 = '0') and (unsigned(a) < unsigned(b)) ) or 
                             ( (magCa2 = '1') and (signed(a) < signed(b)) ) ) else
                  '0';    
    --Es lo mismo tratarlos como signed o unsigned para la igualdad.                                          
    aIgualB <= '1' when (unsigned(a) = unsigned(b)) else
               '0';

end Behavioral;
