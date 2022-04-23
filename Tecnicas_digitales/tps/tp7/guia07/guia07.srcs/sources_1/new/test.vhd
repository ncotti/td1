library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end test;

architecture Behavioral of test is
signal s_output : std_logic;

--Prueba hecha sin MDE para comprobar el funcionamiento del edge detector Mealy.
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                s_output <= '0';
            else
                s_output <= input;
            end if;
        end if;
    end process;
    
    output <= (s_output and not input) or (not s_output and input);


end Behavioral;
