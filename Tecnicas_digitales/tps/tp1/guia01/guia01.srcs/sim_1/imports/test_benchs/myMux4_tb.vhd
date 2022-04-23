library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myMux4_tb is
end myMux4_tb;

architecture Behavioral of myMux4_tb is
    COMPONENT myMux4
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           c : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);

    END COMPONENT; 

   --Inputs
   signal a : STD_LOGIC_VECTOR (3 downto 0) := "0000";
   signal c : STD_LOGIC_VECTOR (1 downto 0) := "00";

 	--Outputs
   signal y : std_logic;   

begin

   uut: myMux4 PORT MAP (
          a => a,          
          c => c,
          y => y
        );

stim_proc: process
begin
		
	c <= "00";
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0100";	wait for 100 ns;
	a <= "1000";	wait for 100 ns;
	
	c <= "01";
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0100";	wait for 100 ns;
	a <= "1000";	wait for 100 ns;
	
	c <= "10";
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0100";	wait for 100 ns;
	a <= "1000";	wait for 100 ns;
	
	c <= "11";
	a <= "0000";	wait for 100 ns;
	a <= "0001";	wait for 100 ns;
	a <= "0010";	wait for 100 ns;
	a <= "0100";	wait for 100 ns;
	a <= "1000";	wait for 100 ns;

    wait;
end process;


end Behavioral;
