module tb_gray_count;

  logic clk;
  logic enable;
  logic reset;
  logic [7:0] gray_count;

  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(gray_count) != gray_count);
  assert (@(posedge reset)
      gray_count == 8'b0);

endmodule