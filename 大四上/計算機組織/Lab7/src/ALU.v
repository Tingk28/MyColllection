// opcode define
`define LUI     5'b01101
`define AUIPC   5'b00101
`define U_type  `LUI, `AUIPC
`define J_type  5'b11011
`define B_type  5'b11000
`define I_load  5'b00000
`define I_arth  5'b00100
`define JALR    5'b11001
`define I_type_wo_JALR  `I_load, `I_arth
`define S_type  5'b01000
`define R_type  5'b01100

// func3 define arthimetic
`define ADD_SUB 3'b000
`define SLL     3'b001
`define SLT     3'b010
`define SLTU    3'b011
`define XOR     3'b100
`define SRL_SRA 3'b101
`define OR      3'b110
`define AND     3'b111

// func3 define branch
`define BEQ     3'b000
`define BNE     3'b001
`define BLT     3'b100
`define BGE     3'b101
`define BLTU    3'b110
`define BGEU    3'b111

module ALU(
           input [4:0] opcode,
           input [2:0] func3,
           input       func7,
           input [31:0] operand1,
           input [31:0] operand2,
           output reg [31:0] alu_out
       );
always @(*)
begin
    case(opcode)
        `R_type, `I_arth://R-01100,I-00100
        begin
            case (func3)
                `ADD_SUB: //000
                begin
                    if(opcode == `R_type)
                    begin
					// Finish by yourself
						alu_out <= (func7)?(operand1-operand2):(operand1+operand2);
						//func7=1->SUB,=0->ADD
                    end
                    else if(opcode == `I_arth)
                    begin
                        // Finish by yourself
						alu_out <= operand1+operand2; //op1+imme[11,0]           /*/
                    end
                    else
                    begin
                        // Finish by yourself
						alu_out <= 32'bx;
                    end
                end
                `SLL:       // Finish by yourself
					alu_out<=operand1<<operand2[4:0];
				`SLT:       // Finish by yourself  **set less than signed**  /*/
					alu_out<={{31{1'b0}},($signed(operand1)<$signed(operand2))};//?1'b1:1'b0;
				`SLTU:      // Finish by yourself  **set less than unsigned**   /*/
					alu_out<={{31{1'b0}},(operand1<operand2)};//?1'b1:1'b0;
				`XOR:       // Finish by yourself
					alu_out<=operand1^operand2;
				`SRL_SRA:   // Finish by yourself       		
					alu_out<= (~func7)? ($signed(operand1)>>operand2[4:0]) : ($signed(operand1) >>> operand2[4:0]);
				`OR:        // Finish by yourself
					alu_out<=operand1|operand2;
				`AND:       // Finish by yourself
					alu_out<=operand1&operand2;
				default:    // Finish by yourself
					alu_out<=32'bx;
			endcase
        end
        `LUI:               // Finish by yourself
			alu_out<=operand2;
		`AUIPC:             // Finish by yourself
			alu_out<=operand1+operand2;
		`I_load, `S_type:   // Finish by yourself 
			alu_out<=operand1+operand2; //=>address
		`J_type, `JALR:     // Finish by yourself
			alu_out<=operand1+4; //=>pc+4
		`B_type:
			begin
				alu_out[31:1] <= 31'b0;
				case(func3)
				`BEQ:       // Finish by yourself
					alu_out[0]<=(operand1===operand2);//?1'b1:1'b0;
				`BNE:       // Finish by yourself
					alu_out[0]<=(operand1!==operand2);//?1'b1:1'b0;
				`BLT:       // Finish by yourself
					alu_out[0]<=($signed(operand1)<$signed(operand2));//?1'b1:1'b0;  //signed* 
				`BGE:       // Finish by yourself 
					alu_out[0]<=($signed(operand1)>=$signed(operand2));//?1'b1:1'b0;  //unsigned*  /*/
				`BLTU:      // Finish by yourself
					alu_out[0]<=(operand1<operand2);//?1'b1:1'b0;  //unsigned*                /*/
				`BGEU:      // Finish by yourself
					alu_out[0]<=(operand1>=operand2);//?1'b1:1'b0; //signed*               /*/
				default:    // Finish by yourself
					alu_out<=32'bx;
				endcase
			end
        default:            // Finish by yourself
			alu_out<=32'bx;
        endcase
end
endmodule
