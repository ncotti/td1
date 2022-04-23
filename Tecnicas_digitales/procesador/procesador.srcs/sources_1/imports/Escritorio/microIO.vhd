library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity microIO is
    generic (N : integer := 8);
    Port ( clk :    in  std_logic;
           rst :    in  std_logic;
           portRd : in  std_logic_vector (7 downto 0);           
           portWr : out std_logic_vector (7 downto 0));
end microIO;

architecture Behavioral of microIO is

component pc is
    Port ( clk :    in  std_logic;
           rst :    in  std_logic;                      
           ena :    in  std_logic;
           pl :     in  std_logic;
           addrPl : in  std_logic_vector (9 downto 0);
           data:    out std_logic_vector (31 downto 0)           
           );
end component;

component alu is
    generic (N : integer := 8);
    Port ( clk :        in  std_logic;                           -- Clock del sistema
           rst:         in  std_logic;                           -- Reset sincronico del sistema 
           ena:         in  std_logic;                           -- Habilita la realizacion de la operacion
           code:        in  std_logic_vector (3 downto 0);       -- Codigo de la operacion a realizar           
           op:          in  std_logic_vector (N-1 downto 0);     -- Operando
           acc:         out std_logic_vector (N-1 downto 0);    -- Acumulador           
           zero:        out std_logic;                         -- Acumulador en cero
           overflow:    out std_logic;                     -- Overflow
           carryBorrow: out std_logic;                  -- Carry/Borrow
           negative:    out std_logic                      -- Acumulador negativo
           );
end component;

component portIO is
    Port ( clk :        in  std_logic;
           rst :        in  std_logic;
           portRd :     in  std_logic_vector (7 downto 0);
           portRdReg :  out std_logic_vector (7 downto 0);
           portWrEna :  in  std_logic;
           portWr :     out std_logic_vector (7 downto 0);
           portWrReg :  in  std_logic_vector (7 downto 0));
end component;

component uc is
    generic (N : integer := 8);
    Port ( clk :            in  std_logic;
           rst :            in  std_logic;
           portRd :         in  std_logic_vector (7 downto 0);
           portWrEna :      out std_logic;
           portWr :         out std_logic_vector (7 downto 0);
           aluEna :         out std_logic;
           aluCode:         out std_logic_vector (3 downto 0);           
           aluOp  :         out std_logic_vector (N-1 downto 0);
           aluAcc :         in  std_logic_vector (N-1 downto 0);         
           aluZero :        in  std_logic;
           aluOverflow :    in  std_logic;
           aluCarryBorrow : in  std_logic;
           aluNegative :    in  std_logic;
           pcEna :          out std_logic;
           pcPl :           out std_logic;
           pcAddrPl :       out std_logic_vector (9 downto 0);
           pcData:          in  std_logic_vector (31 downto 0)  
           );
end component;

    -- Signals 
    signal pcEna :      std_logic;
    signal pcPl :       std_logic;
    signal pcAddrPl :   std_logic_vector (9 downto 0);
    signal pcData :     std_logic_vector (31 downto 0); 
    
    signal aluEna :         std_logic;
    signal aluCode:         std_logic_vector (3 downto 0);           
    signal aluOp  :         std_logic_vector (N-1 downto 0);
    signal aluAcc :         std_logic_vector (N-1 downto 0);           
    signal aluZero :        std_logic;
    signal aluOverflow :    std_logic;
    signal aluCarryBorrow : std_logic;
    signal aluNegative :    std_logic;

    -- PortIO --
    signal portRdReg : std_logic_vector (7 downto 0);
    signal portWrEna : std_logic;
    signal portWrReg : std_logic_vector (7 downto 0);

begin

pcInst: pc 
    port map ( clk      =>  clk,
               rst      =>  rst,                      
               ena      =>  pcEna,
               pl       =>  pcPl,
               addrPl   =>  pcAddrPl,
               data     =>  pcData);

aluInst: alu 
    generic map (N => N)
    Port map ( clk          =>  clk,
               rst          =>  rst, 
               ena          =>  aluEna,
               code         =>  aluCode,           
               op           =>  aluOp,
               acc          =>  aluAcc,           
               zero         =>  aluZero,
               overflow     =>  aluOverflow,
               carryBorrow  =>  aluCarryBorrow,
               negative     =>  aluNegative);

portIOInst: portIO
    Port map( clk       =>  clk,
              rst       =>  rst,
              portRd    =>  portRd,
              portRdReg =>  portRdReg,
              portWrEna =>  portWrEna,
              portWr    =>  portWr, 
              portWrReg =>  portWrReg);

ucInst: uc
    generic map (N => N)
    Port map (
        clk             =>  clk,
        rst             =>  rst,
        -- Ports --
        portRd          =>  portRdReg,
        portWrEna       =>  portWrEna,
        portWr          =>  portWrReg,
        -- Alu --
        aluEna          =>  aluEna,
        aluCode         =>  aluCode,           
        aluOp           =>  aluOp,
        aluAcc          =>  aluAcc,           
        aluZero         =>  aluZero,
        aluOverflow     =>  aluOverflow,
        aluCarryBorrow  =>  aluCarryBorrow,
        aluNegative     =>  aluNegative,
        -- PC --
        pcEna           =>  pcEna,
        pcPl            =>  pcPl,
        pcAddrPl        =>  pcAddrPl,
        pcData          =>  pcData
    );

end Behavioral;
