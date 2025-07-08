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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  
  // Property: Check if sum is correct
  always @(*) begin assert (@(posedge clk) (sum == (a ^ b ^ cin))); end

  // Property: Check if cout is correct
  always @(*) begin assert (@(posedge clk) (cout == ((a & b) | (b & cin) | (a & cin)))); end

endmodule