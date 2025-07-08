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
  always @(*) begin assert (@(posedge clk) (sum == (a ^ b))); end

  // Property: Check if carry is correct
  always @(*) begin assert (@(posedge clk) (carry == (a & b))); end

  // Property: Check if sum is correct when both inputs are 0
  always @(*) begin assert (@(posedge clk) ((a == 0) && (b == 0) -> (sum == 0))); end

  // Property: Check if sum is correct when one input is 0
  always @(*) begin assert (@(posedge clk) (((a == 0) | (b == 0)) -> (sum == (a ^ b)))); end

  // Property: Check if sum is correct when both inputs are 1
  always @(*) begin assert (@(posedge clk) ((a == 1) && (b == 1) -> (sum == 1))); end

endmodule