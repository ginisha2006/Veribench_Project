module tb_gray_count;

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

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(gray_count) != gray_count);
  assert (@(posedge clk)
      gray_count == {8{1'b0}} ||
      gray_count == {8{1'b1}});

endmodule