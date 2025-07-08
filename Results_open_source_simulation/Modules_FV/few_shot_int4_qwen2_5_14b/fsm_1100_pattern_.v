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
  always #5 clk = !clk;

  // Properties
  property p_rst_resets_state;
    @(posedge rst) disable iff (!rst)
      $rose(rst) |=> (UUT.state == 2'b00);
  endproperty
  assert property (p_rst_resets_state);

  property p_next_state_transitions;
    @(posedge clk) disable iff (!rst)
      (UUT.bit_in === 1'b1 && UUT.state === 2'b00) |-> ##1 UUT.state === 2'b01;
    (UUT.bit_in === 1'b1 && UUT.state === 2'b01) |-> ##1 UUT.state === 2'b10;
    (UUT.bit_in === 1'b0 && UUT.state === 2'b10) |-> ##1 UUT.state === 2'b11;
    (UUT.bit_in === 1'b0 && UUT.state === 2'b11) |-> ##1 UUT.state === 2'b00;
  endproperty
  assert property (p_next_state_transitions);

  property p_pattern_detected;
    @(posedge clk) disable iff (!rst)
      (UUT.state === 2'b11 && UUT.bit_in === 1'b0) |-> UUT.pattern_detected;
  endproperty
  assert property (p_pattern_detected);

endmodule