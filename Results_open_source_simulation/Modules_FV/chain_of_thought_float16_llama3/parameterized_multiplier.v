module tb_param_multiplier;

parameter WIDTH = 8;

input [WIDTH-1:0] a, b;

output [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.product(product));

property p_product_correctness;

@(posedge clk) disable iff (!rst_n) ($rose(product[WIDTH-1]) |=> ($onehot(product[WIDTH-1:0]));

assert property (p_product_correctness);

property p_zero_multiply;

@(posedge clk) disable iff (!rst_n) ((a == 0) |-> (product == 0));

assert property (p_zero_multiply);

property p_one_multiply;

@(posedge clk) disable iff (!rst_n) ((b == 0) |-> (product == 0));

assert property (p_one_multiply);

property p_overflow;

@(posedge clk) disable iff (!rst_n) ((|a) & (&b) |-> ($isunknown(product)));

assert property (p_overflow);

property p_underflow;

@(posedge clk) disable iff (!rst_n) ((~|a) & (~&b) |-> ($isunknown(product)));

assert property (p_underflow);

property p_edge_cases;

@(posedge clk) disable iff (!rst_n) ((a == 1'b0) |-> (product == 0));

assert property (p_edge_cases);

property p_edge_cases_2;

@(posedge clk) disable iff (!rst_n) ((b == 1'b0) |-> (product == 0));

assert property (p_edge_cases_2);

endmodule