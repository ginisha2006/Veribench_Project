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
  always #5 clk = ~clk;

  // Properties

  // Property: Initial state after reset
  assert (@(posedge rst) disable iff (!rst)
      (rst && !start) |-> (UUT.fib === 0 && UUT.a === 0 && UUT.b === 1 && UUT.count === 0));

  // Property: Correct Fibonacci sequence generation
  assert (@(posedge clk) disable iff (!rst || !start)
      (UUT.start && UUT.count < UUT.n) |-> 
          (UUT.fib === UUT.a + UUT.b &&
           UUT.a === ##1 UUT.b &&
           UUT.b === ##1 UUT.a + UUT.b &&
           UUT.count === ##1 UUT.count + 1));

  // Property: Final value of fib should match the nth Fibonacci number
  assert (@(posedge clk) disable iff (!rst || !start)
      (UUT.start && UUT.count == UUT.n - 1) |-> (UUT.fib === UUT.a + UUT.b));

endmodule