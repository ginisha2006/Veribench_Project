module tb_fsm_1100();

  // Inputs
  reg clk, rst, bit_in;

  // Output
  wire pattern_detected;

  // Instantiate the DUT
  fsm_1100 UUT (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  property p_reset_behavior;
    @(posedge clk) disable iff (!rst)
      (rst |-> ##1 state == S0);
  endproperty
  assert property (p_reset_behavior);

  property p_next_state_S0;
    @(posedge clk) disable iff (rst)
      ((state == S0 && !bit_in) |=> state == S0) &&
      ((state == S0 && bit_in) |=> state == S1);
  endproperty
  assert property (p_next_state_S0);

  property p_next_state_S1;
    @(posedge clk) disable iff (rst)
      ((state == S1 && !bit_in) |=> state == S0) &&
      ((state == S1 && bit_in) |=> state == S2);
  endproperty
  assert property (p_next_state_S1);

  property p_next_state_S2;
    @(posedge clk) disable iff (rst)
      ((state == S2 && !bit_in) |=> state == S3) &&
      ((state == S2 && bit_in) |=> state == S2);
  endproperty
  assert property (p_next_state_S2);

  property p_next_state_S3;
    @(posedge clk) disable iff (rst)
      ((state == S3 && !bit_in) |=> state == S0) &&
      ((state == S3 && bit_in) |=> state == S1);
  endproperty
  assert property (p_next_state_S3);

  property p_pattern_detected;
    @(posedge clk) disable iff (rst)
      (state == S3 && !bit_in |-> pattern_detected);
  endproperty
  assert property (p_pattern_detected);

endmodule