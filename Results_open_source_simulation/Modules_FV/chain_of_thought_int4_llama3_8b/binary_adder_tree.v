module tb_binary_adder_tree;

parameter PERIOD = 10;

input [15:0] A, B, C, D, E;
input clk;
output [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

property p_sum1_correct;
@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) => $equal(sum1, A + B)));
endproperty

property p_sum2_correct;
@(posedge clk) ($rose(clk) |=> ($onehot(C) && $onehot(D) => $equal(sum2, C + D)));
endproperty

property p_sum3_correct;
@(posedge clk) ($rose(clk) |=> ($onehot(sumreg1) && $onehot(sumreg2) => $equal(sum3, sumreg1 + sumreg2)));
endproperty

property p_sum4_correct;
@(posedge clk) ($rose(clk) |=> ($onehot(sumreg3) && $onehot(E) => $equal(sum4, sumreg3 + E)));
endproperty

property p_out_correct;
@(posedge clk) ($rose(clk) |=> ($onehot(sumreg4) => $equal(out, sumreg4)));
endproperty

property p_edge_cases;
@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) && $onehot(C) && $onehot(D) && $onehot(E) => $distinct(out, {A, B, C, D, E})));
endproperty

property p_overflow_underflow;
@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) && $onehot(C) && $onehot(D) && $onehot(E) => $distinct(out, {A + B, C + D, sumreg1 + sumreg2, sumreg3 + E})));
endproperty

assert property (p_sum1_correct);
assert property (p_sum2_correct);
assert property (p_sum3_correct);
assert property (p_sum4_correct);
assert property (p_out_correct);
assert property (p_edge_cases);
assert property (p_overflow_underflow);

endmodule