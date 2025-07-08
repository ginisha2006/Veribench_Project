module tb_gray_count;

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (clk, enable, reset, gray_count);

  property p_reset;
    @(posedge reset) gray_count == 8'b00000000;
  endproperty

  property p_enable;
    @(posedge clk) disable iff (enable == 0);
  endproperty

  property p_gray_sequence;
    $sformatf("Gray sequence check failed");
    @(posedge clk) gray_count != gray_count[7:1];
  endproperty

  assert property (p_reset);
  assert property (p_enable);
  assert property (p_gray_sequence);


endmodule