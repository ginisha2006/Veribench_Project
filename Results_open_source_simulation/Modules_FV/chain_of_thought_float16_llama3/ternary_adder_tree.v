module tb_ternary_adder_tree;

parameter WIDTH = 16;

input wire clk;

input wire [WIDTH-1:0] a, b, c, d, e;

output wire [WIDTH-1:0] out;

ternary_adder_tree dut (.A(a),.B(b),.C(c),.D(d),.E(e),.CLK(clk),.OUT(out));

property p_sum1_valid; @(posedge clk) disable iff (!clk) ((a[WIDTH-1:0] == 0) | (b[WIDTH-1:0] == 0) | (c[WIDTH-1:0] == 0)) => ($rose(sum1[WIDTH-1:0])); endproperty

property p_sum2_valid; @(posedge clk) disable iff (!clk) ((sum1[WIDTH-1:0] == 0) | (d[WIDTH-1:0] == 0) | (e[WIDTH-1:0] == 0)) => ($rose(sum2[WIDTH-1:0])); endproperty

property p_out_valid; @(posedge clk) disable iff (!clk) ((sum2[WIDTH-1:0] == 0) => ($rose(out[WIDTH-1:0]))); endproperty

property p_overflow; @(posedge clk) disable iff (!clk) ((a[WIDTH-1] + b[WIDTH-1] + c[WIDTH-1]) > WIDTH'd31) | ((sum1[WIDTH-1] + d[WIDTH-1] + e[WIDTH-1]) > WIDTH'd31); endproperty

property p_underflow; @(posedge clk) disable iff (!clk) ((a[WIDTH-1] + b[WIDTH-1] + c[WIDTH-1]) < -WIDTH'd30) | ((sum1[WIDTH-1] + d[WIDTH-1] + e[WIDTH-1]) < -WIDTH'd30); endproperty

assert property (p_sum1_valid);

assert property (p_sum2_valid);

assert property (p_out_valid);

assert property (p_overflow);

assert property (~p_underflow);

endmodule