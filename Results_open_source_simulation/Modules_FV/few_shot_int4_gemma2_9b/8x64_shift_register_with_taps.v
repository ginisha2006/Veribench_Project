module tb_shift_8x64_taps ();

  // Inputs
  reg clk;
  reg shift;
  reg [7:0] sr_in;

  // Outputs
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_shift_register;
    @(posedge clk)
      $past(sr_in) != sr_out;
  endproperty
  assert property (p_shift_register);

  property p_tap_values;
    @(posedge clk)
      sr_tap_one == sr[15] &&
      sr_tap_two == sr[31] &&
      sr_tap_three == sr[47];
  endproperty
  assert property (p_tap_values);


endmodule