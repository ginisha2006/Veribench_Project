module alu_4bit (
    input [3:0] a, b,
    input [2:0] ALU_Sel,
    output [3:0] ALU_Result,
    output Zero,
    output Carry,
    output Overflow
);
    wire [3:0] sum;
    wire Cout;

    always @* begin
        case(ALU_Sel)
            3'b000 : {Cout, ALU_Result} = a + b; // Add
            3'b001 : ALU_Result = a & b; // AND
            3'b010 : ALU_Result = a | b; // OR
            3'b011 : ALU_Result = ~a & b; // AND NOT A
            3'b100 : ALU_Result = a | ~b; // OR NOT B
            default : ALU_Result = 'x; // Default to unknown
        endcase
    end

    assign Zero = (&ALU_Result)? 1'b1 : 1'b0;
    assign Carry = Cout;
    assign Overflow = Cout & (~a ^ ~b);

endmodule