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
  always @(*) begin assert (@(posedge clk) (rst && !start) |-> (fib === 0 && $past(count) === 0)); end

  // Property: Correct Fibonacci sequence generation
  assert (@(posedge clk) disable iff (!rst || !start)
      (count < n) |-> (fib === fibonacci($past(count))));

  // Helper function to calculate Fibonacci number
  function [WIDTH-1:0] fibonacci;
    input [WIDTH-1:0] x;
    integer i;
    reg [WIDTH-1:0] a, b;
    begin
      a = 0;
      b = 1;
      for (i = 0; i < x; i = i + 1) begin
        fibonacci = a + b;
        a = b;
        b = fibonacci;
      end
    end
  endfunction

endmodule