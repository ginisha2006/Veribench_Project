module tb_half_adder();

  // Inputs
  reg a, b;

  // Outputs
  wire sum, carry;

  // Instantiate the DUT
  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Properties for Formal Verification

  // Property: Correctness of Sum Output
  property p_correct_sum;
    @(posedge $rose($anyedge {a,b})) (sum === (a ^ b));
  endproperty
  assert property (p_correct_sum);

  // Property: Correctness of Carry Output
  property p_correct_carry;
    @(posedge $rose($anyedge {a,b})) (carry === (a & b));
  endproperty
  assert property (p_correct_carry);

endmodule