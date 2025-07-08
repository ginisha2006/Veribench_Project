module tb_param_multiplier(
    input [7:0] a,
    input [7:0] b,
    output reg clk,
    output [15:0] product
);

reg [7:0] a_in;
reg [7:0] b_in;

assign a = a_in;
assign b = b_in;
assign {product} = a * b;

always #5 clk =~clk;

property p_clk;
 @(posedge clk) a !== a ##1 a !== a;
endproperty

assert property(p_clk);

property p_b;
 @(posedge clk) b !== b ##1 b !== b;
endproperty

assert property(p_b);

property p_product;
 @(posedge clk) (a == 0 |-> product == 0);
 @(posedge clk) (b == 0 |-> product == 0);
 @(posedge clk) (a != 0 & b != 0 |-> product != 0);
endproperty

assert property(p_product);

property p_overflow_underflow;
 @(posedge clk) ($signed(a) > 0 && $signed(b) > 0 |-> $unsigned(product) >= $unsigned({{8'b0,a}}));
 @(posedge clk) ($signed(a) < 0 && $signed(b) < 0 |-> $unsigned(product) >= $unsigned({{8'b0,a}}));
 @(posedge clk) ($signed(a) > 0 && $signed(b) < 0 |-> $unsigned(product) <= $unsigned({{8'b0,a}}));
 @(posedge clk) ($signed(a) < 0 && $signed(b) > 0 |-> $unsigned(product) <= $unsigned({{8'b0,a}}));
endproperty

assert property(p_overflow_underflow);

param_multiplier dut (
    .a(a),
    .b(b),
    .product(product)
);

endmodule