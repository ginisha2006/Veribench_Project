module tb_shift_8x64_taps();

  // Inputs
  reg clk, shift;
  reg [7:0] sr_in;

  // Outputs
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  // Instantiate the DUT
  shift_8x64_taps UUT (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three),
    .sr_out(sr_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  assert (@(posedge clk) disable iff (!shift)
      sr_tap_one == sr[15]);

  assert (@(posedge clk) disable iff (!shift)
      sr_tap_two == sr[31]);

  assert (@(posedge clk) disable iff (!shift)
      sr_tap_three == sr[47]);

  assert (@(posedge clk) disable iff (!shift)
      sr_out == sr[63]);

  assert (@(posedge clk) disable iff (!shift)
      $stable(sr[62]) |-> sr[63] == sr[62]);

  assert (@(negedge clk) disable iff (!shift)
      sr[0] == sr_in);

  assert (@(posedge clk) disable iff (!shift)
      $rose(shift) |-> (sr[63] == sr_in && sr[62] == sr_in[7:0]));

endmodule