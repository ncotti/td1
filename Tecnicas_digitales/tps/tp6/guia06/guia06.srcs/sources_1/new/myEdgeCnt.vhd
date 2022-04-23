library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myEdgeCnt is
    Generic (N: integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end myEdgeCnt;

architecture Behavioral of myEdgeCnt is
    signal s_descendente: std_logic;
    signal s_ascendente: unsigned (0 downto 0);
    signal s_q: std_logic_vector(N-1 downto 0);

begin

    edge_detector:  entity work.myEdgeDetector
                    port map (clk => clk, rst => rst, d => d, descendente => s_descendente, ascendente => s_ascendente(0) );
                    
    counter: process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_q <= (others => '0');
                
            else
                s_q <= std_logic_vector(unsigned(s_q) + s_ascendente );
            end if;
        end if;
    end process;

    q <= s_q;
end Behavioral;
