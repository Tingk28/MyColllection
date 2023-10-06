`include "Mult.v"

module tb;
reg [3:0] m0, m1;
wire [7:0] o;
integer  i, j, errno;
Mult mult0(
    .Multiplicand(m0), 
    .Multiplier(m1), 
    .Product(o)
);
initial begin
    errno = 0;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            m0 = i;
            m1 = j;
            #1;
            if (o !== i * j) begin
                $display("Error: %d * %d should be %d instead of %d", m0, m1, i*j, o);
                errno = errno + 1;
            end
        end
    end
    if (errno == 0) begin
        $display("\n");        
        $display(" (^\\-==-/^)");
        $display(" >\\\\ == //<");
        $display(":== q''p ==:     _");
        $display(" .__ qp __.    .' )");
        $display("  / ^--^ \\    /\\.'");
        $display(" /_`    / )  '\\/");
        $display(" (  )  \\  |-'-/");
        $display(" \\^^,   |-|--'");
        $display("( `'    |_| )");
        $display(" \\-     |-|/");
        $display("(( )^---( ))");
        $display("Congratulations!");
        $display("Simulation Passed!");
        $display("\n");       
        
    end
    
    else begin
        $display("Total Error: %d", errno);
    end
end
endmodule