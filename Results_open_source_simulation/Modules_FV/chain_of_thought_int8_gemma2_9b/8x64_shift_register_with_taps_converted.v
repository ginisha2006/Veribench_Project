module tb_shift_8x64_taps;

  logic clk;
  logic shift;
  logic [7:0] sr_in;
  logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  shift_8x64_taps dut (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
    $past(sr_out) != sr_out && sr_out == sr_in);
  assert (@(posedge clk)
    sr_tap_one == sr[15] && sr_tap_two == sr[31] && sr_tap_three == sr[47]);

endmodule