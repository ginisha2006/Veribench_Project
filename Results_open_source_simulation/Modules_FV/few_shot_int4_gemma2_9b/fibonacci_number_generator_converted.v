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

  // Property: Check if output matches expected Fibonacci sequence
  assert (@(posedge clk)
      (fib == fibonacci_value(n, count)) && (count < n));

  function integer fibonacci_value(input [WIDTH-1:0] n, input [WIDTH-1:0] count);
    case (count)
      0: fibonacci_value = 0;
      1: fibonacci_value = 1;
      default: fibonacci_value = fibonacci_value(n, count - 1) + fibonacci_value(n, count - 2);
    endcase
  endfunction

endmodule