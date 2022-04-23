library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myAnd2_tb is
end myAnd2_tb;

architecture Behavioral of myAnd2_tb is
    COMPONENT myAnd2
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         y : OUT  std_logic
        );
    END COMPONENT; 

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal y : std_logic;   

begin

   uut: myAnd2 PORT MAP (
          a => a,
          b => b,
          y => y
        );

stim_proc: process
begin
		
	a <= '0';	b <= '0'; wait for 100 ns;
	a <= '0';	b <= '1'; wait for 100 ns;
	a <= '1';	b <= '0'; wait for 100 ns;
	a <= '1';	b <= '1'; wait for 100 ns;

    a <= '0';	b <= '0'; wait for 100 ns;
    wait;
end process;


end Behavioral;

