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
  always @(*) begin assert (@(posedge clk) (reset ? result == 0 : 1'b0)); end

  always @(*) begin assert (@(posedge clk) (ena && !reset)  ? result == result + 1 : 1'b0); end

endmodule