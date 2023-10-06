library verilog;
use verilog.vl_types.all;
entity kronos_agu is
    generic(
        CATCH_MISALIGNED_JMP: integer := 1;
        CATCH_MISALIGNED_LDST: integer := 1
    );
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        base            : in     vl_logic_vector(31 downto 0);
        offset          : in     vl_logic_vector(31 downto 0);
        addr            : out    vl_logic_vector(31 downto 0);
        misaligned_jmp  : out    vl_logic;
        misaligned_ldst : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_JMP : constant is 1;
    attribute mti_svvh_generic_type of CATCH_MISALIGNED_LDST : constant is 1;
end kronos_agu;
