module tb_fsm_1100;

  reg clk;
  reg rst;
  reg bit_in;
  wire pattern_detected;

  fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
  );

  always #5 clk = ~clk;

  property p_1100_pattern;
    @(posedge clk)
      $past(bit_in) == 1 && bit_in == 1 && $past($past(bit_in)) == 0;
  endproperty

  property p_reset;
    @(posedge clk)
      rst == 1 -> pattern_detected == 0;
  endproperty

  assert property (p_1100_pattern);
  assert property (p_reset);

endmodule