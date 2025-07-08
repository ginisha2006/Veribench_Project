module tb_fibonacci_gen (
);
  parameter WIDTH = 8;
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  property p_fib_sequence;
    @(posedge clk) $past(fib) + $past($past(fib)) == fib;
  endproperty

  property p_reset;
    @(posedge clk) rst ? fib == 0 : 1'b0;
  endproperty

  property p_start;
    @(posedge clk) start & !rst ? count < n : 1'b0;
  endproperty

  property p_overflow;
    @(posedge clk) fib > 255;
  endproperty

  assert property (p_fib_sequence);
  assert property (p_reset);
  assert property (p_start);
  assert property (p_overflow);

  always #5 clk = ~clk;
  initial begin
    rst = 1;
    #10 rst = 0;
    start = 1;
    n = 7;
  end
endmodule