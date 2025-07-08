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

  // Property: Correctness of sum calculation
  property p_correct_sum;
    @(posedge clk) (sum == a + b);
  endproperty
  assert property (p_correct_sum);

  // Property: Carry should be high when there's an overflow
  property p_correct_carry;
    @(posedge clk) ((|{a[WIDTH-1], b[WIDTH-1]} && sum < a || sum < b) |-> carry);
  endproperty
  assert property (p_correct_carry);

endmodule