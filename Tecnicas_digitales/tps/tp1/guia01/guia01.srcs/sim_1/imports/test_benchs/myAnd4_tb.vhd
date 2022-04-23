library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myAnd4_tb is
end myAnd4_tb;

architecture Behavioral of myAnd4_tb is
    COMPONENT myAnd4
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC);
    END COMPONENT; 

   --Inputs
   signal a : STD_LOGIC_VECTOR (3 downto 0) := "0000";
   

 	--Outputs
   signal y : std_logic;   

begin

   uut: myAnd4 PORT MAP (
          a => a,          
          y => y
        );

stim_proc: process
begin
		
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0011";	wait for 100 ns;
	
	a <= "0100";	wait for 100 ns;
	a <= "0101";	wait for 100 ns;
	a <= "0110";	wait for 100 ns;
	a <= "0111";	wait for 100 ns;

	a <= "1000";	wait for 100 ns;
	a <= "1001";	wait for 100 ns;
	a <= "1010";	wait for 100 ns;
	a <= "1011";	wait for 100 ns;
	
	a <= "1100";	wait for 100 ns;
	a <= "1101";	wait for 100 ns;
	a <= "1110";	wait for 100 ns;
	a <= "1111";	wait for 100 ns;

    wait;
end process;


end Behavioral;

