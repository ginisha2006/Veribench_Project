module alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);
always @(*) begin
    case(ALU_Sel)
        3'b000: ALU_Result = a & b; // AND operation
        3'b001: ALU_Result = a | b; // OR operation
        3'b010: ALU_Result = a ^ b; // XOR operation
        3'b011: ALU_Result = a + b; // Addition
        3'b100: ALU_Result = ~(a + ~b); // Subtraction
        default: ALU_Result = 4'b0;
    endcase
    
    if (ALU_Result == 4'b0) 
        Zero = 1;
    else 
        Zero = 0;

    case(ALU_Sel)
        3'b011:
            begin
                Carry = a[3] & b[3];
                Overflow = ((~(a[3]^b[3]) & (a[3]^ALU_Result[3])) | (~(a[3]^ALU_Result[3]) & (b[3]^ALU_Result[3])));
            end
        3'b100:
            begin
                Carry = (~a[3]) & (~b[3]);
                Overflow = ((~(a[3]^b[3]) & (a[3]^ALU_Result[3])) | (~(a[3]^ALU_Result[3]) & (b[3]^ALU_Result[3])));
            end
        default:
            begin
                Carry = 0;
                Overflow = 0;
            end
    endcase
end
endmodule