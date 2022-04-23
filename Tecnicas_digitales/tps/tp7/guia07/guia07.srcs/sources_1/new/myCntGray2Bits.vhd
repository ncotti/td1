library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntGray2Bits is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           salida : out STD_LOGIC_VECTOR (1 downto 0));
end myCntGray2Bits;

architecture Behavioral of myCntGray2Bits is
    type state_type is (stA, stB, stC, stD);
    signal state, next_state : state_type;
begin

   SYNC_PROC: process (clk)
   begin
      if (rising_edge(clk)) then
         if (rst = '1') then
            state <= stA;
         else
            state <= next_state;

         end if;
      end if;
   end process;

   OUTPUT_DECODE: process (state)
   begin
      if state = stA then
         salida <= "00";
         
      elsif state = stB then
         salida <= "01";
         
     elsif state = stC then
         salida <= "11";
         
     elsif state = stD then
         salida <= "10";
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, ena)
   begin
      next_state <= state; 
      
      case (state) is
         when stA =>
            if ena = '1' then
               next_state <= stB;
            end if;
            
         when stB =>
            if ena = '1' then
               next_state <= stC;
            end if;
            
        when stC =>
            if ena = '1' then
               next_state <= stD;
            end if;
            
        when stD =>
            if ena = '1' then
               next_state <= stA;
            end if;            
            
         when others =>
            next_state <= stA;
      end case;
   end process;

end Behavioral;
