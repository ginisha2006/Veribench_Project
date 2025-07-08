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
  assert (@(posedge $rose($anyseq(1'b1)) | posedge $fell($anyseq(1'b1))
       (sum === (a ^ b)));

  // Property: Correctness of carry calculation
  assert (@(posedge $rose($anyseq(1'b1)) | posedge $fell($anyseq(1'b1))
       (carry === (a & b)));

endmodule