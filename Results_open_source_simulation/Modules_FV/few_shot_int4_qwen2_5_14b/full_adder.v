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
  property p_correct_sum;
    @(posedge clk) (sum === (a ^ b ^ cin));
  endproperty
  assert property (p_correct_sum);

  // Property: Check if carry out is correct
  property p_correct_carry_out;
    @(posedge clk) (cout === ((a & b) | (b & cin) | (a & cin)));
  endproperty
  assert property (p_correct_carry_out);

endmodule