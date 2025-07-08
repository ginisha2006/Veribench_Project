module tb_alu_4bit;
    // Input and output signals declaration
    logic [3:0] a, b;
    logic [2:0] ALU_Sel;
    logic [3:0] ALU_Result;
    logic Zero;
    logic Carry;
    logic Overflow;

    // Instantiate the DUT
    alu_4bit dut (
       .a(a),
       .b(b),
       .ALU_Sel(ALU_Sel),
       .ALU_Result(ALU_Result),
       .Zero(Zero),
       .Carry(Carry),
       .Overflow(Overflow)
    );

    // Clock signal generation
    parameter CLOCK_PERIOD = 10;
    localparam CLOCK_FREQ = 100_000_000; // 100 MHz
    localparam CLOCK_CYCLES = CLOCK_PERIOD * CLOCK_FREQ;

    always #((CLOCK_CYCLES / 2) - 1) ALU_Sel <= ALU_Sel;
    always #((CLOCK_CYCLES / 2)) ALU_Sel <= ALU_Sel;

    // Property for functional correctness
    property add_subtract_correctness;
        @(posedge ALU_Sel) disable iff (!ALU_Sel[0])
        ($rose(ALU_Sel[0]) |-> (ALU_Result == (a + b)));
    endproperty

    property subtract_correctness;
        @(posedge ALU_Sel) disable iff (ALU_Sel[0])
        ($rose(ALU_Sel[0]) |-> (ALU_Result == (a - b)));
    endproperty

    property and_or_xor_correctness;
        @(posedge ALU_Sel) disable iff (!(ALU_Sel[0] || ALU_Sel[1]))
        ($rose(ALU_Sel[0] || ALU_Sel[1]) |-> (ALU_Result == (a & b)));
    endproperty

    property or_and_not_correctness;
        @(posedge ALU_Sel) disable iff (!(ALU_Sel[0] || ALU_Sel[1]))
        ($rose(ALU_Sel[0] || ALU_Sel[1]) |-> (ALU_Result == (a | b)));
    endproperty

    property not_correctness;
        @(posedge ALU_Sel) disable iff (ALU_Sel[2])
        ($rose(ALU_Sel[2]) |-> (ALU_Result == (~a)));
    endproperty

    property shift_left_right_correctness;
        @(posedge ALU_Sel) disable iff (!(ALU_Sel[2] || ALU_Sel[1]))
        ($rose(ALU_Sel[2] || ALU_Sel[1]) |-> (ALU_Result == (a << 1) || (a >> 1)));
    endproperty

    // Properties for overflow/underflow
    property overflow_add_subtract;
        @(posedge ALU_Sel) disable iff (!ALU_Sel[0])
        ($rose(ALU_Sel[0]) |-> (Overflow == (a[3] == b[3] && ALU_Result[3]!= a[3])));
    endproperty

    property underflow_add_subtract;
        @(posedge ALU_Sel) disable iff (ALU_Sel[0])
        ($rose(ALU_Sel[0]) |-> (!Overflow));
    endproperty

    // Assert properties
    assert property add_subtract_correctness;
    assert property subtract_correctness;
    assert property and_or_xor_correctness;
    assert property or_and_not_correctness;
    assert property not_correctness;
    assert property shift_left_right_correctness;
    assert property overflow_add_subtract;
    assert property underflow_add_subtract;

endmodule