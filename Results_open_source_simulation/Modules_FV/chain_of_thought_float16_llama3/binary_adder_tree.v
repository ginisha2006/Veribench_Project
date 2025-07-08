module tb_binary_adder_tree;

input [15:0] A, B, C, D, E;
input clk;
output [15:0] out;

wire [15:0] sum1, sum2, sum3, sum4;
reg [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

property p_sum1_valid; @(posedge clk) ($rose(sum1) |=> ($isunknown(A) | $isunknown(B))); endproperty
property p_sum2_valid; @(posedge clk) ($rose(sum2) |=> ($isunknown(C) | $isunknown(D))); endproperty
property p_sum3_valid; @(posedge clk) ($rose(sum3) |=> ($isunknown(sumreg1) | $isunknown(sumreg2))); endproperty
property p_sum4_valid; @(posedge clk) ($rose(sum4) |=> ($isunknown(sumreg3) | $isunknown(E))); endproperty
property p_out_valid; @(posedge clk) ($rose(out) |=> ($isunknown(sumreg4))); endproperty

property p_sum1_correct; @(posedge clk) assert property (sum1 == A + B); endproperty
property p_sum2_correct; @(posedge clk) assert property (sum2 == C + D); endproperty
property p_sum3_correct; @(posedge clk) assert property (sum3 == sumreg1 + sumreg2); endproperty
property p_sum4_correct; @(posedge clk) assert property (sum4 == sumreg3 + E); endproperty
property p_out_correct; @(posedge clk) assert property (out == sumreg4); endproperty

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

endmodule