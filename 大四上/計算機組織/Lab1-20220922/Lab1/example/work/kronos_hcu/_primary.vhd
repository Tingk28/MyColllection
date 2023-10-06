library verilog;
use verilog.vl_types.all;
entity kronos_hcu is
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        flush           : in     vl_logic;
        instr           : in     vl_logic_vector(31 downto 0);
        regrd_rs1_en    : in     vl_logic;
        regrd_rs2_en    : in     vl_logic;
        fetch_vld       : in     vl_logic;
        fetch_rdy       : in     vl_logic;
        regwr_sel       : in     vl_logic_vector(4 downto 0);
        regwr_en        : in     vl_logic;
        stall           : out    vl_logic
    );
end kronos_hcu;
