library verilog;
use verilog.vl_types.all;
entity kronos_branch is
    port(
        op              : in     vl_logic_vector(2 downto 0);
        rs1             : in     vl_logic_vector(31 downto 0);
        rs2             : in     vl_logic_vector(31 downto 0);
        branch          : out    vl_logic
    );
end kronos_branch;
