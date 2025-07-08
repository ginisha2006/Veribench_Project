module fibonacci_gen_tb #(parameter WIDTH = 8);

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH) dut (clk, rst, start, n, fib);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    n = 5;
    start = 1;
    #10 start = 0;
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b start=%b n=%d fib=%d", $time, clk, rst, start, n, fib);
  end

endmodule