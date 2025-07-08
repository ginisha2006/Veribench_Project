module tb_gray_count();

  // Inputs
  reg clk;
  reg enable;
  reg reset;

  // Output
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count UUT (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge reset) gray_count == 8'h0); end

  assert (@(posedge clk)
      | gray_count != 8'h0 && !reset
      || gray_count == 8'h0 && reset);

  assert (@(posedge clk)
      gray_count[i] != gray_count[i-1] && !reset
      && !enable);


endmodule