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

  always @(*) begin assert (@(posedge clk) $past(fib) + $past($past(fib)) == fib); end
  always @(*) begin assert (@(posedge clk) rst ? fib == 0 : 1'b0); end
  always @(*) begin assert (@(posedge clk) start & !rst ? count < n : 1'b0); end
  always @(*) begin assert (@(posedge clk) fib > 255); end

  always #5 clk = ~clk;
  initial begin
    rst = 1;
    #10 rst = 0;
    start = 1;
    n = 7;
  end
endmodule