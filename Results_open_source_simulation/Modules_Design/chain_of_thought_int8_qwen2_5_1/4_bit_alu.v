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
    case (ALU_Sel)
        3'b000: ALU_Result = a & b; // AND operation
        3'b001: ALU_Result = a | b; // OR operation
        3'b010: ALU_Result = a ^ b; // XOR operation
        3'b011: ALU_Result = a + b; // Addition
            if ((a[3]^b[3]) == 0 && (a[3]^ALU_Result[3])) 
                Overflow = 1;
            else 
                Overflow = 0;
            if ({~a[3],a} + {~b[3],b} < 8'b0000_0000) 
                Carry = 1;
            else 
                Carry = 0;
        3'b100: ALU_Result = a - b; // Subtraction
            if ((a[3]^b[3]) != 0 && (a[3]^ALU_Result[3])) 
                Overflow = 1;
            else 
                Overflow = 0;
            if (~{a[3],a} + {b[3],b} > 8'b1111_1111) 
                Carry = 1;
            else 
                Carry = 0;
        default: ALU_Result = 4'bxxxx; // Undefined behavior
    endcase
    
    if (ALU_Result == 4'b0000) 
        Zero = 1;
    else 
        Zero = 0;
end

endmodule