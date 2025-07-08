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
  always @(*) begin assert (@(posedge rst) (rst) |=> ({fib, a, b, count} === 0)); end

  // Property: Start behavior when reset is low
  assert (@(posedge clk) disable iff (!rst)
      (start && count < n) |-> (count == n) |-> (fib == a + b));

  // Property: Correctness of Fibonacci sequence generation
  assert (@(posedge clk) disable iff (!rst)
      (start && count < n) |-> (fib == a + b) &&
                               (next_value_a == b) &&
                               (next_value_b == a + b));

endmodule