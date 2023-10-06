library verilog;
use verilog.vl_types.all;
entity kronos_alu is
    port(
        op1             : in     vl_logic_vector(31 downto 0);
        op2             : in     vl_logic_vector(31 downto 0);
        aluop           : in     vl_logic_vector(3 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end kronos_alu;
