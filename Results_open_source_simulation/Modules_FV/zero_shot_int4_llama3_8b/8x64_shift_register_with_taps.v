module tb_shift_8x64_taps();
  // Input and output signals declaration
  input logic clk;
  input logic shift;
  input [7:0] sr_in;
  output [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  // DUT instantiation
  shift_8x64_taps dut (.clk(clk),.shift(shift),.sr_in(sr_in),.sr_out(sr_tap_one),.sr_tap_one(sr_tap_one),.sr_tap_two(sr_tap_two),.sr_tap_three(sr_tap_three));

  // Clock signal generation
  always #10 clk = ~clk;

  // Property for functional correctness
  property p_correctness;
    @(posedge clk) ((|sr_tap_one) && (!|sr_tap_two) && (!|sr_tap_three)) |=> sr_in == sr_tap_one;
  endproperty

  // Property for edge case: shift = 0
  property p_edge_case_zero;
    @(posedge clk) ($rose(shift) |=> sr_tap_one == sr_in);
  endproperty

  // Property for edge case: shift = 1
  property p_edge_case_one;
    @(posedge clk) ($fell(shift) |=> sr_tap_one == sr_tap_two);
  endproperty

  // Property for overflow detection
  property p_overflow;
    @(posedge clk) ($rose(shift) |=> sr_tap_one!= sr_tap_two);
  endproperty

  // Property for underflow detection
  property p_underflow;
    @(posedge clk) ($fell(shift) |=> sr_tap_two!= sr_tap_three);
  endproperty

  // Assertion for functional correctness
  assert property (p_correctness);

  // Assertion for edge case: shift = 0
  assert property (p_edge_case_zero);

  // Assertion for edge case: shift = 1
  assert property (p_edge_case_one);

  // Assertion for overflow detection
  assert property (p_overflow);

  // Assertion for underflow detection
  assert property (p_underflow);

endmodule