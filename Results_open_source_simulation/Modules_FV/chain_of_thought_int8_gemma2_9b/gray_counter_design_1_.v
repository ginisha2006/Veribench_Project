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

  property p_gray_count_increment;
    @(posedge clk) gray_count != gray_count;
  endproperty

  property p_gray_count_reset;
    @(posedge reset) gray_count == 8'b0;
  endproperty

  property p_gray_count_enable;
    @(posedge clk) disable iff (enable == 0) gray_count == gray_count;
  endproperty

  assert property (p_gray_count_increment);
  assert property (p_gray_count_reset);
  assert property (p_gray_count_enable);


endmodule