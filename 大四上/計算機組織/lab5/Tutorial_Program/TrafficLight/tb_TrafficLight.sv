`timescale 1ns/10ps
`define CYCLE      10.0 

module tb_TrafficLight;

    // Register
    logic clk = 0;
    logic rst = 0;
    logic Green;
    logic Yellow;
    logic Red;

    // Test Module Traffic Light
    TrafficLight traffic
    (
        .clk(clk), 
        .rst(rst), 
        .Red(Red), 
        .Green(Green), 
        .Yellow(Yellow)
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
        #(`CYCLE*15);
        $finish;
    end
endmodule