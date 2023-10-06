library verilog;
use verilog.vl_types.all;
library work;
entity kronos_EX is
    generic(
        BOOT_ADDR       : vl_logic_vector(31 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        EN_COUNTERS     : integer := 1;
        EN_COUNTERS64B  : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        decode          : in     work.kronos_types.\pipeIDEX_t\;
        decode_vld      : in     vl_logic;
        decode_rdy      : out    vl_logic;
        regwr_data      : out    vl_logic_vector(31 downto 0);
        regwr_sel       : out    vl_logic_vector(4 downto 0);
        regwr_en        : out    vl_logic;
        branch_target   : out    vl_logic_vector(31 downto 0);
        branch          : out    vl_logic;
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
    attribute mti_svvh_generic_type of EN_COUNTERS : constant is 1;
    attribute mti_svvh_generic_type of EN_COUNTERS64B : constant is 1;
end kronos_EX;
