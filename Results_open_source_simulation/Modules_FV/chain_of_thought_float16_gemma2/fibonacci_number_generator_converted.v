module tb_fibonacci_gen (
);
  reg clk;
  reg rst;
  reg start;
  reg [7:0] n;
  wire [7:0] fib;

  fibonacci_gen #(8) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  always @(*) begin assert (@(posedge clk) $past(fib) + $past($past(fib)) == fib); end
  always @(*) begin assert (@(posedge clk) | rst == 1'b1  => fib == 8'd0); end
  always @(*) begin assert (@(posedge clk) start == 1'b1 && n != 8'h00 => count < n); end

  always #5 clk = ~clk;
  initial begin
    rst = 1'b1;
    #10 rst = 1'b0;
    start = 1'b0;
    n = 8'd5;
    start = 1'b1;
  end
endmodule