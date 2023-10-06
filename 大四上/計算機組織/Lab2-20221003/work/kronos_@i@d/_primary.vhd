library verilog;
use verilog.vl_types.all;
library work;
entity kronos_ID is
    generic(
        CATCH_ILLEGAL_INSTR: integer := 1;
        CATCH_MISALIGNED_JMP: integer := 1;
        CATCH_MISALIGNED_LDST: integer := 1
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        flush           : in     vl_logic;
        fetch           : in     work.kronos_types.\pipeIFID_t\;
        immediate       : in     vl_logic_vector(31 downto 0);
        regrd_rs1       : in     vl_logic_vector(31 downto 0);
        regrd_rs2       : in     vl_logic_vector(31 downto 0);
        regrd_rs1_en    : in     vl_logic;
        regrd_rs2_en    : in     vl_logic;
        fetch_vld       : in     vl_logic;
        fetch_rdy       : out    vl_logic;
        decode          : out    work.kronos_types.\pipeIDEX_t\;
        decode_vld      : out    vl_logic;
        decode_rdy      : in     vl_logic;
        regwr_data      : in     vl_logic_vector(31 downto 0);
        regwr_sel       : in     vl_logic_vector(4 downto 0);
        regwr_en        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CATCH_ILLEGAL_INSTR : constant is 1;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_JMP : constant is 1;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_LDST : constant is 1;
end kronos_ID;
