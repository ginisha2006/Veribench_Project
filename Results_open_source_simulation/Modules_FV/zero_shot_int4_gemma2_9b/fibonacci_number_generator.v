module tb_fibonacci_gen;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH) dut (clk, rst, start, n, fib);

  always #5 clk = ~clk;

  property p_fibonacci;
    @(posedge clk)
      (n == 0 || fib == 0) &&
      (n > 0 && fib == dut.a + dut.b);
  endproperty

  property p_reset;
    @(posedge clk)
      rst ? (dut.a == 0 && dut.b == 1 && fib == 0 && dut.count == 0) : 1;
  endproperty

  property p_start;
    @(posedge clk)
      start ? (dut.count < n) : 1;
  endproperty

  assert property (p_fibonacci);
  assert property (p_reset);
  assert property (p_start);

endmodule