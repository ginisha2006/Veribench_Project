module tb_ternary_adder_tree();
    parameter WIDTH = 16;

    input [WIDTH-1:0] A, B, C, D, E;
    input CLK;
    output [WIDTH-1:0] OUT;

    wire [WIDTH-1:0] sum1, sum2;
    reg [WIDTH-1:0] sumreg1, sumreg2;

    always #10 CLK = ~CLK; // Clock generation

    always @(*) begin assert (@(posedge CLK) disable iff (!CLK); end // Clock signal assertion);
    always @(*) begin assert (($onehot(A) && $onehot(B) && $onehot(C)) |-> (sum1 == A+B+C)); end
    always @(*) begin assert (($onehot(sumreg1) && $onehot(D) && $onehot(E)) |-> (sum2 == sumreg1+D+E)); end
    always @(*) begin assert (($onehot(sumreg2) |=> (OUT == sumreg2))); end

endmodule