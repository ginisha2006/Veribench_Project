module tb_counter();

  // Inputs
  reg clk;
  reg reset;
  reg ena;

  // Output
  wire [7:0] result;

  // Instantiate the counter
  counter UUT (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge clk) (reset == 1'b1) -> result == 8'd0); end

  always @(*) begin assert (@(posedge clk) (ena == 1'b1) && (reset == 1'b0) -> result == result + 1); end

  always @(*) begin assert (@(posedge clk) (ena == 1'b0) -> result == result); end

endmodule