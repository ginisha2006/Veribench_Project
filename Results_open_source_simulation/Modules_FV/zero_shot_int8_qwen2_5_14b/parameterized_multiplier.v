module tb_param_multiplier(
    input clk,
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] product
);

param_multiplier #(.WIDTH(8)) dut (
    .a(a),
    .b(b),
    .product(product)
);

property p_clk;
    @(posedge clk) disable iff (!reset) (product == a * b);
endproperty

assert property(p_clk);

property p_overflow;
    @(posedge clk) disable iff (!reset) ((a > 0 && b > 0 && product < 0) |-> $rose(product[15]));
endproperty

assert property(p_overflow);

property p_underflow;
    @(posedge clk) disable iff (!reset) ((a < 0 && b < 0 && product >= 0) |-> $rose(product[15]));
endproperty

assert property(p_underflow);

endmodule