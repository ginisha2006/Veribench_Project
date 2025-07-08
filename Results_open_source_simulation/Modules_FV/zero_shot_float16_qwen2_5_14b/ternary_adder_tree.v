module tb_ternary_adder_tree();
    parameter WIDTH = 16;

    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;

    // DUT instantiation
    ternary_adder_tree dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .CLK(CLK),
        .OUT(OUT)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK;
    end

    // Functional correctness
    property prop_correctness;
        @(posedge CLK) disable iff (!CLK)
            OUT == (A + B + C + D + E)[WIDTH-1:0];
    endproperty
    assert property(prop_correctness);

    // Overflow detection
    property prop_overflow;
        @(posedge CLK) disable iff (!CLK)
            ($unsigned(A + B + C + D + E) > 2**WIDTH - 1) |-> 
            OUT[WIDTH-1] === 1'b1;
    endproperty
    assert property(prop_overflow);

    // Underflow detection
    property prop_underflow;
        @(posedge CLK) disable iff (!CLK)
            ($signed({{1{!$is_signed(A)}}, A}) + 
             {{1{!$is_signed(B)}}, B} +
             {{1{!$is_signed(C)}}, C} +
             {{1{!$is_signed(D)}}, D} +
             {{1{!$is_signed(E)}}, E}) < -(2**(WIDTH-1)) |-> 
            OUT[WIDTH-1] === 1'b1;
    endproperty
    assert property(prop_underflow);

    // Edge case: all inputs zero
    property prop_zero_inputs;
        @(posedge CLK) disable iff (!CLK)
            (A == 0 && B == 0 && C == 0 && D == 0 && E == 0) |-> 
            OUT == 0;
    endproperty
    assert property(prop_zero_inputs);

    // Edge case: single bit width
    property prop_single_bit_width;
        @(posedge CLK) disable iff (!CLK)
            (WIDTH == 1) |-> 
            OUT == (A + B + C + D + E)[WIDTH-1:0];
    endproperty
    assert property(prop_single_bit_width);

endmodule