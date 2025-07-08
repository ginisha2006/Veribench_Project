module tb_param_multiplier(
  );

  parameter WIDTH = 8;

  logic [WIDTH-1:0] a;
  logic [WIDTH-1:0] b;
  logic [2*WIDTH-1:0] product;

  param_multiplier #(WIDTH) dut (
    .a(a),
    .b(b),
    .product(product)
  );

  always @(*) begin assert (@(posedge clk) product == a * b); end

endmodule