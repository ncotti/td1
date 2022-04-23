library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector_moore is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end edge_detector_moore;

architecture Behavioral of edge_detector_moore is
type state_type is (st_L, st_L_to_H, st_H_to_L, st_H);
   signal state, next_state : state_type;

begin
   
   SYNC_PROC: process (clk)
   begin
      if (rising_edge(clk)) then
         if (rst = '1') then
            state <= st_L;
         else
            state <= next_state;
         end if;
      end if;
   end process;


   OUTPUT_DECODE: process (state)
   begin
      if (state = st_L) then
        output <= '0';
         
      elsif (state = st_L_to_H) then
        output <= '1';
         
      elsif (state = st_H_to_L) then
        output <= '1';
         
      elsif (state = st_H) then
        output <= '0';  
        
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, input)
   begin
      next_state <= state;
      
      case (state) is
         when st_L =>
            if input = '1' then
               next_state <= st_L_to_H;
            end if;
            
         when st_L_to_H =>
            if input = '0' then
               next_state <= st_H_to_L;
            else
                next_state <= st_H;
            end if;
            
         when st_H_to_L =>
            if input = '0' then
                next_state <= st_L;
            else
                next_state <= st_L_to_H;
            end if;
            
        when st_H =>
            if input = '0' then
                next_state <= st_H_to_L;
            end if;
            
         when others =>
            next_state <= state;
      end case;
   end process;


end Behavioral;
