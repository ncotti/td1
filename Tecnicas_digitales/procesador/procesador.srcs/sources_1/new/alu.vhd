library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_MISC.ALL;
use work.constants.all;

---------------------------------------------------------------------------
--  ALU con 9 operaciones y salida registrada.
--  0000 =  AND lógico.
--  0001 =  OR lógico.
--  0010 =  XOR lógico.  
--  0011 =  ADDITION.
--  0100 =  SUBTRACTION.
--  0101 =  ROTATION.
--  0110 =  IGUALACIÓN.
--  0111 =  CARRY CLEAR.
--  1000 =  CARRY SET.
--
--  Y 4 flags:
--  Zero.
--  Overflow.
--  CarryBorrow.
--  Negative.
---------------------------------------------------------------------------

entity alu is
    Generic (N: integer := 8);
    Port ( clk :            in  STD_LOGIC;
           rst :            in  STD_LOGIC;
           ena :            in  STD_LOGIC;
           code :           in  STD_LOGIC_VECTOR (3 downto 0);
           op :             in  STD_LOGIC_VECTOR (N-1 downto 0);
           acc :            out STD_LOGIC_VECTOR (N-1 downto 0);
           zero :           out STD_LOGIC;
           overflow :       out STD_LOGIC;
           carryBorrow :    out STD_LOGIC;
           negative :       out STD_LOGIC);
end alu;

architecture Behavioral of alu is
    
    ---------------------------------------------------------------------------
    --  Señales de salida de operaciones aritmético-lógicas
    ---------------------------------------------------------------------------
    signal s_and:       std_logic_vector (N-1 downto 0);
    signal s_or:        std_logic_vector (N-1 downto 0);
    signal s_xor:       std_logic_vector (N-1 downto 0);
    signal s_add:       std_logic_vector (N-1 downto 0);
    signal s_sub:       std_logic_vector (N-1 downto 0);
    signal s_rot:       std_logic_vector (N-1 downto 0);
    
    signal s_carry_rot: std_logic;
    signal s_carry_add: std_logic;
    signal s_carry_sub: std_logic;
    
    ---------------------------------------------------------------------------
    --  Entradas y salidas del flip-flop
    ---------------------------------------------------------------------------
    signal acc_q :              std_logic_vector(N-1 downto 0);
    signal zero_q :             std_logic;
    signal overflow_q :         std_logic;
    signal carryBorrow_q :      std_logic;
    signal negative_q :         std_logic;

    signal next_acc :           std_logic_vector (N-1 downto 0);
    signal next_zero :          std_logic;
    signal next_overflow :      std_logic;
    signal next_carryBorrow :   std_logic;
    signal next_negative :      std_logic;
    
    ---------------------------------------------------------------------------
    --  Señales auxiliares e intermedias
    ---------------------------------------------------------------------------
    signal aux_rot :        std_logic_vector (N downto 0);
    signal after_rot :      std_logic_vector (N downto 0);
    signal aux_add_op :     std_logic_vector (N+1 downto 0);
    signal aux_add_acc :    std_logic_vector (N+1 downto 0);
    signal aux_add_ans :    std_logic_vector (N+1 downto 0);
    signal aux_sub_ans :    std_logic_vector (N+1 downto 0);
    
begin

    ---------------------------------------------------------------------------
    --  Operación del flip-flop
    ---------------------------------------------------------------------------
    result: process (clk)
    begin
        if (rising_edge(clk)) then
        
            if (rst = '1') then
                acc_q           <= (others => '0');
                zero_q          <= '1';
                overflow_q      <= '0';
                carryBorrow_q   <= '0';
                negative_q      <= '0';
                
            elsif (ena = '1') then
                acc_q           <= next_acc;
                zero_q          <= next_zero;
                overflow_q      <= next_overflow;
                carryBorrow_q   <= next_carryBorrow;
                negative_q      <= next_negative;
            end if;
            
        end if;
        
    end process;
    
    acc         <= acc_q;
    zero        <= zero_q;
    overflow    <= overflow_q;
    carryBorrow <= carryBorrow_q;
    negative    <= negative_q; 
    
    ---------------------------------------------------------------------------
    --  Asignaciones de estados futuros
    ---------------------------------------------------------------------------
    next_acc <= s_and       when (code = AND_CODE)          else
                s_or        when (code = OR_CODE)           else
                s_xor       when (code = XOR_CODE)          else
                s_add       when (code = ADD_CODE)          else
                s_sub       when (code = SUB_CODE)          else
                s_rot       when (code = ROT_CODE)          else
                op          when (code = EQUAL_CODE)        else
                acc_q       when (code = CARRY_CLR_CODE)    else
                acc_q       when (code = CARRY_SET_CODE)    else
                acc_q;
                
    next_zero <= not or_reduce(next_acc);
    
    --La suma de dos positivos (MSB = 0) da como resultado un negativo (MSB=1)
    --La resta de un negativo (MSB=1) con un positivo (MSB=0) da como resultado un positivo (MSB=0) 
    next_overflow <= not acc_q(N-1) and not op(N-1) and next_acc(N-1)       when (code = ADD_CODE) else
                     acc_q(N-1)     and not op(N-1) and not next_acc(N-1)   when (code = SUB_CODE) else
                     overflow_q;
                     
    next_carryBorrow <= '0' when (code = CARRY_CLR_CODE) else
                        '1' when (code = CARRY_SET_CODE) else
                        s_carry_rot when (code = ROT_CODE) else
                        s_carry_add when (code = ADD_CODE) else
                        s_carry_sub when (code = SUB_CODE) else
                        carryBorrow_q;
                                          
    next_negative <= next_acc(N-1);

    ---------------------------------------------------------------------------
    --  Operaciones de la ALU
    ---------------------------------------------------------------------------
    s_and <= acc_q and op;
    
    s_or <= acc_q or op;
    
    s_xor <= acc_q xor op;
    
    aux_rot <= carryBorrow_q & acc_q;
    
    after_rot <=    aux_rot                                         when (op = b"0000_0000") else
                    aux_rot (N-1 downto 0) & aux_rot(N)             when (op = b"0000_0001") else
                    aux_rot (N-2 downto 0) & aux_rot(N downto N-1)  when (op = b"0000_0010") else
                    aux_rot (N-3 downto 0) & aux_rot(N downto N-2)  when (op = b"0000_0011") else
                    aux_rot (N-4 downto 0) & aux_rot(N downto N-3)  when (op = b"0000_0100") else
                    aux_rot (N-5 downto 0) & aux_rot(N downto N-4)  when (op = b"0000_0101") else
                    aux_rot (N-6 downto 0) & aux_rot(N downto N-5)  when (op = b"0000_0110") else
                    aux_rot (N-7 downto 0) & aux_rot(N downto N-6)  when (op = b"0000_0111") else
                    aux_rot (N-8 downto 0) & aux_rot(N downto N-7)  when (op = b"0000_1000") else
                    aux_rot (N-8 downto 0) & aux_rot(N downto 1)    when (op = b"1111_1111") else
                    aux_rot (N-7 downto 0) & aux_rot(N downto 2)    when (op = b"1111_1110") else
                    aux_rot (N-6 downto 0) & aux_rot(N downto 3)    when (op = b"1111_1101") else
                    aux_rot (N-5 downto 0) & aux_rot(N downto 4)    when (op = b"1111_1100") else
                    aux_rot (N-4 downto 0) & aux_rot(N downto 5)    when (op = b"1111_1011") else
                    aux_rot (N-3 downto 0) & aux_rot(N downto 6)    when (op = b"1111_1010") else
                    aux_rot (N-2 downto 0) & aux_rot(N downto 7)    when (op = b"1111_1001") else
                    aux_rot (N-1 downto 0) & aux_rot(N downto 8)    when (op = b"1111_1000") else
                    aux_rot;
                      
    s_rot <= after_rot (N-1 downto 0);
    s_carry_rot <= after_rot (N);
                        
    
    aux_add_op  <=  '0' & op & carryBorrow_q; 
    aux_add_acc <=  '0' & acc_q & carryBorrow_q;
    
    aux_add_ans <=  std_logic_vector(signed(aux_add_acc) + signed(aux_add_op));
    aux_sub_ans <=  std_logic_vector(signed(aux_add_acc) - signed(aux_add_op));
    
    s_add <= aux_add_ans(N downto 1);
    s_carry_add <= aux_add_ans (N+1);
    
    s_sub <= aux_sub_ans(N downto 1);
    s_carry_sub <= aux_sub_ans (N+1);
    

end Behavioral;
