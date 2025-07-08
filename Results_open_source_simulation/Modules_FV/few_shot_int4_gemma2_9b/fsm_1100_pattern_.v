module tb_fsm_1100();

  // Inputs
  reg clk;
  reg rst;
  reg bit_in;

  // Output
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

  // Assertions
  property p_correct_transition;
    @(posedge clk)
      (dut.state == dut.next_state);
  endproperty
  assert property (p_correct_transition);

  property p_1100_pattern;
    @(posedge clk)
      (dut.pattern_detected == (dut.state == 3'b110));
  endproperty
  assert property (p_1100_pattern);


endmodule