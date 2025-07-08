module tb_fibonacci_gen;
  // Parameters
  parameter WIDTH = 8;
  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  // Output
  wire [WIDTH-1:0] fib;
  // Instantiate the Fibonacci Generator
  fibonacci_gen #(WIDTH) uut (
      .clk(clk),
      .rst(rst),
      .start(start),
      .n(n),
      .fib(fib)
  );
  initial begin
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Reset and Start signals
    rst = 1; #10;
    rst = 0; #10;
    start = 0; #10;
    start = 1; #10;
    // Input value 'n'
    n = 5; #10;
    // Monitor the output
    $display("Time	n	fib");
    $monitor("%0d	%b	%b", $time, n, fib);
    #100;
    $finish;
  end
endmodule