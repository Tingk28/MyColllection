// Author : William Lee, CASLab, AISLab
// CO 2021
`include "Little_east.v"
`timescale 10ns/1ns

`define CYCLE 14
`define P_ID_0 32'd123
`define P_ID_1 32'd47
`define P_ID_2 32'd59
`define P_ID_3 32'd92

module tb();

reg clk,rst;
reg [31:0] person_id;
wire [31:0] person_done_id;

integer i;
reg [31:0] p_id [3:0];

little_east le(
    .clk(clk),
    .rst(rst),
    .person_id(person_id),
    .person_done_id(person_done_id)
);

initial begin
    rst = 1;
    clk = 0;
    p_id[0] = `P_ID_0;
    p_id[1] = `P_ID_1;
    p_id[2] = `P_ID_2;
    p_id[3] = `P_ID_3;

    #(`CYCLE) rst = 0;

    #(`CYCLE/2) person_id = p_id[0];
    for(i=1; i<4; i = i+1) begin
        #(`CYCLE) person_id = p_id[i];
    end

    #(`CYCLE * 2)
    if(person_done_id != (p_id[0])*16 ) 
        $display("clock peroid too short! expect person_done_id : %d, received : %d", p_id[i]*16, person_done_id);
    else
        $display("Vaccination complete, person_done_id : %d", person_done_id);

    for(i=1; i<4; i = i+1) begin
        #(`CYCLE) 
        if(person_done_id != (p_id[i])*16 ) 
            $display("clock peroid too short! expect person_done_id : %d, received : %d", p_id[i]*16, person_done_id);
        else
            $display("Vaccination complete, person_done_id : %d", person_done_id);
    end

    $stop;

end

always #(`CYCLE/2) clk = ~clk;

    
endmodule