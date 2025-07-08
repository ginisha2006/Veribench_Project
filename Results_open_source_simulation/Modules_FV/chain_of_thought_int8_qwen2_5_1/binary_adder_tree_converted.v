module tb_binary_adder_tree (
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input clk,
    output logic [15:0] out
);
wire [15:0] sum1, sum2, sum3, sum4;
logic [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

binary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
);

always begin
    clk = 0; #5; clk = 1; #5;
end

assert (@(posedge clk) disable iff (!reset)
    (sum1 == A + B));

assert (@(posedge clk) disable iff (!reset)
    (sum2 == C + D));

assert (@(posedge clk) disable iff (!reset)
    (sum3 == sumreg1 + sumreg2));

assert (@(posedge clk) disable iff (!reset)
    (sum4 == sumreg3 + E));

assert (@(posedge clk) disable iff (!reset)
    (out == sumreg4));

assert (@(posedge clk) disable iff (!reset)
    (!$overflow(sum1) & !$underflow(sum1)) &&
    (!$overflow(sum2) & !$underflow(sum2)) &&
    (!$overflow(sum3) & !$underflow(sum3)) &&
    (!$overflow(sum4) & !$underflow(sum4)));

assert (@(negedge clk) disable iff (!reset)
    (sumreg1 == 0) && (sumreg2 == 0) && (sumreg2 == 0) && (sumreg3 == 0));

assert (@(posedge clk) disable iff (!reset)
    ($past((A == 0) |-> (sum1 == B))) &&
    ($past((B == 0) |-> (sum1 == A))) &&
    ($past((C == 0) |-> (sum2 == D))) &&
    ($past((D == 0) |-> (sum2 == C))));

endmodule