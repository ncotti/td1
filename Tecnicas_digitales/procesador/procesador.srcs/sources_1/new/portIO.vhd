library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

---------------------------------------------------------------------------
--  Puerto de entrada y salida del procesador.
--  La entrada esta buffereada, la salida está registrada.
---------------------------------------------------------------------------

entity portIO is
    Port ( clk :        in STD_LOGIC;
           rst :        in STD_LOGIC;
           portRd :     in STD_LOGIC_VECTOR (7 downto 0);
           portRdReg :  out STD_LOGIC_VECTOR (7 downto 0);
           portWrEna :  in STD_LOGIC;
           portWr :     out STD_LOGIC_VECTOR (7 downto 0);
           portWrReg :  in STD_LOGIC_VECTOR (7 downto 0));
end portIO;

architecture Behavioral of portIO is

begin

    portRdReg <= portRd;    --Buffer para la entrada.
    
    output_reg: process (clk)
    begin
        if (rising_edge(clk)) then

            if (rst = '1') then
                portWr <= (others => '0');
                
            elsif (portWrEna = '1') then
                portWr <= portWrReg;
            end if;
            
        end if;
    end process; 
end Behavioral;
