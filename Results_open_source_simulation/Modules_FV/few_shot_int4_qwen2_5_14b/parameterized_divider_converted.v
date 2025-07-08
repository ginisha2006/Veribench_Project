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
  assert (@(posedge $rose(dividend || divisor))
      (quotient === (dividend / divisor)));

  // Property: Check if remainder is correct
  assert (@(posedge $rose(dividend || divisor))
      (remainder === (dividend % divisor)));

  // Edge case: Division by zero should result in undefined behavior
  assert (@(posedge $rose(divisor))
      (divisor === 0) |-> $isunknown(quotient) && $isunknown(remainder));

endmodule