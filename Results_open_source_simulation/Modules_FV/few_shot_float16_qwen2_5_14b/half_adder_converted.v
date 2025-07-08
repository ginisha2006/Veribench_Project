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
  always @(*) begin assert (@(posedge $rose($anyedge {a,b})) (sum === (a ^ b))); end

  // Property: Correctness of Carry Output
  always @(*) begin assert (@(posedge $rose($anyedge {a,b})) (carry === (a & b))); end

endmodule