// Author : William Lee, CASLab, AISLab
// CO 2021
`timescale 10ns/1ns

module Stage(
    input clk,rst,
    input [31:0] p_id_in,
    output reg [31:0] p_id_out_reg
);
parameter delay = 0;

reg [31:0] p_id_out;

always @(posedge clk) begin
    if(rst) p_id_out_reg <= 32'd0;
    else begin
        p_id_out_reg <= p_id_out;
    end
end

always @(*) begin
    #(delay) p_id_out = p_id_in + p_id_in;
end
    
endmodule