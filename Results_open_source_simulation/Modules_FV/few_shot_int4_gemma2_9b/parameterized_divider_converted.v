module tb_param_divider #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] dividend, divisor;

  // Outputs
  wire [WIDTH-1:0] quotient, remainder;

  // Instantiate the DUT
  param_divider #(.WIDTH(WIDTH)) UUT (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check quotient calculation
  always @(*) begin assert (@(posedge clk) (quotient == dividend / divisor)); end

  // Property: Check remainder calculation
  always @(*) begin assert (@(posedge clk) (remainder == dividend % divisor)); end

endmodule