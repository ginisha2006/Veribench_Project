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
  always @(*) begin assert (@(posedge clk) (n == 0) => (fib == 0)); end

  // Property: Check if fib is correct when n is 1
  always @(*) begin assert (@(posedge clk) (n == 1) => (fib == 1)); end

  // Property: Check if fib is correct for larger values of n
  always @(*) begin assert (@(posedge clk) ((n > 1) && (count == n)) => (fib == ($unsigned(a) + $unsigned(b)))); end

  // Property: Check if fib is reset correctly after restart
  always @(*) begin assert (@(posedge clk) (rst) => (fib == 0)); end

endmodule