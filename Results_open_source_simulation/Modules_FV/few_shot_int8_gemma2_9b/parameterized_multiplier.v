module tb_param_multiplier #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b;

  // Output
  wire [2*WIDTH-1:0] product;

  // Instantiate the DUT
  param_multiplier #(.WIDTH(WIDTH)) UUT (
    .a(a),
    .b(b),
    .product(product)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if product is correct
  property p_correct_product;
    @(posedge clk) (product == a * b);
  endproperty
  assert property (p_correct_product);

endmodule