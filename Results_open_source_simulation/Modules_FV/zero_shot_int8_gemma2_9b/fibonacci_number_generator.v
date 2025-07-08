module tb_fibonacci_gen;

  localparam WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH) dut (clk, rst, start, n, fib);

  always #5 clk = ~clk;

  property p_fibonacci_sequence;
    @(posedge clk)
      $past(fib) == (dut.a + dut.b) &&
      $past(dut.a) == dut.b &&
      $past(dut.b) == (dut.a + dut.b);
  endproperty

  property p_n_iterations;
    @(posedge clk)
      count < n;
  endproperty

  property p_reset;
    @(posedge clk)
      rst ? (fib == 0) : 1;
  endproperty

  assert property(p_fibonacci_sequence);
  assert property(p_n_iterations);
  assert property(p_reset);

endmodule