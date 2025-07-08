module tb_param_adder #(parameter WIDTH = 8)();

  // Inputs
  reg [WIDTH-1:0] a, b;
  reg clk;

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

  // Property: Correctness of sum
  property p_correct_sum;
    @(posedge clk) (sum == a + b);
  endproperty
  assert property (p_correct_sum);

  // Property: Carry assertion on overflow
  property p_correct_carry;
    @(posedge clk)
      (carry === ((a[WIDTH-1] & b[WIDTH-1]) | (a[WIDTH-1] & sum[WIDTH-2]) | (b[WIDTH-1] & sum[WIDTH-2])));
  endproperty
  assert property (p_correct_carry);

endmodule