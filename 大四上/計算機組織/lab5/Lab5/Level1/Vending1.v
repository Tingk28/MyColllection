module Vending(
    clk,
    rst,
    DI,
    MI,
    sel,
    MO,
    PO
);
    input clk;
    input rst;
    input [7:0] DI;
    input [7:0] MI;
    input [1:0] sel;
    output [7:0] MO;
    output [1:0] PO;
    
    // Complete this part by yourself
	integer i;
	reg [1:0]count;
    	reg [7:0]price[2:0];
	reg [7:0]money;
	//parameter Defalut=2'b00,A=2'b01,B=2'b10,C=2'b11;
	//reg [1:0]state;
always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		count=2'b0;
		MO=0;
		PO=0;
		for(i=0;i<3;i=i+1)
			price[i]=8'b0;
	end
	else
	begin
		MO=MO;
		PO=PO;
	end		
end
always@(posedge clk)
begin
	if(count==0)
	begin
		price[0]=DI;
		count=count+2'b1;
	end
	else if(count==1)
	begin
		price[1]=DI;
		count=count+2'b1;
	end
	else if(count==2)
	begin
		price[2]=DI;
		count=count+2'b1;
	end
end
always@(posedge clk)
begin
	money=money+MI;
	if(sel!=0)
	begin
		if(sel==1)
		begin
			if(money>=price[0])
			begin
				PO=1;
				MO=money-price[0];
			end
			else 
			begin
				PO=0;
				MO=0;
			end
		end
		if(sel==2)
		begin
			if(money>=price[1])
			begin
				PO=2;
				MO=money-price[1];
			end
			else 
			begin
				PO=0;
				MO=0;
			end
		end
		if(sel==3)
		begin
			if(money>=price[2])
			begin
				PO=3;
				MO=money-price[2];
			end
			else 
			begin
				PO=0;
				MO=0;
			end
		end
	end
	else 
	begin
		MO=0;
		PO=0;
	end
end	
endmodule