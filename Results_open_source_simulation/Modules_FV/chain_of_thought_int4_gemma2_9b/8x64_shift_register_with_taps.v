module tb_shift_8x64_taps;

  logic clk;
  logic shift;
  logic [7:0] sr_in;
  logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  shift_8x64_taps dut (clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);

  always #5 clk = ~clk;

  property p_shift_register_correctness;
    @(posedge clk)
      $past(sr_in) != sr_out;
  endproperty

  property p_tap_values;
    @(posedge clk)
      sr_tap_one == sr[15] &&
      sr_tap_two == sr[31] &&
      sr_tap_three == sr[47];
  endproperty

  property p_no_illegal_transitions;
    @(posedge clk)
      |sr_in[i] != sr[i] |-> !shift;
  endproperty

  assert property (p_shift_register_correctness);
  assert property (p_tap_values);
  assert property (p_no_illegal_transitions);

endmodule