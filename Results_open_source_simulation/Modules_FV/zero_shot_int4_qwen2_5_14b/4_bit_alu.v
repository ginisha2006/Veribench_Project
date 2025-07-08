module tb_alu_4bit;
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
    always #5 clk = !clk;

    property add_overflow;
        @(posedge clk) disable iff (!reset)
        (ALU_Sel === 3'b000) |-> ($rose(Overflow)) |=> (a[3] !== ALU_Result[3]);
    endproperty
    assert property(add_overflow);

    property sub_underflow;
        @(posedge clk) disable iff (!reset)
        (ALU_Sel === 3'b001) |-> ($rose(Overflow)) |=> (a[3] !== ALU_Result[3]);
    endproperty
    assert property(sub_underflow);

    property zero_result;
        @(posedge clk) disable iff (!reset)
        (ALU_Sel inside {3'b000, 3'b001}) |-> (ALU_Result === 4'b0000) |-> (Zero);
    endproperty
    assert property(zero_result);

    property logic_operations;
        @(posedge clk) disable iff (!reset)
        (ALU_Sel === 3'b010) |-> (ALU_Result === (a & b));
        (ALU_Sel === 3'b011) |-> (ALU_Result === (a | b));
        (ALU_Sel === 3'b100) |-> (ALU_Result === (a ^ b));
        (ALU_Sel === 3'b101) |-> (ALU_Result === (~a));
        (ALU_Sel === 3'b110) |-> (ALU_Result === (a << 1));
        (ALU_Sel === 3'b111) |-> (ALU_Result === (a >> 1));
    endproperty
    assert property(logic_operations);

endmodule