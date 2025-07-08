module tb_gray_count();

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge reset) gray_count == 8'h0); end

  assert (@(posedge clk)
      gray_count != gray_count);

endmodule