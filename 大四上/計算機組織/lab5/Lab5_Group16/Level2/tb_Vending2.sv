`timescale 1ns/10ps
`define CYCLE      50.0  
`define End_CYCLE  1000000
`define PRODUCTNUM 2'd3
`define PATTERN    "test2.data"
`define GOLDEN     "golden2.data"

`include "Vending2.v"

module tb_Vending;

    // Register
    logic clk = 0;
    logic rst = 0;
    logic [7:0] DI;
    logic [7:0] MI;
    logic [1:0] sel;
    logic       re;
    logic [7:0] MO;
    logic [1:0] PO;

    // Test Module
    Vending u_Vending
    (
        .rst (rst),
        .clk (clk),
        .DI  (DI),
        .MI  (MI),
        .sel (sel),
        .re  (re),
        .MO  (MO),
        .PO  (PO)
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
    end

    initial 
    begin
        $fsdbDumpfile("tb_Vending.fsdb");
        $fsdbDumpvars("+struct", "+mda", tb_Vending);
    end

    integer fd;
    integer fg;
    logic [22:0] cycle=0;
    // Check whether in forever loop
    always @(posedge clk) 
    begin
        cycle = cycle + 1;
        if (cycle > `End_CYCLE) 
        begin
            $display("--------------------------------------------------");
            $display("-- Failed waiting valid signal, Simulation STOP --");
            $display("--------------------------------------------------");
            $fclose(fd);
            $finish;
        end
    end
    // Read test data
    initial 
    begin
        fd = $fopen(`PATTERN,"r");
        if (fd == 0) 
        begin
            $display ("pattern handle null");
            $finish;
        end
    end
    // Read Golden data
    initial 
    begin
        fg = $fopen(`GOLDEN,"r");
        if (fg == 0) 
        begin
            $display ("golden handle null");
            $finish;
        end
    end

    integer pass = 0;
    integer fail = 0;
    integer counter = 0;
    integer test = 0;
    string  testLine;
    logic [7:0] GMO;
    logic [1:0] GPO;
    
    always @(negedge clk)
    begin
        if (rst)
        begin
            DI = 0;
            MI = 0;
            sel = 0;
            GMO = 0;
            GPO = 0;
        end
        else 
        begin
            if (!$feof(fd) || !$feof(fg))
            begin
                test = $fgets (testLine, fd);
                if (test != 0)
                begin
                    while (testLine.substr(0, 1) == "//")
                    begin
                        // $display("%s", testLine);
                        test = $fgets (testLine, fd);
                    end
                    if (counter < `PRODUCTNUM)
                    begin
                        test = $sscanf(testLine, "%d", DI);
                        // $display("%d", DI);
                        counter = counter + 1;
                    end
                    else 
                    begin
                        test = $sscanf(testLine, "%d %d %d", MI, sel, re);
                        // $display("%d, %d", MI, sel);
                    end
                end
            end
            else 
            begin
                $fclose(fd);
                $fclose(fg);
                if (fail === 0)
                begin
                    $display("\n");
                    $display("\n");
                    $display("        ****************************    .--.       ");
                    $display("        **  Congratulations !!    **   / _.-' .-.  ");
                    $display("        **  Simulation2 PASS!!    **   \\  '-. '-' ");
                    $display("        ****************************    '--'       ");
                    $display("\n");
                end
                else
                begin
                    $display("\n");
                    $display("\n");
                    $display("        ****************************    .-.   .-. ");
                    $display("        **  OOPS!!                **   | OO| | OO|");
                    $display("        **  Simulation2 Failed!!  **   |   | |   |");
                    $display("        ****************************   '^^^' '^^^'");
                    $display("         Totally has %d errors                     ", fail); 
                    $display("\n");
                end
                $finish;
            end
        end
    end

    integer testNumber = 0;
    integer lineNumber = 0;
    integer golden = 0;
    string  goldenLine;

    always @(posedge clk)
    begin
        if (!$feof(fg) || !$feof(fd))
        begin
            golden = $fgets (goldenLine, fg);
            if (golden != 0)
            begin
                while (goldenLine.substr(0, 1) == "//")
                begin
                    // $display("%s", goldenLine);
                    $sscanf(goldenLine, "// Test %0d", testNumber);
                    lineNumber = 0;
                    golden = $fgets (goldenLine, fg);
                end
                lineNumber = lineNumber + 1;
                golden = $sscanf(goldenLine, "%d %d", GMO, GPO);
                if (rst == 0) 
                begin
                    if ((MO == GMO) && (PO == GPO))
                    begin
                        pass = pass + 1;
                    end
                    else 
                    begin
                        $display("\n[Test %2d line %2d]\n\tOutput Change = %d, Product = %d\n\tExpect Change = %d, Product = %d",
                                testNumber, lineNumber, MO, PO, GMO, GPO);
                        fail = fail + 1;    
                    end
                end
            end
        end
    end
endmodule