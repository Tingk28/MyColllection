module singlemulti (input reg [2:0] index,input reg [7:0] dina,dinb,input reg [15:0] temp,output wire [15:0] dout0);
	reg [15:0] result;
	always@(*)
		begin
		result = 0;
		if (dinb[index] == 1)
		begin
			result = (dina <<index) + temp;
		end
		else result = temp;	
	end
	assign dout0 = result;
	
endmodule