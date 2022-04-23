library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity comparadorCa2 is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           aMayorQueB : out STD_LOGIC;
           aMenorQueB : out STD_LOGIC;
           aIgualB : out STD_LOGIC);
end comparadorCa2;

architecture Behavioral of comparadorCa2 is


begin

    aMayorQueB <= '1' when ( signed(a) > signed(b) ) else
                  '0';
                  
    aMenorQueB <= '1' when ( signed(a) < signed(b) ) else
                  '0';    
                                                            
    aIgualB <= '1' when (signed(a) = signed(b)) else
               '0';

end Behavioral;

