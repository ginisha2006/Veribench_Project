module fibonacci_gen_tb;

  reg clk;
  reg rst;
  reg start;
  reg [7:0] n;
  wire [7:0] fib;

  fibonacci_gen dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    n = 8;
    start = 1;
    #100 start = 0;
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b start=%b n=%h fib=%h", $time, clk, rst, start, n, fib);
  end

endmodule