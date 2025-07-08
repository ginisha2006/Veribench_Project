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
  always @(*) begin assert (@(posedge clk) (sum === a ^ b)); end

  always @(*) begin assert (@(posedge clk) (carry === a & b)); end

endmodule