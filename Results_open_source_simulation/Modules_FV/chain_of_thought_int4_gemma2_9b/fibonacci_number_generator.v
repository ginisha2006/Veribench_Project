module tb_fibonacci_gen;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH)(clk, rst, start, n, fib);

  property p_fibonacci_sequence;
    @(posedge clk) $past(fib) + $past($past(fib)) == fib;
  endproperty

  property p_start_condition;
    @(posedge clk) start && !rst -> fib == 0;
  endproperty

  property p_n_range;
    !rst && start && n >= 0;
  endproperty

  property p_overflow;
    !rst && start && n > 0 && fib != 0 && fib != 2**WIDTH - 1;
  endproperty

  assert property (p_fibonacci_sequence);
  assert property (p_start_condition);
  assert property (p_n_range);
  assert property (p_overflow);

  always #5 clk = ~clk;

endmodule