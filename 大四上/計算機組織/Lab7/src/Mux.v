module Mux(
    input [31:0] in_0,
    input [31:0] in_1,
    input sel,
    output [31:0] o
);
    assign o = sel ? in_1 : in_0;
endmodule