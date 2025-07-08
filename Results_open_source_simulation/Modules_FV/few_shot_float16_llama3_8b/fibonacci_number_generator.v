module tb_fibonacci_gen #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;

  // Output
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

  // Property: Check if fib is correct when n is 0
  property p_zero_input;
    @(posedge clk) (n == 0) => (fib == 0);
  endproperty
  assert property (p_zero_input);

  // Property: Check if fib is correct when n is 1
  property p_one_input;
    @(posedge clk) (n == 1) => (fib == 1);
  endproperty
  assert property (p_one_input);

  // Property: Check if fib is correct for larger values of n
  property p_large_n;
    @(posedge clk) ((n > 1) && (count == n)) => (fib == ($unsigned(a) + $unsigned(b)));
  endproperty
  assert property (p_large_n);

  // Property: Check if fib is reset correctly after restart
  property p_reset;
    @(posedge clk) (rst) => (fib == 0);
  endproperty
  assert property (p_reset);

endmodule