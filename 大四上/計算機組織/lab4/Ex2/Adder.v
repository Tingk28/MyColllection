module FA(output cout, output s, input x, input y, input cin);
	assign cout = (x&y) | (cin &(x^y));
	assign s = cin ^ x ^y ;
end module

module Adder(output cout2, output [3:0]sum, input a, input b, input c);
	wire precount;
	sum [0] = FA(.cout(precount), 
	sum [1] = 
	sum [2] = 
	sum [3] = 
	assign sum = 