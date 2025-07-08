module tb_fibonacci_gen;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(fib) != fib && fib == $past($past(fib)) + $past($past($past(fib))));
  always @(*) begin assert (n >= 0); end
  always @(*) begin assert (!((fib == 0) || (fib == 255))); end

endmodule