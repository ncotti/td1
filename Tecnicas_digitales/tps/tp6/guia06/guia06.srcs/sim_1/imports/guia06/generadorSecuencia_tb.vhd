library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity generadorSecuencia_tb is

end generadorSecuencia_tb;

architecture Behavioral of generadorSecuencia_tb is
component generadorSecuencia is
    Port ( clk     : in  std_logic;
           rst     : in  std_logic;
           gen     : in  std_logic;
           salida  : out  std_logic);
end component;

signal rst : std_logic;
signal gen : std_logic;
signal salida : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin

uut: generadorSecuencia     
    Port map ( clk => clk,
               rst => rst,
               gen => gen, 
               salida => salida);

-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 50 ns;
    rst <= '0';     wait;
end process;

-- Ena process --
enaProc :process
begin  
    gen <= '0';
    wait until falling_edge (rst);
    wait until rising_edge (clk);     
    gen <= '1';     wait for 10 ns;
    gen <= '0';     wait for 200 ns;
    gen <= '1';     wait for 10 ns;
    gen <= '0';     wait;
end process;


end Behavioral;
