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
  property p_correct_sum;
    @(posedge clk) (sum == (a ^ b ^ cin));
  endproperty
  assert property (p_correct_sum);

  // Property: Correctness of carry out calculation
  property p_correct_cout;
    @(posedge clk) (cout == ((a & b) | (b & cin) | (a & cin)));
  endproperty
  assert property (p_correct_cout);

endmodule