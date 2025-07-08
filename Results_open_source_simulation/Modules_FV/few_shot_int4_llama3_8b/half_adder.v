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

  // Property: Check if sum is correct
  property p_correct_sum;
    @(posedge clk) (sum == (a ^ b));
  endproperty
  assert property (p_correct_sum);

  // Property: Check if carry is correct
  property p_correct_carry;
    @(posedge clk) (carry == (a && b));
  endproperty
  assert property (p_correct_carry);

  // Property: Check if sum is correct when carry is 0
  property p_correct_sum_zero_carry;
    @(posedge clk) ((a ^ b) && (!a ||!b));
  endproperty
  assert property (p_correct_sum_zero_carry);

  // Property: Check if sum is correct when carry is 1
  property p_correct_sum_one_carry;
    @(posedge clk) ((a ^ b) && (a || b));
  endproperty
  assert property (p_correct_sum_one_carry);

endmodule