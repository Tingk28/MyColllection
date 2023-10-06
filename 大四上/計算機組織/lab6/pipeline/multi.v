`include "singlemulti.v"
module multi(input clk,input [7:0] din1,din2, output wire [15:0] dout);
wire [15:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
reg [15:0] tempreg0,tempreg1,tempreg2,tempreg3,tempreg4,tempreg5,tempreg6,tempreg7;
reg [7:0] dina0,dina1,dina2,dina3,dina4,dina5,dina6,dina7;
reg [7:0] dinb0,dinb1,dinb2,dinb3,dinb4,dinb5,dinb6,dinb7;
initial
begin
dina0 = 0;
dina1 = 0;
dina2 = 0;
dina3 = 0;
dina4 = 0;
dina5 = 0;
dina6 = 0;
dina7 = 0;

dinb0 = 0;
dinb1 = 0;
dinb2 = 0;
dinb3 = 0;
dinb4 = 0;
dinb5 = 0;
dinb6 = 0;
dinb7 = 0;

tempreg0 = 0;
tempreg1 = 0;
tempreg2 = 0;
tempreg3 = 0;
tempreg4 = 0;
tempreg5 = 0;
tempreg6 = 0;
tempreg7 = 0;

end

assign temp0 = 16'b0;
/*assign temp1 = 16'b0;
assign temp2 = 16'b0;
assign temp3 = 16'b0;
assign temp4 = 16'b0;
assign temp5 = 16'b0;
assign temp6 = 16'b0;
assign temp7 = 16'b0;
*/

//singlemulti multi0,multi1,multi2,multi3,multi4,multi5,multi6,multi7;
singlemulti multi0(.index(3'b 000),.dina(dina0),.dinb(dinb0),.temp(temp0),.dout0(temp1));
singlemulti multi1(.index(3'b 001),.dina(dina1),.dinb(dinb1),.temp(tempreg1),.dout0(temp2));
singlemulti multi2(.index(3'b 010),.dina(dina2),.dinb(dinb2),.temp(tempreg2),.dout0(temp3));
singlemulti multi3(.index(3'b 011),.dina(dina3),.dinb(dinb3),.temp(tempreg3),.dout0(temp4));
singlemulti multi4(.index(3'b 100),.dina(dina4),.dinb(dinb4),.temp(tempreg4),.dout0(temp5));
singlemulti multi5(.index(3'b 101),.dina(dina5),.dinb(dinb5),.temp(tempreg5),.dout0(temp6));
singlemulti multi6(.index(3'b 110),.dina(dina6),.dinb(dinb6),.temp(tempreg6),.dout0(temp7));
singlemulti multi7(.index(3'b 111),.dina(dina7),.dinb(dinb7),.temp(tempreg7),.dout0(dout));



always@(posedge clk)//under each cycle
begin
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
	
	tempreg7 = temp7;
	tempreg6 = temp6;
	tempreg5 = temp5;
	tempreg4 = temp4;
	tempreg3 = temp3;
	tempreg2 = temp2;
	tempreg1 = temp1;
	
	dina0 = din1;
	dinb0 = din2;
	
end

endmodule
