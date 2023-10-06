library verilog;
use verilog.vl_types.all;
entity kronos_core is
    generic(
        BOOT_ADDR       : vl_logic_vector(31 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        FAST_BRANCH     : integer := 1;
        EN_COUNTERS     : integer := 1;
        EN_COUNTERS64B  : integer := 1;
        CATCH_ILLEGAL_INSTR: integer := 1;
        CATCH_MISALIGNED_JMP: integer := 1;
        CATCH_MISALIGNED_LDST: integer := 1
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        instr_addr      : out    vl_logic_vector(31 downto 0);
        instr_data      : in     vl_logic_vector(31 downto 0);
        instr_req       : out    vl_logic;
        instr_ack       : in     vl_logic;
        data_addr       : out    vl_logic_vector(31 downto 0);
        data_rd_data    : in     vl_logic_vector(31 downto 0);
        data_wr_data    : out    vl_logic_vector(31 downto 0);
        data_mask       : out    vl_logic_vector(3 downto 0);
        data_wr_en      : out    vl_logic;
        data_req        : out    vl_logic;
        data_ack        : in     vl_logic;
        software_interrupt: in     vl_logic;
        timer_interrupt : in     vl_logic;
        external_interrupt: in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BOOT_ADDR : constant is 2;
    attribute mti_svvh_generic_type of FAST_BRANCH : constant is 1;
    attribute mti_svvh_generic_type of EN_COUNTERS : constant is 1;
    attribute mti_svvh_generic_type of EN_COUNTERS64B : constant is 1;
    attribute mti_svvh_generic_type of CATCH_ILLEGAL_INSTR : constant is 1;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_JMP : constant is 1;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_LDST : constant is 1;
end kronos_core;
