module tb_fibonacci_gen #(parameter WIDTH = 8) ();

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;

  // Outputs
  wire [WIDTH-1:0] fib;

  // Instantiate the DUT
  fibonacci_gen #(.WIDTH(WIDTH)) UUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = !clk;

  // Properties

  // Property: Reset behavior
  property p_reset_behavior;
    @(posedge rst) (rst) |=> ({fib, a, b, count} === 0);
  endproperty
  assert property (p_reset_behavior);

  // Property: Start behavior when reset is low
  property p_start_behavior;
    @(posedge clk) disable iff (!rst)
      (start && count < n) |-> (count == n) |-> (fib == a + b);
  endproperty
  assert property (p_start_behavior);

  // Property: Correctness of Fibonacci sequence generation
  property p_fibonacci_sequence;
    @(posedge clk) disable iff (!rst)
      (start && count < n) |-> (fib == a + b) &&
                               (next_value_a == b) &&
                               (next_value_b == a + b);
  endproperty
  assert property (p_fibonacci_sequence);

endmodule