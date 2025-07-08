module alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);

always @ (*)
begin
    case(ALU_Sel)
        3'b000: begin
            ALU_Result = a + b;
            Carry = (a[3] & ~b[3]) | (~a[3] & b[3]);
            Zero = ~(ALU_Result[3] | ALU_Result[2] | ALU_Result[1] | ALU_Result[0]);
            Overflow = (a[3] ^ b[3] & ~ALU_Result[3]) | (~a[3] ^ b[3] & ALU_Result[3]);
        end
        3'b001: begin
            ALU_Result = a - b;
            Carry = (a[3] & ~b[3]) | (~a[3] & b[3]);
            Zero = ~(ALU_Result[3] | ALU_Result[2] | ALU_Result[1] | ALU_Result[0]);
            Overflow = (a[3] ^ b[3] & ~ALU_Result[3]) | (~a[3] ^ b[3] & ALU_Result[3]);
        end
        3'b010: begin
            ALU_Result = a & b;
            Carry = 1'b0;
            Zero = ~(ALU_Result[3] | ALU_Result[2] | ALU_Result[1] | ALU_Result[0]);
            Overflow = 1'b0;
        end
        3'b011: begin
            ALU_Result = a | b;
            Carry = 1'b0;
            Zero = ~(ALU_Result[3] | ALU_Result[2] | ALU_Result[1] | ALU_Result[0]);
            Overflow = 1'b0;
        end
        3'b100: begin
            ALU_Result = ~a;
            Carry = 1'b0;
            Zero = 1'b1;
            Overflow = 1'b0;
        end
        3'b101: begin
            ALU_Result = ~b;
            Carry = 1'b0;
            Zero = 1'b1;
            Overflow = 1'b0;
        end
        default: begin
            ALU_Result = 4'bxxxx;
            Carry = 1'b0;
            Zero = 1'b0;
            Overflow = 1'b0;
        end
    endcase
end

endmodule