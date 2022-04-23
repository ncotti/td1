library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           ci : in STD_LOGIC;
           s : out STD_LOGIC;
           co : out STD_LOGIC);
end fullAdder;

architecture Behavioral of fullAdder is

begin
    s <= '1' when ((a = '0') and (b = '0') and (ci = '1')) else
         '1' when ((a = '0') and (b = '1') and (ci = '0')) else
         '1' when ((a = '1') and (b = '0') and (ci = '0')) else
         '1' when ((a = '1') and (b = '1') and (ci = '1')) else
         '0';
         
     co <= '1' when ((a = '0') and (b = '1') and (ci = '1')) else
           '1' when ((a = '1') and (b = '0') and (ci = '1')) else
           '1' when ((a = '1') and (b = '1') and (ci = '0')) else
           '1' when ((a = '1') and (b = '1') and (ci = '1')) else
           '0';         
     
end Behavioral;
