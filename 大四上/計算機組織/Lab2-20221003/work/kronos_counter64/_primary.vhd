library verilog;
use verilog.vl_types.all;
entity kronos_counter64 is
    generic(
        EN_COUNTERS     : integer := 1;
        EN_COUNTERS64B  : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        incr            : in     vl_logic;
        load_data       : in     vl_logic_vector(31 downto 0);
        load_low        : in     vl_logic;
        load_high       : in     vl_logic;
        count           : out    vl_logic_vector(63 downto 0);
        count_vld       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of EN_COUNTERS : constant is 1;
    attribute mti_svvh_generic_type of EN_COUNTERS64B : constant is 1;
end kronos_counter64;
