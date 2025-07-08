module tb_fsm_1100();

  // Inputs
  reg clk;
  reg rst;
  reg bit_in;

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

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Pattern detection
  property p_pattern_detected;
    @(posedge clk) (pattern_detected == (bit_in == 0));
  endproperty
  assert property (p_pattern_detected);

  // Property: State machine behavior
  property p_fsm_behavior;
    @(posedge clk) ((bit_in) === (state == S1) | (bit_in) === (state == S2) | (bit_in) === (state == S3));
  endproperty
  assert property (p_fsm_behavior);

  // Property: Correct transition from S0 to S1
  property p_transition_S0_to_S1;
    @(posedge clk) (rst || (state == S0 && bit_in) === (next_state == S1));
  endproperty
  assert property (p_transition_S0_to_S1);

  // Property: Correct transition from S1 to S2
  property p_transition_S1_to_S2;
    @(posedge clk) (rst || (state == S1 && bit_in) === (next_state == S2));
  endproperty
  assert property (p_transition_S1_to_S2);

  // Property: Correct transition from S2 to S3
  property p_transition_S2_to_S3;
    @(posedge clk) (rst || (state == S2 && bit_in) === (next_state == S3));
  endproperty
  assert property (p_transition_S2_to_S3);

  // Property: Correct transition from S3 back to S0
  property p_transition_S3_back_to_S0;
    @(posedge clk) (rst || (state == S3 &&!bit_in) === (next_state == S0));
  endproperty
  assert property (p_transition_S3_back_to_S0);

endmodule