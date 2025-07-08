module tb_fibonacci_gen #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;

  // Output
  wire [WIDTH-1:0] fib;

  // Instantiate the DUT
  fibonacci_gen #(WIDTH) UUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Correct Fibonacci sequence generation
  assert (@(posedge clk)
      (fib == (n == 0 ? 0 : (n == 1 ? 1 : fib[WIDTH-1:1] + fib[WIDTH-2:0]))));

  // Property: Sequence length matches input 'n'
  assert (@(posedge clk)
      (count < n));

  // Property: Start signal triggers sequence generation
  assert (@(posedge clk)
      (start && !rst) == (count != 0));



endmodule