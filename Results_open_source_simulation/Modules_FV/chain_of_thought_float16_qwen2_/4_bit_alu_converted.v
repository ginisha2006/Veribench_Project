module tb_alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output Zero,
    output reg Carry,
    output reg Overflow
);

assert property(p_add_no_carry)

assert property(p_sub_no_borrow)

assert property(p_and_or_xor_not_shl_shr)

assert property(p_overflow)

assert property(p_zero)

endmodule