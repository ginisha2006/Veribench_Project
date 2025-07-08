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
  // Property for edge case: shift = 0
  // Property for edge case: shift = 1
  // Property for overflow detection
  // Property for underflow detection
  // Assertion for functional correctness
  always @(*) begin always @(*) begin assert (@(posedge clk) ((|sr_tap_one) && (!|sr_tap_two) && (!|sr_tap_three)) |=> sr_in == sr_tap_one); end end

  // Assertion for edge case: shift = 0
  always @(*) begin always @(*) begin assert (@(posedge clk) ($rose(shift) |=> sr_tap_one == sr_in)); end end

  // Assertion for edge case: shift = 1
  always @(*) begin always @(*) begin assert (@(posedge clk) ($fell(shift) |=> sr_tap_one == sr_tap_two)); end end

  // Assertion for overflow detection
  always @(*) begin always @(*) begin assert (@(posedge clk) ($rose(shift) |=> sr_tap_one!= sr_tap_two)); end end

  // Assertion for underflow detection
  always @(*) begin always @(*) begin assert (@(posedge clk) ($fell(shift) |=> sr_tap_two!= sr_tap_three)); end end

endmodule