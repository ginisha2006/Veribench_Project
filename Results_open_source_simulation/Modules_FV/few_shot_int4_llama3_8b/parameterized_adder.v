module tb_param_adder #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b;

  // Outputs
  wire [WIDTH-1:0] sum;
  wire carry;

  // Instantiate the DUT
  param_adder #(.WIDTH(WIDTH)) UUT (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if sum is correct
  property p_correct_sum;
    @(posedge clk) (sum == a + b);
  endproperty
  assert property (p_correct_sum);

  // Property: Check if carry is correct
  property p_correct_carry;
    @(posedge clk)
      ((a[WIDTH-1] && b[WIDTH-1]) || (!a[WIDTH-1] &&!b[WIDTH-1])) == carry;
  endproperty
  assert property (p_correct_carry);

  // Property: Check if sum is correct for all possible combinations
  property p_all_combinations;
    @(posedge clk)
      foreach (i [0:WIDTH-1])
        (sum[i] == (a[i] ^ b[i]));
  endproperty
  assert property (p_all_combinations);

endmodule