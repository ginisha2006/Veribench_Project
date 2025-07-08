module tb_binary_adder_tree(
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

binary_adder_tree uut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
);

always begin
    #5 clk = ~clk;
end

assert (@(posedge clk) disable iff (!reset)
 sum1 == A + B);

assert (@(posedge clk) disable iff (!reset)
 sum2 == C + D);

assert (@(posedge clk) disable iff (!reset)
 sum3 == sumreg1 + sumreg2);

assert (@(posedge clk) disable iff (!reset)
 sum4 == sumreg3 + E);

assert (@(posedge clk) disable iff (!reset)
 out == sumreg4);

assert (@(posedge clk) disable iff (!reset)
 !$isunknown(sum1) & !$isunknown(sum2) & !$isunknown(sum3) & !$isunknown(sum4) & !$isunknown(out));

endmodule