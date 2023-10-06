module fa(input x,input y,input cin,output s,output cout);
assign {cout,s}=x+y+cin;
endmodule

module Adder(
           input [31:0] x,
           input [31:0] y,
           input cin,
           output [31:0] s,
           output cout
       );
wire [30:0]a;//31bit

fa adder1(x[0],y[0],cin,s[0],a[0]);
fa adder2(x[1],y[1],a[0],s[1],a[1]);
fa adder3(x[2],y[2],a[1],s[2],a[2]);
fa adder4(x[3],y[3],a[2],s[3],a[3]);
fa adder5(x[4],y[4],a[3],s[4],a[4]);
fa adder6(x[5],y[5],a[4],s[5],a[5]);
fa adder7(x[6],y[6],a[5],s[6],a[6]);
fa adder8(x[7],y[7],a[6],s[7],a[7]);
fa adder9(x[8],y[8],a[7],s[8],a[8]);
fa adder10(x[9],y[9],a[8],s[9],a[9]);
fa adder11(x[10],y[10],a[9],s[10],a[10]);
fa adder12(x[11],y[11],a[10],s[11],a[11]);
fa adder13(x[12],y[12],a[11],s[12],a[12]);
fa adder14(x[13],y[13],a[12],s[13],a[13]);
fa adder15(x[14],y[14],a[13],s[14],a[14]);
fa adder16(x[15],y[15],a[14],s[15],a[15]);
fa adder17(x[16],y[16],a[15],s[16],a[16]);
fa adder18(x[17],y[17],a[16],s[17],a[17]);
fa adder19(x[18],y[18],a[17],s[18],a[18]);
fa adder20(x[19],y[19],a[18],s[19],a[19]);
fa adder21(x[20],y[20],a[19],s[20],a[20]);
fa adder22(x[21],y[21],a[20],s[21],a[21]);
fa adder23(x[22],y[22],a[21],s[22],a[22]);
fa adder24(x[23],y[23],a[22],s[23],a[23]);
fa adder25(x[24],y[24],a[23],s[24],a[24]);
fa adder26(x[25],y[25],a[24],s[25],a[25]);
fa adder27(x[26],y[26],a[25],s[26],a[26]);
fa adder28(x[27],y[27],a[26],s[27],a[27]);
fa adder29(x[28],y[28],a[27],s[28],a[28]);
fa adder30(x[29],y[29],a[28],s[29],a[29]);
fa adder31(x[30],y[30],a[29],s[30],a[30]);
fa adder32(x[31],y[31],a[30],s[31],cout);

endmodule
