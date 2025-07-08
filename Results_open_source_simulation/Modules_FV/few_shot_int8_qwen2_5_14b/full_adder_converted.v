module tb_full_adder();

  // Inputs
  reg a, b, cin;
  reg clk;

  // Outputs
  wire sum, cout;

  // Instantiate the DUT
  full_adder UUT (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Correctness of sum calculation
  always @(*) begin assert (@(posedge clk) (sum == (a ^ b ^ cin))); end

  // Property: Correctness of carry out calculation
  always @(*) begin assert (@(posedge clk) (cout == ((a & b) | (b & cin) | (a & cin)))); end

endmodule