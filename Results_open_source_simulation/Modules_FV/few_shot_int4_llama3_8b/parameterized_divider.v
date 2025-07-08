module tb_param_divider #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] dividend, divisor;

  // Outputs
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

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

  // Property: Check if quotient is correct
  property p_correct_quotient;
    @(posedge clk) (quotient == dividend / divisor);
  endproperty
  assert property (p_correct_quotient);

  // Property: Check if remainder is correct
  property p_correct_remainder;
    @(posedge clk) (remainder == dividend % divisor);
  endproperty
  assert property (p_correct_remainder);

  // Property: Check for division by zero
  property p_no_division_by_zero;
    @(posedge clk) (!$rose(divisor) | (dividend < divisor));
  endproperty
  assert property (p_no_division_by_zero);

endmodule