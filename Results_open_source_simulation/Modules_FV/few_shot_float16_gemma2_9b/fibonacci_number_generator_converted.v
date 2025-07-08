module tb_fibonacci_gen #(parameter WIDTH = 8);

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [WIDTH-1:0] n;

  // Output
  wire [WIDTH-1:0] fib;

  // Instantiate the DUT
  fibonacci_gen #(WIDTH) UUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge clk) (rst ? (fib == 0 && a == 0 && b == 1 && count == 0) : 1'b1)); end

  always @(*) begin assert (@(posedge clk) (fib == a + b)); end

  always @(*) begin assert (@(posedge clk) (start && count < n ? count == count + 1 : 1'b1)); end

  always @(*) begin assert (@(posedge clk) (start && count == n ? 1'b1 : 1'b0)); end


endmodule