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

    // Overflow check
    property prop_overflow;
        @(posedge CLK) disable iff (!CLK)
            ($unsigned(A + B + C + D + E) > (2**WIDTH - 1)) |-> OUT == {WIDTH{1'b1}};
    endproperty
    assert property(prop_overflow);

    // Underflow check
    property prop_underflow;
        @(posedge CLK) disable iff (!CLK)
            ($signed({{1{!$is_signed(A)}} , A}) + 
             $signed({{1{!$is_signed(B)}} , B}) +
             $signed({{1{!$is_signed(C)}} , C}) +
             $signed({{1{!$is_signed(D)}} , D}) +
             $signed({{1{!$is_signed(E)}} , E}) < -(2**(WIDTH-1))) |-> OUT == {WIDTH{1'b0}};
    endproperty
    assert property(prop_underflow);

    // Edge case when all inputs are zero
    property prop_zero_inputs;
        @(posedge CLK) disable iff (!CLK)
            (A == 0 && B == 0 && C == 0 && D == 0 && E == 0) |-> OUT == 0;
    endproperty
    assert property(prop_zero_inputs);

    // Illegal transition detection
    property prop_illegal_transition;
        @(posedge CLK) disable iff (!CLK)
            !($past((A != $past(A)) || (B != $past(B)) || (C != $past(C)) ||
                    (D != $past(D)) || (E != $past(E)))) |-> OUT == $past(OUT);
    endproperty
    assert property(prop_illegal_transition);

endmodule