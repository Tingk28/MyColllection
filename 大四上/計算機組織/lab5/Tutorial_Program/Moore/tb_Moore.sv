`timescale 1ns/10ps
`define CYCLE      10.0 

module tb_Moore;

    // Register
    logic clk = 0;
    logic rst = 0;
    logic DI;
    logic [1:0] DO;

    // Test Module Moore
    Moore moore
    (
        .clk(clk),
        .rst(rst),
        .In_Data(DI),
        .Out_Data(DO)
    );

    // System Clock
    always 
    begin 
        #(`CYCLE/2) clk = ~clk; 
    end

    // Initialization
    initial 
    begin
        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");
        rst = 1'b1; 
        #(`CYCLE*2);  
        @(posedge clk); #2 rst = 1'b0;
        // Test Input
        #(`CYCLE/2 - 2) DI = 0; // S0
        #(`CYCLE)   DI = 1; // S2
        #(`CYCLE)   DI = 0; // S2
        #(`CYCLE)   DI = 1; // S3
        #(`CYCLE)   DI = 0; // S3
        #(`CYCLE)   DI = 1; // S1
        #(`CYCLE)   DI = 1; // S2
        #(`CYCLE)   DI = 1; // S3
        #(`CYCLE)   DI = 1; // S1
        #(`CYCLE)   DI = 0; // S0
        #(`CYCLE)   DI = 0; // S0
        $finish;
    end
endmodule