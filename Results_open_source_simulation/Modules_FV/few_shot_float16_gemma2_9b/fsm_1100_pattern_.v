module tb_fsm_1100();

  reg clk;
  reg rst;
  reg bit_in;
  wire pattern_detected;

  // Instantiate the FSM
  fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Detect the 1100 pattern
  property p_detect_1100;
    @(posedge clk) (pattern_detected == 1);
  endproperty
  assert property (p_detect_1100);

endmodule