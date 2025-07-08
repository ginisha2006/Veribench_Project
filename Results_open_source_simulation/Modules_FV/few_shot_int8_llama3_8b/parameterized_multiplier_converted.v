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
  always @(*) begin assert (@(posedge clk) (product == a * b)); end

  // Property: Check if product is zero when either operand is zero
  always @(*) begin assert (@(posedge clk) ((a == 0) | (b == 0)) => (product == 0)); end

  // Property: Check if product is correct for small values
  always @(*) begin assert (@(posedge clk) ((a < 4'h8) && (b < 4'h8)) => (product == a * b)); end

endmodule