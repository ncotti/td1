library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myCmp is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           c : in STD_LOGIC_VECTOR (N-1 downto 0);
           mayor : out STD_LOGIC_VECTOR (N-1 downto 0);
           medio : out STD_LOGIC_VECTOR (N-1 downto 0);
           menor : out STD_LOGIC_VECTOR (N-1 downto 0));
end myCmp;

architecture Behavioral of myCmp is

    signal s_a: std_logic_vector(N-1 downto 0);
    signal s_b: std_logic_vector(N-1 downto 0);
    signal s_c: std_logic_vector(N-1 downto 0);
    
    signal c_mayor_b: std_logic;
    signal c_mayor_a: std_logic;
    signal b_mayor_a: std_logic;

begin
    --Invierto el MSB
    s_a <= not a(N-1) & a(N-2 downto 0);
    s_b <= not b(N-1) & b(N-2 downto 0);
    s_c <= not c(N-1) & c(N-2 downto 0);
    
    --Obtengo las expresiones binaria de comparacion
    c_mayor_b <= '1' when (unsigned(s_c) > unsigned(s_b)) else
                 '0';
                 
    c_mayor_a <= '1' when (unsigned(s_c) > unsigned(s_a)) else
                 '0';
                 
    b_mayor_a <= '1' when (unsigned(s_b) > unsigned(s_a)) else
                 '0';
                
             
    mayor <=    c when (c_mayor_b = '1' and c_mayor_a = '1') else   -- c > b && c > a
                b when (c_mayor_b = '0' and b_mayor_a = '1') else   -- b > c && b > a
                a;   
                
    menor <=    c when (c_mayor_b = '0' and c_mayor_a = '0') else   -- c < b && c < a
                b when (c_mayor_b = '1' and b_mayor_a = '0') else   -- b < c && b < a
                a; 
                
    medio <=    c when ( (c_mayor_b = '1' and c_mayor_a = '0') or (c_mayor_b = '0' and c_mayor_a = '1') ) else  -- b < c < a || a < c < b
                b when ( (c_mayor_b = '1' and b_mayor_a = '1') or (c_mayor_b = '0' and b_mayor_a = '0') ) else  -- a < b < c || c < b < a
                a;                 
    


end Behavioral;
