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

  property p_fibonacci_sequence;
    @(posedge clk)
      $past(fib) != fib && fib == $past($past(fib)) + $past($past($past(fib)));
  endproperty

  property p_valid_n;
    n >= 0;
  endproperty

  property p_overflow;
    !((fib == 0) || (fib == 255));
  endproperty

  assert property (p_fibonacci_sequence);
  assert property (p_valid_n);
  assert property (p_overflow);

endmodule