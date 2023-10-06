library verilog;
use verilog.vl_types.all;
library work;
entity kronos_IF is
    generic(
        BOOT_ADDR       : vl_logic_vector(31 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        FAST_BRANCH     : integer := 0
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        instr_addr      : out    vl_logic_vector(31 downto 0);
        instr_data      : in     vl_logic_vector(31 downto 0);
        instr_req       : out    vl_logic;
        instr_ack       : in     vl_logic;
        fetch           : out    work.kronos_types.\pipeIFID_t\;
        immediate       : out    vl_logic_vector(31 downto 0);
        regrd_rs1       : out    vl_logic_vector(31 downto 0);
        regrd_rs2       : out    vl_logic_vector(31 downto 0);
        regrd_rs1_en    : out    vl_logic;
        regrd_rs2_en    : out    vl_logic;
        fetch_vld       : out    vl_logic;
        fetch_rdy       : in     vl_logic;
        branch_target   : in     vl_logic_vector(31 downto 0);
        branch          : in     vl_logic;
        regwr_data      : in     vl_logic_vector(31 downto 0);
        regwr_sel       : in     vl_logic_vector(4 downto 0);
        regwr_en        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BOOT_ADDR : constant is 2;
    attribute mti_svvh_generic_type of FAST_BRANCH : constant is 1;
end kronos_IF;
