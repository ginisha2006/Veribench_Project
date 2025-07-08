module tb_ternary_adder_tree(
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input CLK,
    output reg [15:0] OUT
);

wire [15:0] sum1, sum2;
reg [15:0] sumreg1, sumreg2;

ternary_adder_tree uut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .CLK(CLK),
    .OUT(OUT)
);

always #5 CLK = ~CLK;

assert (@(posedge CLK) disable iff (!reset)
 sum1 == A + B + C);

assert (@(posedge CLK) disable iff (!reset)
 sum2 == sumreg1 + D + E);

assert (@(posedge CLK) disable iff (!reset)
 OUT == sumreg2);

assert (@(posedge CLK) disable iff (!reset)
 !$isunknown(sum1) & !$isunknown(sum2) & !$isunknown(OUT));

assert (@(posedge CLK) disable iff (!reset)
 ($rose(A) | $rose(B) | $rose(C) | $rose(D) | $rose(E)) |-> 
  (!$isunknown(sum1) & !$isunknown(sum2) & !$isunknown(OUT)));

endmodule