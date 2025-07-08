module alu_4bit (
    input [3:0] a, b,
    input [2:0] ALU_Sel,
    output [3:0] ALU_Result,
    output Zero, Carry, Overflow
);
    wire [3:0] result;
    always @* begin
        case(ALU_Sel)
            3'b000: result = a + b; // Add
            3'b001: result = a & b; // AND
            3'b010: result = a | b; // OR
            3'b011: result = ~a; // NOT A
            3'b100: result = ~b; // NOT B
            default: result = 'x; // Default to unknown value
        endcase
    end
    assign ALU_Result = result;
    assign Zero = (result == 0)? 1 : 0;
    assign Carry = (result[3] && result[2] && result[1] && result[0])? 1 : 0;
    assign Overflow = (result[3] && result[2] && result[1] && result[0] && (a[3] ^ b[3]))? 1 : 0;
endmodule