module alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output [3:0] ALU_Result,
    output Zero,
    output Carry,
    output Overflow
);

wire [3:0] sum;
wire [3:0] result;

always @(*) begin
    case(ALU_Sel)
        3'b000: begin
            ALU_Result = a + b;
            Carry = (a[3] & ~b[3]) | (~a[3] & b[3]);
            Zero = ~|ALU_Result;
            Overflow = (a[3] ^ b[3]) & ~ALU_Result[3];
        end
        3'b001: begin
            ALU_Result = a & b;
            Carry = 0;
            Zero = ~|ALU_Result;
            Overflow = 0;
        end
        3'b010: begin
            ALU_Result = a | b;
            Carry = 0;
            Zero = ~|ALU_Result;
            Overflow = 0;
        end
        3'b011: begin
            ALU_Result = ~a;
            Carry = 0;
            Zero = ~|ALU_Result;
            Overflow = 0;
        end
        3'b100: begin
            ALU_Result = a << 1;
            Carry = a[3];
            Zero = ~|ALU_Result;
            Overflow = 0;
        end
        3'b101: begin
            ALU_Result = a >> 1;
            Carry = a[3];
            Zero = ~|ALU_Result;
            Overflow = 0;
        end
        default: begin
            ALU_Result = 0;
            Carry = 0;
            Zero = 1;
            Overflow = 0;
        end
    endcase
end

assign Zero = ~|ALU_Result;
assign Carry = ALU_Result[3];
assign Overflow = (a[3] ^ b[3]) & ~ALU_Result[3];

endmodule