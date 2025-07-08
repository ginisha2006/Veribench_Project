module alu_4bit (
  input [3:0] a,
  input [3:0] b,
  input [2:0] ALU_Sel,
  output [3:0] ALU_Result,
  output Zero,
  output Carry,
  output Overflow
);

  assign ALU_Result = case(ALU_Sel)
    3'b000: a + b,
    3'b001: a - b,
    3'b010: a & b,
    3'b011: a | b,
    3'b100: ~a,
    3'b101: a ^ b
    endcase;

  assign Zero = (ALU_Result == 4'b0);
  assign Carry = (ALU_Result[3] == 1);
  assign Overflow = ((a[3] == b[3]) && (ALU_Result[3] != a[3]));

endmodule