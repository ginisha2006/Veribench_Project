module tb_ternary_adder_tree();
    parameter WIDTH = 16;

    input [WIDTH-1:0] A, B, C, D, E;
    input CLK;
    output [WIDTH-1:0] OUT;

    wire [WIDTH-1:0] sum1, sum2;
    reg [WIDTH-1:0] sumreg1, sumreg2;

    always #10 CLK = ~CLK; // Clock generation

    property p_clk_posedge;
        @(posedge CLK) disable iff (!CLK); // Clock signal assertion
    endproperty

    property p_sum1_correct;
        ($onehot(A) && $onehot(B) && $onehot(C)) |-> (sum1 == A+B+C);
    endproperty

    property p_sum2_correct;
        ($onehot(sumreg1) && $onehot(D) && $onehot(E)) |-> (sum2 == sumreg1+D+E);
    endproperty

    property p_out_correct;
        ($onehot(sumreg2) |=> (OUT == sumreg2));
    endproperty

    assert property (p_clk_posedge);
    assert property (p_sum1_correct);
    assert property (p_sum2_correct);
    assert property (p_out_correct);

endmodule