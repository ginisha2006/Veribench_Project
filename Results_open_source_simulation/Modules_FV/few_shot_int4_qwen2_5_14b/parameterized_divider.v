module tb_param_divider #(parameter WIDTH = 8)();

  // Inputs
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

  // Properties

  // Property: Check if quotient is correct
  property p_correct_quotient;
    @(posedge $rose(dividend || divisor))
      (quotient === (dividend / divisor));
  endproperty
  assert property (p_correct_quotient);

  // Property: Check if remainder is correct
  property p_correct_remainder;
    @(posedge $rose(dividend || divisor))
      (remainder === (dividend % divisor));
  endproperty
  assert property (p_correct_remainder);

  // Edge case: Division by zero should result in undefined behavior
  property p_div_by_zero;
    @(posedge $rose(divisor))
      (divisor === 0) |-> $isunknown(quotient) && $isunknown(remainder);
  endproperty
  assert property (p_div_by_zero);

endmodule