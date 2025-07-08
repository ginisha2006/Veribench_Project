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

always @(*) begin assert (@(posedge clk) disable iff (!reset) (product == a * b)); end

always @(*) begin assert (@(posedge clk) disable iff (!reset) ((a > 0 && b > 0 && product < 0) |-> $rose(product[15]))); end

always @(*) begin assert (@(posedge clk) disable iff (!reset) ((a < 0 && b < 0 && product >= 0) |-> $rose(product[15]))); end

endmodule