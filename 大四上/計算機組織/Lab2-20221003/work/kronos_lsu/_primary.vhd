library verilog;
use verilog.vl_types.all;
library work;
entity kronos_lsu is
    port(
        decode          : in     work.kronos_types.\pipeIDEX_t\;
        lsu_vld         : in     vl_logic;
        lsu_rdy         : out    vl_logic;
        load_data       : out    vl_logic_vector(31 downto 0);
        regwr_lsu       : out    vl_logic;
        data_addr       : out    vl_logic_vector(31 downto 0);
        data_rd_data    : in     vl_logic_vector(31 downto 0);
        data_wr_data    : out    vl_logic_vector(31 downto 0);
        data_mask       : out    vl_logic_vector(3 downto 0);
        data_wr_en      : out    vl_logic;
        data_req        : out    vl_logic;
        data_ack        : in     vl_logic
    );
end kronos_lsu;
