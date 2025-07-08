module tb_shift_8x64_taps;

  reg clk;
  reg shift;
  reg [7:0] sr_in;
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  shift_8x64_taps dut (clk, shift, sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(sr_in) != sr_out);
  assert (@(posedge clk)
      sr_tap_one == sr[15] &&
      sr_tap_two == sr[31] &&
      sr_tap_three == sr[47]);

endmodule