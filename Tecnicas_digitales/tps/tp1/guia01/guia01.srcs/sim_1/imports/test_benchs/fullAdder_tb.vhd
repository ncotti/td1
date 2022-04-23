library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder_tb is
end fullAdder_tb;

architecture Behavioral of fullAdder_tb is
    COMPONENT fullAdder
    Port ( a, b, ci : in STD_LOGIC;
           s, co : out STD_LOGIC);
    END COMPONENT;

   --Inputs
   signal abci : STD_LOGIC_VECTOR (2 downto 0) := "000";

   --Outputs
   signal s : std_logic;
   signal co : std_logic;

begin

   uut: fullAdder PORT MAP (
          a => abci(0),
          b => abci(1),
          ci => abci(2),
          s => s,
          co => co
        );

stim_proc: process
begin

	abci <= "000";	wait for 100 ns;
	abci <= "001";	wait for 100 ns;
	abci <= "010";	wait for 100 ns;
	abci <= "011";	wait for 100 ns;

	abci <= "100";	wait for 100 ns;
	abci <= "101";	wait for 100 ns;
	abci <= "110";	wait for 100 ns;
	abci <= "111";	wait for 100 ns;

    wait;
end process;


end Behavioral;
