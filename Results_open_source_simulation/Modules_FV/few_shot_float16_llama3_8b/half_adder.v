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
    @(posedge clk) (carry == (a & b));
  endproperty
  assert property (p_correct_carry);

  // Property: Check if sum is correct when both inputs are 0
  property p_zero_sum;
    @(posedge clk) ((a == 0) && (b == 0) -> (sum == 0));
  endproperty
  assert property (p_zero_sum);

  // Property: Check if sum is correct when one input is 0
  property p_one_zero_sum;
    @(posedge clk) (((a == 0) | (b == 0)) -> (sum == (a ^ b)));
  endproperty
  assert property (p_one_zero_sum);

  // Property: Check if sum is correct when both inputs are 1
  property p_all_ones_sum;
    @(posedge clk) ((a == 1) && (b == 1) -> (sum == 1));
  endproperty
  assert property (p_all_ones_sum);

endmodule