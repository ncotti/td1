library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFft is
    Port ( t : in STD_LOGIC;
           ena : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC);
end myFft;

architecture Behavioral of myFft is

    signal s_q: std_logic;

begin

    --Reset asincronico, va en la lista, no se activa con el clock
    process(clk, rst) begin
        
        if (rst = '1') then -- Activo alto, entiendo esto
            s_q <= '0';
            
        elsif (falling_edge(clk) ) then --Flanco descendente
            
            if (ena = '0') then -- Activo alto, entiendo esto
                s_q <= '0';
            
            else
                s_q <= t xor s_q; 
                
            end if;   
              
        end if;
        
    end process;
    
    q <= s_q;


end Behavioral;
