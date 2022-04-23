library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity detectorSecuencia_tb is
--  Port ( );
end detectorSecuencia_tb;

architecture Behavioral of detectorSecuencia_tb is

component detectorSecuencia is    
    Port ( clk     : in  std_logic;
           rst     : in  std_logic;
           d       : in  std_logic;
           salida  : out  std_logic);
end component;

signal rst : std_logic;
signal d : std_logic;
signal salida : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin

uut: detectorSecuencia     
    Port map ( clk => clk,
               rst => rst,
               d => d, 
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
    d <= '0';
    wait until falling_edge (rst);
    wait until falling_edge (clk);         
    d <= '1';     wait for 10 ns;
    d <= '0';     wait for 10 ns;
    d <= '1';     wait for 10 ns;
    d <= '0';     wait for 50 ns;

    d <= '1';     wait for 10 ns;
    d <= '0';     wait for 10 ns;
    d <= '1';     wait for 10 ns;
    d <= '1';     wait for 10 ns;
    d <= '0';     wait for 10 ns;
    wait;
    
end process;



end Behavioral;
