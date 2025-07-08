module tb_half_adder();

  // Inputs
  reg a, b;
  reg clk;

  // Outputs
  wire sum, carry;

  // Instantiate the half adder
  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Generate a clock for property evaluation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_correct_sum;
    @(posedge clk) (sum === a ^ b);
  endproperty
  assert property (p_correct_sum);

  property p_correct_carry;
    @(posedge clk) (carry === a & b);
  endproperty
  assert property (p_correct_carry);

endmodule