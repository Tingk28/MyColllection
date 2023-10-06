// Author : William Lee, CASLab, AISLab
// CO 2021
`timescale 10ns/1ns
`include "Stage.v"

module little_east(
    input clk,rst,
    input [31:0] person_id,
    output [31:0] person_done_id //correct id means all stages are complete
);

Stage #(
  .delay(3)
) card(
    .clk(clk),
    .rst(rst),
    .p_id_in(person_id),
    .p_id_out_reg(doctor.p_id_in)
);

Stage #(
    .delay(0.5)
) doctor(
    .clk(clk),
    .rst(rst),
    .p_id_in(card.p_id_out_reg),
    .p_id_out_reg(dose.p_id_in)
);

Stage #(
    .delay(1)
) dose(
    .clk(clk),
    .rst(rst),
    .p_id_in(doctor.p_id_out_reg),
    .p_id_out_reg(rest.p_id_in)
);

Stage #(
    .delay(15)
) rest(
    .clk(clk),
    .rst(rst),
    .p_id_in(dose.p_id_out_reg),
    .p_id_out_reg(person_done_id)
);
    
endmodule