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
    assert (@(posedge CLK) disable iff (!CLK)
            sum1 == A + B + C);

    assert (@(posedge CLK) disable iff (!CLK)
            sum2 == sumreg1 + D + E);

    assert (@(posedge CLK) disable iff (!CLK)
            OUT == sumreg2);

    assert (@(posedge CLK) disable iff (!CLK)
            !(sum1 > {WIDTH{1'b1}} || sum1 < {WIDTH{1'b0}})
            && !(sum2 > {WIDTH{1'b1}} || sum2 < {WIDTH{1'b0}}));

endmodule