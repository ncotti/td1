library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntBinGray is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           c : in STD_LOGIC;
           salida : out STD_LOGIC_VECTOR (2 downto 0));
end myCntBinGray;

architecture Behavioral of myCntBinGray is
   type state_type is (B0_G0, B1_G1, B2_G3, B3_G2, B4_G7, B5_G6, B6_G4, B7_G5);
   signal state, next_state : state_type;

begin

   SYNC_PROC: process (clk)
   begin
      if (rising_edge(clk)) then
         if (rst = '1') then
            state <= B0_G0;
         else
            state <= next_state;
         end if;
      end if;
   end process;

   OUTPUT_DECODE: process (state)
   begin
      if state = B0_G0 then
         salida <= "000";
         
      elsif state = B1_G1 then
         salida <= "001";
         
      elsif state = B2_G3 then
         salida <= "010";
         
      elsif state = B3_G2 then
         salida <= "011";
         
      elsif state = B4_G7 then
         salida <= "100";
         
      elsif state = B5_G6 then
         salida <= "101";
         
      elsif state = B6_G4 then
         salida <= "110";
         
      elsif state = B7_G5 then
         salida <= "111";
         
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, c)
   begin
      next_state <= state;

      case (state) is
         when B0_G0 =>
            if c = '0' then
               next_state <= B1_G1;
            else
                next_state <= B1_G1;
            end if;
            
        when B1_G1 =>
            if c = '0' then
               next_state <= B2_G3;
            else
                next_state <= B3_G2;
            end if;
            
        when B2_G3 =>
            if c = '0' then
               next_state <= B3_G2;
            else
                next_state <= B6_G4;
            end if;
            
        when B3_G2 =>
            if c = '0' then
               next_state <= B4_G7;
            else
                next_state <= B2_G3;
            end if;
            
        when B4_G7 =>
            if c = '0' then
               next_state <= B5_G6;
            else
                next_state <= B0_G0;
            end if;
            
        when B5_G6 =>
            if c = '0' then
               next_state <= B6_G4;
            else
                next_state <= B4_G7;
            end if;
            
        when B6_G4 =>
            if c = '0' then
               next_state <= B7_G5;
            else
                next_state <= B7_G5;
            end if;
            
        when B7_G5 =>
            if c = '0' then
               next_state <= B0_G0;
            else
                next_state <= B5_G6;
            end if;

         when others =>
            next_state <= B0_G0;
      end case;
   end process;

end Behavioral;
