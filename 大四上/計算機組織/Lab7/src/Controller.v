`define is_LUI      (opcode_in == 5'b01101)
`define is_AUIPC    (opcode_in == 5'b00101)
`define is_U_type   (`is_LUI || `is_AUIPC)
`define is_J_type   (opcode_in == 5'b11011)
`define is_B_type   (opcode_in == 5'b11000)
`define is_I_load   (opcode_in == 5'b00000)
`define is_I_arth   (opcode_in == 5'b00100)
`define is_JALR     (opcode_in == 5'b11001)
`define is_I_type   (`is_I_load || `is_I_arth || `is_JALR)
`define is_S_type   (opcode_in == 5'b01000)
`define is_R_type   (opcode_in == 5'b01100)

module Controller(
           input       [4:0]   opcode_in,
           input       [2:0]   func3_in,
           input               func7_in,
           input               aluOut_bit0,
           output reg          next_pc_sel,
           output      [3:0]   im_w_en,
           output reg          wb_en,
           output reg          jb_op1_sel,
           output reg          alu_op1_sel,
           output reg          alu_op2_sel,
           output      [4:0]   opcode_out,
           output      [2:0]   func3_out,
           output              func7_out,
           output reg          wb_sel,
           output reg  [3:0]   dm_w_en
       );

assign im_w_en = 4'b0;
assign opcode_out = opcode_in;
assign func3_out = func3_in;
assign func7_out = func7_in;

// next_pc_sel
always @(opcode_in, aluOut_bit0)
begin
    if(`is_J_type || `is_JALR || (`is_B_type && aluOut_bit0))
    begin
        // Finish by yourself
		next_pc_sel <= 1'b0;
    end
    else
    begin
        // Finish by yourself
		next_pc_sel <= 1'b1;
    end
end

// wb_en
always @(opcode_in)
begin
    if(`is_U_type || `is_J_type || `is_I_type || `is_R_type)
    begin
        // Finish by yourself
		wb_en <= 1'b1;
    end
    else
    begin
        // Finish by yourself
		wb_en <= 1'b0;
    end
end

// jb_op1_sel
always @(opcode_in)
begin
    if(`is_JALR)
    begin
        // Finish by yourself
		jb_op1_sel <= 1'b0;
    end
    else
    begin
        // Finish by yourself
		jb_op1_sel <= 1'b1;
    end
end

// alu_op1_sel
always @(opcode_in)
begin
    if(`is_U_type || `is_J_type || `is_JALR)
    begin
        // Finish by yourself
		alu_op1_sel <= 1'b1;
    end
    else
    begin
        // Finish by yourself
		alu_op1_sel <= 1'b0;
    end
end

// alu_op2_sel
always @(opcode_in)
begin
    if(`is_R_type || `is_B_type)
    begin
        // Finish by yourself
		alu_op2_sel <= 1'b0;
    end
    else
    begin
        // Finish by yourself
		alu_op2_sel <= 1'b1;
    end
end

// wb_sel
always @(opcode_in)
begin
    if(`is_I_load)
    begin
        // Finish by yourself
		wb_sel <= 1'b0;
    end
    else
    begin
        // Finish by yourself
		wb_sel <= 1'b1;
    end
end

// dm_w_en
always @(opcode_in, func3_in)
begin
    if(`is_S_type)
    begin
        // Finish by yourself
		dm_w_en[0]<=1'b1;
		dm_w_en[1]<=(func3_in[0] || func3_in[1]);
		dm_w_en[3:2]<={2{func3_in[1]}};
    end
    else
    begin
        dm_w_en <= 4'b0000;
    end
end

endmodule
