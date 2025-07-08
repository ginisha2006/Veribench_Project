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

  // Properties

  // Property: Correctness of sum calculation
  property p_correct_sum;
    @(posedge $rose($anyseq(1'b1)) | posedge $fell($anyseq(1'b1))
       (sum === (a ^ b));
  endproperty
  assert property (p_correct_sum);

  // Property: Correctness of carry calculation
  property p_correct_carry;
    @(posedge $rose($anyseq(1'b1)) | posedge $fell($anyseq(1'b1))
       (carry === (a & b));
  endproperty
  assert property (p_correct_carry);

endmodule