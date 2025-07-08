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
    @(posedge clk) (quotient * divisor + remainder == dividend);
  endproperty
  assert property (p_correct_quotient);

  // Property: Check if remainder is within valid range
  property p_correct_remainder;
    @(posedge clk) ($less($unsigned(remainder), $unsigned(divisor)));
  endproperty
  assert property (p_correct_remainder);

endmodule