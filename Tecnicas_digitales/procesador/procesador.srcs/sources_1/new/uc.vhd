library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.functions.all;
use work.constants.all;

entity uc is
    Generic (N: integer := 8);
    Port ( clk :            in  STD_LOGIC;
           rst :            in  STD_LOGIC;
           portRd :         in  STD_LOGIC_VECTOR (7 downto 0);
           portWrEna :      out STD_LOGIC;
           portWr :         out STD_LOGIC_VECTOR (7 downto 0);
           aluEna :         out STD_LOGIC;
           aluCode :        out STD_LOGIC_VECTOR (3 downto 0);
           aluOp :          out STD_LOGIC_VECTOR (N-1 downto 0);
           aluAcc :         in  STD_LOGIC_VECTOR (N-1 downto 0);
           aluZero :        in  STD_LOGIC;
           aluOverflow :    in  STD_LOGIC;
           aluCarryBorrow : in  STD_LOGIC;
           aluNegative :    in  STD_LOGIC;
           pcEna :          out STD_LOGIC;
           pcPl :           out STD_LOGIC;
           pcAddrPl :       out STD_LOGIC_VECTOR (9 downto 0);
           pcData :         in  STD_LOGIC_VECTOR (31 downto 0));
end uc;

architecture Behavioral of uc is

    ---------------------------------------------------------------------------
    --  RAM
    ---------------------------------------------------------------------------
    COMPONENT ramMem
    PORT (
        clka :  IN  STD_LOGIC;
        wea :   IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
        dina :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;
    
    signal ramDataRd :  std_logic_vector (7 downto 0);
    signal ramDataWea : std_logic_vector (0 downto 0);
    signal ramDataWr :  std_logic_vector (7 downto 0);
    signal ramAddr :    std_logic_vector (9 downto 0);
    
    ---------------------------------------------------------------------------
    --  Señales auxiliares
    ---------------------------------------------------------------------------
    signal op_code:     std_logic_vector(3 downto 0);
    signal op_lit:      std_logic_vector(7 downto 0);
    signal op_mem:      std_logic_vector(9 downto 0);
    signal op_alu_code: std_logic;
    signal op_type :    std_logic_vector (1 downto 0); 
    signal output :     std_logic_vector (4 downto 0);
    
    ---------------------------------------------------------------------------
    --  Estados de la máquina de estados
    ---------------------------------------------------------------------------
    signal state, next_state : state_type;
    
begin

    ramMem_inst : ramMem
    PORT MAP (
        clka    =>  clk,
        wea     =>  ramDataWea,
        addra   =>  ramAddr,
        dina    =>  ramDataWr,
        douta   =>  ramDataRd
    );
    
    ---------------------------------------------------------------------------
    --  Desglosamos el dato de la ROM.
    ---------------------------------------------------------------------------
    op_code     <= pcData (19 downto 16);
    op_lit      <= pcData (7 downto 0);
    op_mem      <= pcData (9 downto 0);
    op_alu_code <= pcData(10);
    op_type     <= pcData(21 downto 20);
    
    ---------------------------------------------------------------------------
    --  Asigno las salidas de la máquina de estados.
    ---------------------------------------------------------------------------
    pcEna       <= output(4);
    pcPl        <= output(3);
    aluEna      <= output(2);
    ramDataWea  <= output(1 downto 1);
    portWrEna   <= output(0);
    
    ---------------------------------------------------------------------------
    --  Lógica combinacional independiente del estado
    ---------------------------------------------------------------------------
    aluCode <= op_code;
    
    aluOp <= op_lit     when (op_alu_code = ALU_CODE_LIT) else
             ramDataRd;
             
    pcAddrPl <= op_mem;
    
    ramDataWr <= portRd when (op_code = MOV_CODE_READ_PORT) else
                 aluAcc when (op_code = MOV_CODE_ACC)       else
                 (others => '0');
                 
    ramAddr <= op_mem;
    
    portWr <= ramDataRd;
      

    ---------------------------------------------------------------------------
    --  Asignación de estados.
    ---------------------------------------------------------------------------
    SYNC_PROC: process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= st_RST;
            else
                state <= next_state;
         end if;
      end if;
    end process;
    
    
    ---------------------------------------------------------------------------
    --  Lógica de salida (Máquina Mealy, la salida depende de la entrada)
    --  La salida es "00000" donde
    --      out(4) = pcEna
    --      out(3) = pcPl
    --      out(2) = aluEna
    --      out(1) = ramDataWea
    --      out(0) = portWrEna
    ---------------------------------------------------------------------------
    OUTPUT_DECODE: process (state, op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative)
    begin
        
        if  state = st_RST          or
            state = st_NOP          or
            state = st_ALU_OP       or
            state = st_JMP          or
            state = st_WRITE_RAM    or
            state = st_WRITE_PORT   then
            
            output <= next_op_output (op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
              
        elsif state <= st_ALU_READ_MEM then
            output <= "10100";
    
        elsif state <= st_READ_RAM_TO_WRITE_PORT then
            output <= "10001";
            
        else
            output <= "00000";    
        end if;
   end process;

   ---------------------------------------------------------------------------
   --  Lógica de estado futuro.
   ---------------------------------------------------------------------------
   NEXT_STATE_DECODE: process (state, op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative)
   begin
      next_state <= state;  
      
      case (state) is
         when st_RST =>
            next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
            
        when st_NOP =>
            next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
                        
        when st_ALU_OP =>
           next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
               
        when st_ALU_READ_MEM =>
            next_state <= st_ALU_OP;
        
        when st_JMP =>
            next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);            
            
        when st_WRITE_RAM =>
            next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
        
        when st_READ_RAM_TO_WRITE_PORT =>
            next_state <= st_WRITE_PORT;
        
        when st_WRITE_PORT =>
            next_state <= next_op(op_type, op_code, op_alu_code, aluZero, aluOverflow, aluCarryBorrow, aluNegative);
                         
        when others =>
            next_state <= st_RST;
      end case;
   end process;


end Behavioral;
