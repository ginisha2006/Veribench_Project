module tb_ternary_adder_tree;

parameter WIDTH = 16;

input wire clk;

input wire [WIDTH-1:0] a, b, c, d, e;

output wire [WIDTH-1:0] out;

ternary_adder_tree dut (.A(a),.B(b),.C(c),.D(d),.E(e),.CLK(clk),.OUT(out));

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a[WIDTH-1:0] == 0) | (b[WIDTH-1:0] == 0) | (c[WIDTH-1:0] == 0)) => ($rose(sum1[WIDTH-1:0]))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((sum1[WIDTH-1:0] == 0) | (d[WIDTH-1:0] == 0) | (e[WIDTH-1:0] == 0)) => ($rose(sum2[WIDTH-1:0]))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((sum2[WIDTH-1:0] == 0) => ($rose(out[WIDTH-1:0])))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a[WIDTH-1] + b[WIDTH-1] + c[WIDTH-1]) > WIDTH'd31) | ((sum1[WIDTH-1] + d[WIDTH-1] + e[WIDTH-1]) > WIDTH'd31)); end

assert property (~p_underflow);

endmodule