module fa(input x,input y,input cin,output s,output cout);
wire and1,and2,xor1;
and and_1(and1,x,y);
xor xor_1(xor1,x,y);
and and_2(and2,cin,xor1);
xor xor_2(s,xor1,cin);
or or_1(cout,and1,and2);
endmodule
module Adder(input [7:0]x,input [7:0]y,input cin,output cout,output [7:0]s);
wire [6:0]a;
fa adder1(x[0],y[0],cin,s[0],a[0]);
fa adder2(x[1],y[1],a[0],s[1],a[1]);
fa adder3(x[2],y[2],a[1],s[2],a[2]);
fa adder4(x[3],y[3],a[2],s[3],a[3]);
fa adder5(x[4],y[4],a[3],s[4],a[4]);
fa adder6(x[5],y[5],a[4],s[5],a[5]);
fa adder7(x[6],y[6],a[5],s[6],a[6]);
fa adder8(x[7],y[7],a[6],s[7],cout);
endmodule

module eightand(output [7:0]s,input [7:0]x,input [7:0]y);
    and anda(s[0] ,x[0],y[0]);
    and andb(s[1] ,x[1],y[1]);
    and andc(s[2] ,x[2],y[2]);
    and andd(s[3] ,x[3],y[3]);
    and ande(s[4] ,x[4],y[4]);
    and andf(s[5] ,x[5],y[5]);
    and andg(s[6] ,x[6],y[6]);
    and andh(s[7] ,x[7],y[7]);

endmodule

module Mult(output [7:0]Product, input [3:0]Multiplier, input [3:0]Multiplicand, output mp);
    wire iin,oot;
    wire [7:0]temp;
    assign iin=0;
    wire [7:0]Mp;
    wire [7:0]temp2;
    wire [7:0]temp3;
    wire [7:0]temp4;
    wire [7:0]temp5;
    wire [7:0]temp6;
    wire [7:0]temp7;
    wire [7:0]temp8;
    wire [3:0] all0;
    assign all0 = 4'b0000;
    assign Mp={all0,Multiplier};
    assign mp = Mp;
    assign temp={8{Multiplier[0]}};
    eightand aaa(temp2,temp,Mp);
    Adder Adder0(.x(Product), .y(temp2), .cin(iin), .cout(oot), .s(Product));
    assign Mp=Mp<<1;
    assign temp3={8{Multiplier[1]}};
    eightand aab(temp4,temp3,Mp);
    Adder Adder1(.x(Product), .y(temp4), .cin(iin), .cout(oot), .s(Product));
    assign Mp=Mp<<1;
    assign temp5={8{Multiplier[2]}};
    eightand aac(temp6,temp5,Mp);
    Adder Adder2(.x(Product), .y(temp6), .cin(iin), .cout(oot), .s(Product));
    assign Mp=Mp<<1;
    assign temp7={8{Multiplier[3]}};
    eightand aad(temp8,temp7,Mp);
    Adder Adder3(.x(Product), .y(temp8), .cin(iin), .cout(oot), .s(Product));
    assign Mp=Mp<<1;
    
endmodule

module tb;
reg [3:0] m0, m1;
wire [7:0] o,mp;
integer  i, j, errno;
Mult mult0(
    .Multiplicand(m0), 
    .Multiplier(m1), 
    .Product(o),
    .mp(mp)
);
initial begin
    errno = 0;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            m0 = i;
            m1 = j;
            #1;
            if (o !== i * j) begin
                $display("Error: %d * %d should be %d instead of %d,mp:%b", m0, m1, i*j, o, mp);
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