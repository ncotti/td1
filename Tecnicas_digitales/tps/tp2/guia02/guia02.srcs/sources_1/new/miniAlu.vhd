library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity miniAlu is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           op : in STD_LOGIC_VECTOR (1 downto 0);
           zero : out STD_LOGIC;
           ov : out STD_LOGIC;
           resultado : out STD_LOGIC_VECTOR (N-1 downto 0));
end miniAlu;

architecture Behavioral of miniAlu is
    signal adder_res : std_logic_vector (N-1 downto 0);
    signal adder_ov : std_logic;
    signal buffer_resultado : std_logic_vector (N-1 downto 0);
    constant const_zero : unsigned (N-1 downto 0) := (others => '0');
begin

    adder : entity work.sumadorRestadorSat
            generic map (N => N)
            port map (a => a, b => b, s_r => op(0), ov => adder_ov, resultado => adder_res);
            
    buffer_resultado <= adder_res when ( (op="00") or (op="01") ) else
                        a and b when ( op = "10") else
                        a or b;
                 
    resultado <= buffer_resultado;  
              
    ov <= adder_ov when ((op="00") or (op="01")) else
          '0';
          
    zero <= '1' when (unsigned (buffer_resultado) = const_zero) else
            '0';           
end Behavioral;
