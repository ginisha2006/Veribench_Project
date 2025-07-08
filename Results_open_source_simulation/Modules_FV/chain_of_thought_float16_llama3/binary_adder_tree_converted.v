module tb_binary_adder_tree;

input [15:0] A, B, C, D, E;
input clk;
output [15:0] out;

wire [15:0] sum1, sum2, sum3, sum4;
reg [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

endmodule