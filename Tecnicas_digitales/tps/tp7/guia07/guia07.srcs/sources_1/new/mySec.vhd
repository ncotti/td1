library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mySec is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           salida : out STD_LOGIC);
end mySec;

architecture Behavioral of mySec is

   type state_type is (stA, stB, stC, stD, stE);
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
         salida <= '0';
         
      elsif state = stB then
         salida <= '1';
         
     elsif state = stC then
         salida <= '1';
         
     elsif state = stD then
         salida <= '0';
         
     elsif state = stE then
         salida <= '1';
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, start)
   begin
      next_state <= state;  

      case (state) is
         when stA =>
            if start = '1' then
               next_state <= stB;
            else
                next_state <= stA;
            end if;
            
        when stB =>
            if start = '1' then
               next_state <= stC;
            else
                next_state <= stA;
            end if;
            
        when stC =>
            if start = '1' then
               next_state <= stD;
            else
                next_state <= stA;
            end if;
            
        when stD =>
            if start = '1' then
               next_state <= stE;
            else
                next_state <= stA;
            end if;
            
            when stE =>
               next_state <= stA;

         when others =>
            next_state <= state;
      end case;
   end process;

end Behavioral;
