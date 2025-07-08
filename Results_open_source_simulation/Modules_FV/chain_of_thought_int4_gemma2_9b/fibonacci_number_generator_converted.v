module tb_fibonacci_gen;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;
  wire [WIDTH-1:0] fib;

  fibonacci_gen #(WIDTH)(clk, rst, start, n, fib);

  always @(*) begin assert (@(posedge clk) $past(fib) + $past($past(fib)) == fib); end
  always @(*) begin assert (@(posedge clk) start && !rst -> fib == 0); end
  always @(*) begin assert (!rst && start && n >= 0); end
  always @(*) begin assert (!rst && start && n > 0 && fib != 0 && fib != 2**WIDTH - 1); end

  always #5 clk = ~clk;

endmodule