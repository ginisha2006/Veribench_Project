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

property p_product_correctness;
    @(posedge clk) disable iff (!rst_n);
    ($rose(a) |=> $rose(b) |=> $rose(product));
endproperty

property p_zero_multiply_by_zero;
    @(posedge clk) disable iff (!rst_n);
    (a == 0) |-> (product == 0);
endproperty

property p_zero_multiply_nonzero;
    @(posedge clk) disable iff (!rst_n);
    (~$rose(a) & ~$rose(b)) |-> (product!= 0);
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst_n);
    ((a > (1 << (WIDTH - 1))) | (b > (1 << (WIDTH - 1)))) |-> (product!= (a * b));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst_n);
    ((a < -(1 << (WIDTH - 1))) | (b < -(1 << (WIDTH - 1)))) |-> (product!= (a * b));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst_n);
    ($fell(a) | $rise(a)) |-> ($rose(product));
    ($fell(b) | $rise(b)) |-> ($rose(product));
endproperty

property p_illegal_transition;
    @(posedge clk) disable iff (!rst_n);
    (~$rose(a) & ~$rose(b)) |-> (!$stable(product));
endproperty

assert property p_product_correctness;
assert property p_zero_multiply_by_zero;
assert property p_zero_multiply_nonzero;
assert property p_overflow;
assert property p_underflow;
assert property p_edge_cases;
assert property p_illegal_transition;

endmodule