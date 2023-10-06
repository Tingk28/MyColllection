library verilog;
use verilog.vl_types.all;
entity spsram32_model is
    generic(
        WORDS           : integer := 4096;
        AWIDTH          : integer := 32;
        MASK_WR_ONLY    : vl_logic := Hi0
    );
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector;
        wdata           : in     vl_logic_vector(31 downto 0);
        rdata           : out    vl_logic_vector(31 downto 0);
        en              : in     vl_logic;
        wr_en           : in     vl_logic;
        mask            : in     vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORDS : constant is 1;
    attribute mti_svvh_generic_type of AWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MASK_WR_ONLY : constant is 2;
end spsram32_model;
