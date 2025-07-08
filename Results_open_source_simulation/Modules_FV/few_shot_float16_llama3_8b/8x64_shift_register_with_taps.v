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
   .sr_out(sr_out),
   .sr_tap_one(sr_tap_one),
   .sr_tap_two(sr_tap_two),
   .sr_tap_three(sr_tap_three)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if taps are updated correctly
  property p_tap_update;
    @(posedge clk) ((shift == 1'b1) => 
      (sr_tap_one == sr[15]) && 
      (sr_tap_two == sr[31]) && 
      (sr_tap_three == sr[47]));
  endproperty
  assert property (p_tap_update);

  // Property: Check if output is updated correctly
  property p_output_update;
    @(posedge clk) ((shift == 1'b1) => sr_out == sr[63]);
  endproperty
  assert property (p_output_update);

  // Property: Check if register is shifted correctly
  property p_register_shift;
    @(posedge clk) ((shift == 1'b1) => 
      (sr[63] == sr_in) &&
      (sr[62:56] == sr[63-1 downto 57]));
  endproperty
  assert property (p_register_shift);

endmodule