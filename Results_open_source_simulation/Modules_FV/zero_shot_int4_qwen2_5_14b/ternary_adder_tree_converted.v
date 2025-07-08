module tb_ternary_adder_tree();
    parameter WIDTH = 16;

    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;

    // DUT instantiation
    ternary_adder_tree uut (
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
    assert property (@(posedge CLK) disable iff (!CLK) OUT == (A + B + C + D + E));
    
    // Overflow check
    property no_overflow(input [WIDTH-1:0] A, B, C, D, E);
        @(posedge CLK) disable iff (!CLK)
            ($signed({{1'b0,A}}) + {{1'b0,B}} + {{1'b0,C}} + {{1'b0,D}} + {{1'b0,E}} < {{WIDTH+1}'b0}})
                |-> (OUT === ({{WIDTH+1}{1'b0}}[WIDTH-1:0]));
    endproperty
    assert property(no_overflow(A, B, C, D, E));

    // Underflow check
    property no_underflow(input [WIDTH-1:0] A, B, C, D, E);
        @(posedge CLK) disable iff (!CLK)
            ($signed({{1'b1,A}}) + {{1'b1,B}} + {{1'b1,C}} + {{1'b1,D}} + {{1'b1,E}} > {{WIDTH+1}'b1})
                |-> (OUT === ({{WIDTH+1}{1'b1}}[WIDTH-1:0]));
    endproperty
    assert property(no_underflow(A, B, C, D, E));

endmodule