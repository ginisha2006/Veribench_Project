module tb_ternary_adder_tree();
    parameter WIDTH = 16;

    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;

    // Instantiate the Design Under Test
    ternary_adder_tree dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .CLK(CLK),
        .OUT(OUT)
    );

    // Clock Signal Generation
    always begin
        CLK = 0; #5; CLK = 1; #5;
    end

    // Assertions
    property p_sum1_correctness;
        @(posedge CLK) disable iff (!CLK)
            sum1 == A + B + C;
    endproperty
    assert property(p_sum1_correctness);

    property p_sum2_correctness;
        @(posedge CLK) disable iff (!CLK)
            sum2 == sumreg1 + D + E;
    endproperty
    assert property(p_sum2_correctness);

    property p_out_correctness;
        @(posedge CLK) disable iff (!CLK)
            OUT == sumreg2;
    endproperty
    assert property(p_out_correctness);

    property p_no_overflow_underflow;
        @(posedge CLK) disable iff (!CLK)
            !(sum1 > {WIDTH{1'b1}} || sum1 < {WIDTH{1'b0}})
            && !(sum2 > {WIDTH{1'b1}} || sum2 < {WIDTH{1'b0}});
    endproperty
    assert property(p_no_overflow_underflow);

endmodule