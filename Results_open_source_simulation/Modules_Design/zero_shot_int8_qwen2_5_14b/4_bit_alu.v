module alu_4bit(
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);
always @(a,b,ALU_Sel)
begin
    case(ALU_Sel)
        3'b000: ALU_Result = a & b; // AND
        3'b001: ALU_Result = a | b; // OR
        3'b010: ALU_Result = a ^ b; // XOR
        3'b011: begin // ADD
            {Carry, ALU_Result} = a + b;
            if(a+b == 0) Zero = 1;
            else Zero = 0;
            if({a[3],a[2:0]}+{b[3],b[2:0]}<8'b10000000 && ({a[3],a[2:0]}+{b[3],b[2:0]}>8'b01111111)) Overflow = 1;
            else Overflow = 0;
        end
        3'b100: begin // SUB
            {Carry, ALU_Result} = a - b;
            if(a-b == 0) Zero = 1;
            else Zero = 0;
            if(({a[3],a[2:0]}-{b[3],b[2:0]})>7'b0111111 && ({a[3],a[2:0]}-{b[3],b[2:0]})<7'b1000000) Overflow = 1;
            else Overflow = 0;
        end
        default: ALU_Result = 4'bxxxx;
    endcase
end
endmodule