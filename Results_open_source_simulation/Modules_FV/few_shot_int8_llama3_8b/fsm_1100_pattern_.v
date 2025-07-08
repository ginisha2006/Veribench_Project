module tb_fsm_1100();

  // Inputs
  reg clk, rst, bit_in;

  // Output
  reg pattern_detected;

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

  // Property: Pattern detected after 4 cycles
  property p_pattern_detected;
    @(posedge clk) [$rose(pattern_detected) && $countones($past(clk, 4)) == 4];
  endproperty
  assert property (p_pattern_detected);

  // Property: Pattern not detected before 4 cycles
  property p_no_pattern_detected_before;
    @(posedge clk) [$fell(pattern_detected) || $countones($past(clk, 4)) < 4];
  endproperty
  assert property (p_no_pattern_detected_before);

  // Property: Correct transition from S0 to S1
  property p_transition_S0_to_S1;
    @(posedge clk) ((state == S0) && (next_state == S1) && bit_in);
  endproperty
  assert property (p_transition_S0_to_S1);

  // Property: Correct transition from S1 to S2
  property p_transition_S1_to_S2;
    @(posedge clk) ((state == S1) && (next_state == S2) && bit_in);
  endproperty
  assert property (p_transition_S1_to_S2);

  // Property: Correct transition from S2 to S3
  property p_transition_S2_to_S3;
    @(posedge clk) ((state == S2) && (next_state == S3) &&!bit_in);
  endproperty
  assert property (p_transition_S2_to_S3);

  // Property: Correct transition from S3 to S1
  property p_transition_S3_to_S1;
    @(posedge clk) ((state == S3) && (next_state == S1) &&!bit_in);
  endproperty
  assert property (p_transition_S3_to_S1);

endmodule