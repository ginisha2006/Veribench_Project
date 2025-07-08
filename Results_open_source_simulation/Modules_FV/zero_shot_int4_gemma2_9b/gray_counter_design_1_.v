module tb_gray_count;

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (clk, enable, reset, gray_count);

  property p_gray_count_increment;
    @(posedge clk) gray_count != gray_count;
  endproperty

  property p_gray_count_overflow;
    @(posedge clk) gray_count == 8'hFF;
  endproperty

  property p_gray_count_underflow;
    @(posedge clk) gray_count == 8'h00;
  endproperty

  always #5 clk = ~clk;

  assert property (p_gray_count_increment);
  assert property (p_gray_count_overflow);
  assert property (p_gray_count_underflow);

endmodule