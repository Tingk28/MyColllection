`timescale 1ns/10ps
`define CYCLE      50.0  
`define End_CYCLE  1000000

module singlemulti (input reg [2:0] index,input reg [7:0] dina,dinb,input reg [15:0] temp,output reg [15:0]dout);
	always@(*)
		begin
		if (dinb[index] == 1)
		begin
			dout = (dina <<index) + temp;
		end
		else dout = temp;
	end
endmodule

module multi(input clk,input reset,input [7:0] din1,din2, output reg [15:0] dout);
reg [15:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
reg [7:0] dina0,dina1,dina2,dina3,dina4,dina5,dina6,dina7;
reg [7:0] dinb0,dinb1,dinb2,dinb3,dinb4,dinb5,dinb6,dinb7;
//singlemulti multi0,multi1,multi2,multi3,multi4,multi5,multi6,multi7;
singlemulti multi0(.index(3'b 000),.dina(dina0),.dinb(dinb0),.temp(temp0),.dout(temp1));
singlemulti multi1(.index(3'b 001),.dina(dina1),.dinb(dinb1),.temp(temp1),.dout(temp2));
singlemulti multi2(.index(3'b 010),.dina(dina2),.dinb(dinb2),.temp(temp2),.dout(temp3));
singlemulti multi3(.index(3'b 011),.dina(dina3),.dinb(dinb3),.temp(temp3),.dout(temp4));
singlemulti multi4(.index(3'b 100),.dina(dina4),.dinb(dinb4),.temp(temp4),.dout(temp5));
singlemulti multi5(.index(3'b 101),.dina(dina5),.dinb(dinb5),.temp(temp5),.dout(temp6));
singlemulti multi6(.index(3'b 110),.dina(dina6),.dinb(dinb6),.temp(temp6),.dout(temp7));
singlemulti multi7(.index(3'b 111),.dina(dina7),.dinb(dinb7),.temp(temp7),.dout(dout));
always@(negedge reset)
begin
	temp0 = 0;
	temp1 = 0;
	temp2 = 0;
	temp3 = 0;
	temp4 = 0;
	temp5 = 0;
	temp6 = 0;
	temp7 = 0;
end
always@(posedge clk)//under each cycle
begin
	temp0=0;
	dina7 = dina6;
	dinb7 = dinb6;
	dina6 = dina5;
	dinb6 = dinb5;
	dina5 = dina4;
	dinb5 = dinb4;
	dina4 = dina3;
	dinb4 = dinb3;
	dina3 = dina2;
	dinb3 = dinb2;
	dina2 = dina1;
	dinb2 = dinb1;
	dina1 = dina0;
	dinb1 = dinb0;
	
	dina0 = din1;
	dinb0 = din2;
	
end

endmodule

module tb;

reg [7:0] m0, m1;
wire [15:0] o;
integer  i, j, errno;
reg[0:0] rst = 0;

multi mult0(
    .din1(m0), 
    .din2(m1), 
    .dout(o),
	.clk(clk),
	.reset(rst)
);
initial 
begin
	$display("----------------------");
	$display("-- Simulation Start --");
	$display("----------------------");
	rst = 1'b1; 
	#(`CYCLE*2);  
	@(posedge clk); #2 rst = 1'b0;
end

initial begin
    errno = 0;
    for (i = 0; i < 256; i = i + 1) begin
        for (j = 0; j < 256; j = j + 1) begin
            m0 = i;
            m1 = j;
            #1;
			i = i+1;
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