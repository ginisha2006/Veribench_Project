module tb_fibonacci_gen;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH) dut (clk, rst, start, n, fib);

  always #5 clk = ~clk;

  assert (@(posedge clk)
      (n == 0 || fib == 0) &&
      (n > 0 && fib == dut.a + dut.b));
  assert (@(posedge clk)
      rst ? (dut.a == 0 && dut.b == 1 && fib == 0 && dut.count == 0) : 1);
  assert (@(posedge clk)
      start ? (dut.count < n) : 1);

endmodule