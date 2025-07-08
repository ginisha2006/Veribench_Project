module tb_alu_4bit();
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] ALU_Sel;
    wire [3:0] ALU_Result;
    wire Zero;
    wire Carry;
    wire Overflow;

    alu_4bit dut (
        .a(a),
        .b(b),
        .ALU_Sel(ALU_Sel),
        .ALU_Result(ALU_Result),
        .Zero(Zero),
        .Carry(Carry),
        .Overflow(Overflow)
    );

    reg clk;
    always #5 clk = ~clk;

    property p_add_no_overflow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b000) |-> !Overflow;
    endproperty
    assert property(p_add_no_overflow);

    property p_sub_no_underflow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b001) |-> !Overflow;
    endproperty
    assert property(p_sub_no_underflow);

    property p_add_carry;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b000) |-> (a[3] !== b[3] && ALU_Result[3] !== a[3]) |=> Carry;
    endproperty
    assert property(p_add_carry);

    property p_add_overflow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b000) |-> (a[3] === b[3] && ALU_Result[3] !== a[3]) |=> Overflow;
    endproperty
    assert property(p_add_overflow);

    property p_sub_borrow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b001) |-> (a[3] !== b[3] && ALU_Result[3] !== a[3]) |=> Carry;
    endproperty
    assert property(p_sub_borrow);

    property p_sub_underflow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b001) |-> (a[3] === b[3] && ALU_Result[3] !== a[3]) |=> Overflow;
    endproperty
    assert property(p_sub_underflow);

    property p_and_or_xor_not_shl_shr_zero;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel inside {[3'b010:3'b101],[3'b110:3'b111]}) |-> !Zero;
    endproperty
    assert property(p_and_or_xor_not_shl_shr_zero);

    property p_result_correctness;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
        (ALU_Sel === 3'b000) |-> ALU_Result === a + b;
        (ALU_Sel === 3'b001) |-> ALU_Result === a - b;
        (ALU_Sel === 3'b010) |-> ALU_Result === a & b;
        (ALU_Sel === 3'b011) |-> ALU_Result === a | b;
        (ALU_Sel === 3'b100) |-> ALU_Result === a ^ b;
        (ALU_Sel === 3'b101) |-> ALU_Result === ~a;
        (ALU_Sel === 3'b110) |-> ALU_Result === a << 1;
        (ALU_Sel === 3'b111) |-> ALU_Result === a >> 1;
    endproperty
    assert property(p_result_correctness);

endmodule