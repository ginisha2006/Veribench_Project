module tb_shift_8x64_taps();

  // Inputs
  reg clk, shift;
  reg [7:0] sr_in;

  // Outputs
  wire [7:0] sr_out, sr_tap_one, sr_tap_two, sr_tap_three;

  // Instantiate the DUT
  shift_8x64_taps UUT (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Correct shifting behavior
  assert (@(posedge clk) disable iff (!shift)
      $rose(shift) |-> ##[1:64] (sr[63:0] matches {sr_in[*], sr[62:0][*]}));

  // Property: Tap one value after 15 shifts
  assert (@(posedge clk) disable iff (!shift)
      $rose(shift) |-> ##15 (sr_tap_one === sr[15]));

  // Property: Tap two value after 31 shifts
  assert (@(posedge clk) disable iff (!shift)
      $rose(shift) |-> ##31 (sr_tap_two === sr[31]));

  // Property: Tap three value after 47 shifts
  assert (@(posedge clk) disable iff (!shift)
      $rose(shift) |-> ##47 (sr_tap_three === sr[47]));

endmodule