module tb_full_adder();

  // Inputs
  reg a, b, cin;
  reg clk;

  // Outputs
  wire sum, cout;

  // Instantiate the full adder
  full_adder UUT (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  // Clock generation for property evaluation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge clk) (sum == (a ^ b ^ cin))); end

  always @(*) begin assert (@(posedge clk) (cout == ((a & b) | (b & cin) | (a & cin)))); end

endmodule