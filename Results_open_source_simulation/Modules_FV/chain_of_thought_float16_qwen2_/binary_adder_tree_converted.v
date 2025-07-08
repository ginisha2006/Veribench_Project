module tb_binary_adder_tree (
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input clk,
    output reg [15:0] out
);
wire [15:0] sum1, sum2, sum3, sum4;
reg [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

binary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
);

always #5 clk =~clk;

assert (@(posedge clk) disable iff (!reset)
 ($unsigned(sum1) < 65536) |-> ($unsigned(sumreg1) == sum1));

assert (@(posedge clk) disable iff (!reset)
 ($signed(sum1) > -32768) |-> ($signed(sumreg1) == sum1));

assert (@(posedge clk) disable iff (!reset)
 (sumreg4 == sumreg3 + E));

assert (@(posedge clk) disable iff (!reset)
 ((A == 0 && B == 0) |-> (sumreg1 == 0)) &&
 ((C == 0 && D == 0) |-> (sumreg2 == 0)));

assert (@(posedge clk) disable iff (!reset)
 !(sumreg1 !== sum1 && sumreg2 !== sum2 && sumreg3 !== sumreg1 + sumreg2 && sumreg4 !== sumreg3 + E));

endmodule