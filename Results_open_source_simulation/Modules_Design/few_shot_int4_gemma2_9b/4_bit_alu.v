module alu_4bit (
    input [3:0] a, b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output reg Zero,
    output reg Carry,
    output reg Overflow
);

    wire [3:0] add_result;
    wire [3:0] sub_result;
    wire [3:0] and_result;
    wire [3:0] or_result;
    wire [3:0] xor_result;
    wire [3:0] not_a;
    wire [3:0] not_b;

    // Addition
    full_adder fa0 (a[0], b[0], 1'b0, add_result[0],  Carry);
    full_adder fa1 (a[1], b[1], add_result[0], add_result[1],  Carry);
    full_adder fa2 (a[2], b[2], add_result[1], add_result[2],  Carry);
    full_adder fa3 (a[3], b[3], add_result[2], add_result[3],  Carry);

    // Subtraction
    subtractor s0 (a[0], b[0], sub_result[0]);
    subtractor s1 (a[1], b[1], sub_result[1]);
    subtractor s2 (a[2], b[2], sub_result[2]);
    subtractor s3 (a[3], b[3], sub_result[3]);

    // Logical Operations
    and gate_and (a, b, and_result);
    or gate_or (a, b, or_result);
    xor gate_xor (a, b, xor_result);
    not gate_not (a, not_a);
    not gate_not (b, not_b);

    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Result = add_result;
            3'b001: ALU_Result = sub_result;
            3'b010: ALU_Result = and_result;
            3'b011: ALU_Result = or_result;
            3'b100: ALU_Result = xor_result;
            3'b101: ALU_Result = not_a;
            3'b110: ALU_Result = not_b;
            default: ALU_Result = 4'b0000;
        endcase
    end

    always @(*) begin
        Zero = (ALU_Result == 4'b0000);
        Overflow = (Carry && ALU_Sel != 3'b000);
    end

endmodule