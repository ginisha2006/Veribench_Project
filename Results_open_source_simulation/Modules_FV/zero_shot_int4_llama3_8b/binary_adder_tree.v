Here is the SystemVerilog testbench code for the binary adder tree:

tb_binary_adder_tree.sv

module tb_binary_adder_tree();

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;
logic clk;
logic [WIDTH-1:0] out;

binary_adder_tree dut (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .clk(clk),
   .out(out)
);

property p_correct_sum;
@(posedge clk) disable iff (!clk);
(A == 0 && B == 0 && C == 0 && D == 0 && E == 0) |-> out == 0;
(A == 1 && B == 1 && C == 0 && D == 0 && E == 0) |-> out == 2;
(A == 1 && B == 1 && C == 1 && D == 0 && E == 0) |-> out == 3;
(A == 1 && B == 1 && C == 0 && D == 1 && E == 0) |-> out == 3;
(A == 1 && B == 1 && C == 1 && D == 1 && E == 0) |-> out == 4;
(A == 1 && B == 0 && C == 0 && D == 0 && E == 1) |-> out == 1;
(A == 1 && B == 0 && C == 0 && D == 1 && E == 0) |-> out == 2;
(A == 1 && B == 0 && C == 1 && D == 0 && E == 0) |-> out == 2;
(A == 1 && B == 0 && C == 1 && D == 1 && E == 0) |-> out == 3;
(A == 1 && B == 1 && C == 0 && D == 0 && E == 1) |-> out == 2;
(A == 1 && B == 1 && C == 1 && D == 0 && E == 1) |-> out == 3;
(A == 1 && B == 1 && C == 1 && D == 1 && E == 1) |-> out == 4;
(A == 0 && B == 0 && C == 0 && D == 0 && E == 1) |-> out == 1;
(A == 0 && B == 0 && C == 0 && D == 1 && E == 0) |-> out == 1;
(A == 0 && B == 0 && C == 1 && D == 0 && E == 0) |-> out == 1;
(A == 0 && B == 0 && C == 1 && D == 1 && E == 0) |-> out == 2;
(A == 0 && B == 1 && C == 0 && D == 0 && E == 0) |-> out == 1;
(A == 0 && B == 1 && C == 0 && D == 1 && E == 0) |-> out == 2;
(A == 0 && B == 1 && C == 1 && D == 0 && E == 0) |-> out == 2;
(A == 0 && B == 1 && C == 1 && D == 1 && E == 0) |-> out == 3;
(A == 0 && B == 1 && C == 1 && D == 1 && E == 1) |-> out == 4;
(A == 0 && B == 0 && C == 0 && D == 0 && E == 1) |-> out == 1;
(A == 0 && B == 0 && C == 0 && D == 1 && E == 1) |-> out == 2;
(A == 0 && B == 0 && C == 1 && D == 0 && E == 1) |-> out == 2;
(A == 0 && B == 0 && C == 1 && D == 1 && E == 1) |-> out == 3;
(A == 0 && B == 1 && C == 0 && D == 0 && E == 1) |-> out == 2;
(A == 0 && B == 1 && C == 0 && D == 1 && E == 1) |-> out == 3;
(A == 0 && B == 1 && C == 1 && D == 0 && E == 1) |-> out