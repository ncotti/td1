library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector_mealy is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end edge_detector_mealy;

architecture Behavioral of edge_detector_mealy is

   type state_type is (stA, stB);
   signal state, next_state : state_type;
   signal s_output : std_logic;
   signal s_register : std_logic;

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

   OUTPUT_DECODE: process (state, input)
   begin
      if (state = stA and input = '1') then
         s_output <= '1';
      elsif (state = stB and input = '0') then
         s_output <= '1';
      else
        s_output <= '0';
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, input)
   begin
      next_state <= state;
      
      case (state) is
         when stA =>
            if (input = '1') then
               next_state <= stB;
            end if;
         when stB =>
            if (input = '0') then
               next_state <= stA;
            end if;
         when others =>
            next_state <= state;
      end case;
   end process;
   
   output <= s_output;
   

end Behavioral;
