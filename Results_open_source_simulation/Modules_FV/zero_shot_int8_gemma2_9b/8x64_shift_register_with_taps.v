module tb_shift_8x64_taps;

  reg clk;
  reg shift;
  reg [7:0] sr_in;
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  shift_8x64_taps dut (clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);

  property p_shift_register;
    @(posedge clk)
      $past(sr_in) != sr_in |-> sr[0] == sr_in;
  endproperty

  property p_tap_values;
    @(posedge clk)
      sr_tap_one == sr[15] & sr_tap_two == sr[31] & sr_tap_three == sr[47];
  endproperty

  property p_data_propagation;
    @(posedge clk)
      sr[1] == sr[0] & sr[2] == sr[1] & ... & sr[63] == sr[62];
  endproperty

  assert property(p_shift_register);
  assert property(p_tap_values);
  assert property(p_data_propagation);

  always #5 clk = ~clk;

endmodule