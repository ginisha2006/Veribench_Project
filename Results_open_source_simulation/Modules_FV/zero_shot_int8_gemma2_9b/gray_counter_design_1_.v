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

  property p_gray_code;
    @(posedge clk)
      $past(gray_count) != gray_count;
  endproperty

  property p_valid_gray_count;
    @(posedge clk)
      gray_count == {8{1'b0}} ||
      gray_count == {8{1'b1}};
  endproperty

  assert property(p_gray_code);
  assert property(p_valid_gray_count);

endmodule