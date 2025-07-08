module tb_ternary_adder_tree;

parameter WIDTH = 16;

input [WIDTH-1:0] A, B, C, D, E;

input CLK;

output [WIDTH-1:0] OUT;

wire [WIDTH-1:0] sum1, sum2;

reg [WIDTH-1:0] sumreg1, sumreg2;

property P_ADDER_TREE_CORRECTNESS;

@(posedge CLK) disable iff (!CLK) ((A == 0) | (B == 0) | (C == 0)) => (OUT == (A + B + C));

property P_EDGE_CASES;

@(posedge CLK) disable iff (!CLK) ((A!= 0) && (B!= 0) && (C!= 0)) => (sumreg1 == A + B);

property P_OVERFLOW_UNDERFLOW;

@(posedge CLK) disable iff (!CLK) ((A >= 2**WIDTH - 1) || (B >= 2**WIDTH - 1) || (C >= 2**WIDTH - 1)) => ($fell(OUT) == 0);

property P_ILLEGAL_TRANSITIONS;

@(posedge CLK) disable iff (!CLK) ((A > 2**WIDTH - 1) || (B > 2**WIDTH - 1) || (C > 2**WIDTH - 1)) => ($rose(OUT) == 0);

ternary_adder_tree uut (.A(A),.B(B),.C(C),.D(D),.E(E),.CLK(CLK),.OUT(OUT));

endmodule