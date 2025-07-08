module alu_4bit (
    input [3:0] a, b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);

    wire [3:0] temp_result;

    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Result = a + b;
            3'b001: ALU_Result = a - b;
            3'b010: ALU_Result = a & b;
            3'b011: ALU_Result = a | b;
            3'b100: ALU_Result = ~a;
            3'b101: ALU_Result = a << 1;
            3'b110: ALU_Result = a >> 1;
            3'b111: ALU_Result = {4{a[3]}}; // Fill with MSB
        endcase
    end

    always @(*) begin
        Zero = (ALU_Result == 4'b0);
        Carry = ALU_Result[3];
        Overflow = ((a[3] == b[3]) && (ALU_Result[3] != a[3]));
    end

endmodule