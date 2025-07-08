module tb_param_multiplier;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [2*WIDTH-1:0] product;

  param_multiplier #(WIDTH)(a, b, product);

  property p_product;
    @(posedge clk) product == a * b;
  endproperty

  assert property (p_product);

endmodule