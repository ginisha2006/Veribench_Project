module tb_gray_count();

  // Inputs
  reg clk, enable, reset;

  // Output
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge clk) $past(gray_count) != gray_count); end

  always @(*) begin assert (@(posedge reset) gray_count == 8'b0); end

endmodule