library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntMoore is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           salida : out STD_LOGIC_VECTOR (2 downto 0));
end myCntMoore;

architecture Behavioral of myCntMoore is

    type state_type is (stS0, stS1, stS2, stS3);
    signal state, next_state : state_type;

begin

   SYNC_PROC: process (clk)
   begin
      if (rising_edge(clk)) then
         if (rst = '1') then
            state <= stS0;
         else
            state <= next_state;
         end if;
      end if;
   end process;

   OUTPUT_DECODE: process (state)
   begin
      if state = stS0 then
         salida <= "000";
         
      elsif state = stS1 then
         salida <= "100";
         
     elsif state = stS2 then
         salida <= "110";
         
     elsif state = stS3 then
         salida <= "111";
         
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, ena)
   begin
      next_state <= state;

      case (state) is
         when stS0 =>
            if ena = '1' then
               next_state <= stS1;
            end if;
            
         when stS1 =>
            if ena = '0' then
               next_state <= stS2;
            end if;
            
        when stS2 =>
            if ena = '1' then
               next_state <= stS3;
            end if;
            
        when stS3 =>
            if ena = '0' then
               next_state <= stS0;
            end if;

         when others =>         
            next_state <= stS0;
            
      end case;
   end process;

end Behavioral;
