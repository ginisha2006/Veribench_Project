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
  property p_reset_behavior;
    @(posedge reset) gray_count == 8'h0;
  endproperty
  assert property (p_reset_behavior);

  property p_enable_sequence;
    @(posedge clk)
      gray_count != gray_count;
  endproperty
  assert property (p_enable_sequence);

endmodule