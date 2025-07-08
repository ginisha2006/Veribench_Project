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

  // Property: Check for overflow
  assert (@(posedge clk)
      ($unsigned(a) < (1 << WIDTH)) && ($unsigned(b) < (1 << WIDTH))
        |-> ($unsigned(product) < (1 << (WIDTH+1))));

  // Property: Check for underflow
  assert (@(posedge clk)
      ($unsigned(a) >= (1 << WIDTH)) || ($unsigned(b) >= (1 << WIDTH))
        |-> ($unsigned(product) >= (1 << WIDTH)));

endmodule