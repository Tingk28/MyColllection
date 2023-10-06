library verilog;
use verilog.vl_types.all;
entity kronos_RF is
    port(
        clk             : in     vl_logic;
        rstz            : in     vl_logic;
        instr_data      : in     vl_logic_vector(31 downto 0);
        instr_vld       : in     vl_logic;
        fetch_rdy       : in     vl_logic;
        immediate       : out    vl_logic_vector(31 downto 0);
        regrd_rs1       : out    vl_logic_vector(31 downto 0);
        regrd_rs2       : out    vl_logic_vector(31 downto 0);
        regrd_rs1_en    : out    vl_logic;
        regrd_rs2_en    : out    vl_logic;
        regwr_data      : in     vl_logic_vector(31 downto 0);
        regwr_sel       : in     vl_logic_vector(4 downto 0);
        regwr_en        : in     vl_logic
    );
end kronos_RF;
