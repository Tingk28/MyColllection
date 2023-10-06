library verilog;
use verilog.vl_types.all;
library work;
entity kronos_csr is
    generic(
        BOOT_ADDR       : vl_logic_vector(31 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        EN_COUNTERS     : integer := 1;
        EN_COUNTERS64B  : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        decode          : in     work.kronos_types.\pipeIDEX_t\;
        csr_vld         : in     vl_logic;
        csr_rdy         : out    vl_logic;
        csr_data        : out    vl_logic_vector(31 downto 0);
        regwr_csr       : out    vl_logic;
        instret         : in     vl_logic;
        activate_trap   : in     vl_logic;
        return_trap     : in     vl_logic;
        trap_cause      : in     vl_logic_vector(31 downto 0);
        trap_value      : in     vl_logic_vector(31 downto 0);
        trap_handle     : out    vl_logic_vector(31 downto 0);
        trap_jump       : out    vl_logic;
        software_interrupt: in     vl_logic;
        timer_interrupt : in     vl_logic;
        external_interrupt: in     vl_logic;
        core_interrupt  : out    vl_logic;
        core_interrupt_cause: out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BOOT_ADDR : constant is 2;
    attribute mti_svvh_generic_type of EN_COUNTERS : constant is 1;
    attribute mti_svvh_generic_type of EN_COUNTERS64B : constant is 1;
end kronos_csr;
