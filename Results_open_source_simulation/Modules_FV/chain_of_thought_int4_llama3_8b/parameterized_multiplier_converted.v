module tb_param_multiplier;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .product(product)
);

assert property p_product_correctness;
assert property p_zero_multiply_by_zero;
assert property p_zero_multiply_nonzero;
assert property p_overflow;
assert property p_underflow;
assert property p_edge_cases;
assert property p_illegal_transition;

endmodule