// Moore Good
module Moore(clk, rst, In_Data, Out_Data);
    input clk, rst, In_Data;
    output [1:0] Out_Data;
    reg [1:0] Out_Data;
    reg [1:0] State, NextState;
    parameter S0 = 2'b00, S1 = 2'b01,
              S2 = 2'b10, S3 = 2'b11;
    // State Register (Flip-Flops)
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            State <= S0;
        else
            State <= NextState;
    end
    // Next State Logic
    always @(In_Data or State)
    begin
        case(State)
            S0: 
            begin
                if(In_Data == 1)
                    NextState = S2;
                else
                    NextState = S0;
            end
            S1:
            begin
                if(In_Data == 1)
                    NextState = S2;
                else
                    NextState = S0;
            end
            S2: 
            begin
                if(In_Data == 1)
                    NextState = S3;
                else
                    NextState = S2;
            end
            S3: 
            begin
                if(In_Data == 1)
                    NextState = S1;
                else
                    NextState = S3;
            end
        endcase
    end
    // Output Logic
    always @(State)
    begin
        case(State)
            S0:Out_Data = 0;
            S1:Out_Data = 1;
            S2:Out_Data = 1;
            S3:Out_Data = 0;
        endcase
    end
endmodule