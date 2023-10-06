module Vending(
    clk,
    rst,
    DI,
    MI,
    sel,
    re,
    MO,
    PO,
    empty
);
    input clk;
    input rst;
    input [7:0] DI;
    input [7:0] MI;
    input [1:0] sel;
    input       re;
    output reg [7:0] MO;
    output reg [1:0] PO;
    output reg empty;

    // Complete this part by yourself
	integer i;
	reg [3:0]count;
    reg [7:0]price[5:0];
	reg [7:0]money;
	//parameter Defalut=2'b00,A=2'b01,B=2'b10,C=2'b11;
	//reg [1:0]state;
always@(negedge rst)// reset
begin
	count=3'b0;
	MO=0;
	PO=0;
	money = 8'b0;
	empty = 1'b0;
	for(i=0;i<6;i=i+1)
		price[i]=8'b0;	
end

always@(posedge clk)
begin
	// set price and amount
	if(count<6)
	begin
		price[count]=DI;
		count=count+3'b001;
	end
	//set price end
	else if(price[1] + price[3] +price[5] == 0)
	begin
		empty = 1'b1;
	end
	
	money=money+MI;//money insert 
	
	if(re || empty)//refund
	begin
		PO = 0;
		MO = money;
		money= 0;
	end
	else if(sel!=0)// item select
	begin
		if(sel==1)
		begin
			if(money>=price[0])
			begin
				if(price[1]>0) // still have inventory
				begin
					PO=1;
					MO=money-price[0];
					money = 0 ;
					price[1] = price[1]-1;
				end
				else
				begin
					MO=0;
					PO=0;
				end
			end
			else
			begin
				PO=0;
				MO=0;
			end
		end
		if(sel==2)
		begin
			if(money>=price[2])
			begin
				if(price[3]>0)
				begin
					PO=2;
					MO=money-price[2];
					money = 0 ;
					price[3] = price[3]-1;
				end
				else
				begin
					MO=0;
					PO=0;
				end
			end
			else 
			begin
				PO=0;
				MO=0;
			end
		end
		if(sel==3)
		begin
			if(money>=price[4])
			begin
				if(price[5]>0)
				begin
					PO=3;
					MO=money-price[4];
					money = 0 ;
					price[5] = price[5]-1;
				end
				else
				begin
					MO=0;
					PO=0;
				end
			end
			else 
			begin
				PO=0;
				MO=0;
			end
		end
	end
	else //don't select anything
	begin
		MO=0;
		PO=0;
	end
	if(price[1] + price[3] +price[5] == 0 && count == 6)
	begin
		empty = 1'b1;
	end
end
endmodule