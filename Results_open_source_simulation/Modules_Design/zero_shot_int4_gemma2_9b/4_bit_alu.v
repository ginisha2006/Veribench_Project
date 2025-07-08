module alu_4bit(a[3:0], b[3:0], ALU_Sel[2:0], ALU_Result[3:0], Zero, Carry, Overflow);
  input [3:0] a;
  input [3:0] b;
  input [2:0] ALU_Sel;
  output [3:0] ALU_Result;
  output Zero;
  output Carry;
  output Overflow;
  wire [3:0] sum;
  wire [3:0] diff;
  assign sum = a + b;
  assign diff = a - b;
  assign ALU_Result = ALU_Sel == 3'b000 ? sum : ALU_Sel == 3'b001 ? diff : ALU_Sel == 3'b010 ? (a & b) : ALU_Sel == 3'b011 ? (a | b) : ALU_Sel == 3'b100 ? (~a) : ALU_Sel == 3'b101 ? (a ^ b) : 4'b0;
  assign Zero = ALU_Result == 4'b0;
  assign Carry = sum[3];
  assign Overflow = (ALU_Sel == 3'b000 && (sum > 15)) || (ALU_Sel == 3'b001 && (diff < 0));
endmodule