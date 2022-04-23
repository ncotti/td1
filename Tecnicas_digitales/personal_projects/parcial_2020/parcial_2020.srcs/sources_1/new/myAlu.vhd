library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity myAlu is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           op : in STD_LOGIC_VECTOR (1 downto 0);
           r : out STD_LOGIC_VECTOR (N-1 downto 0);
           ov : out STD_LOGIC);
end myAlu;

architecture Behavioral of myAlu is
    signal s_suma:      std_logic_vector(N-1 downto 0);
    signal s_resta:     std_logic_vector(N-1 downto 0);
    signal s_modulo:    std_logic_vector(N-1 downto 0);
    signal s_logica:    std_logic_vector(N-1 downto 0);
    
    signal s_ov_suma:   std_logic;
    
    constant MOST_NEGATIVE: std_logic_vector(N-1 downto 0) := (N-1 => '1', others => '0');

begin
    r <=    s_suma      when    (op = "00") else
            s_resta     when    (op = "01") else
            s_modulo    when    (op = "10") else
            s_logica    when    (op = "11");
            
    s_suma <= std_logic_vector(signed(a) + signed(b));
    
    s_resta <= std_logic_vector( signed(a) - 1);
    
    s_modulo <= a   when (a(N-1) = '0') else
                std_logic_vector( signed(not a) + 1 );
                
    s_logica <= a and b;
    
    --Suma de dos positivos me da negativo "001"
    --Suma de dos negativos me da positiov "110"
    s_ov_suma <=    (   not a(N-1)    and not b(N-1)  and s_suma(N-1)     )   or 
                    (   a(N-1)        and b(N-1)      and not s_suma(N-1) );
                    
    ov <=   s_ov_suma   when (op = "00") else
            '1'         when (op = "01" and a = MOST_NEGATIVE) else
            '0';              
            
end Behavioral;
