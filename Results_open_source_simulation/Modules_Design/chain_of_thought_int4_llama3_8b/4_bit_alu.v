module alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);

always @* begin
case(ALU_Sel)
    3'b000: ALU_Result = a + b;
    3'b001: ALU_Result = a & b;
    3'b010: ALU_Result = a | b;
    3'b011: ALU_Result = ~a;
    3'b100: ALU_Result = a ^ b;
    3'b101: ALU_Result = a << 1;
    3'b110: ALU_Result = a >> 1;
    default: ALU_Result = 4'bxxxx;
endcase

assign Zero = (ALU_Result == 4'b0000);
assign Carry = (ALU_Result[3] && ALU_Result[2]);
assign Overflow = (ALU_Result[3] &&!ALU_Result[2]);
endmodule