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
  integer i;
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if taps are updated correctly
  assert (@(posedge clk) ((shift == 1'b1) => 
      (sr_tap_one == sr[15]) && (sr_tap_two == sr[31]) && (sr_tap_three == sr[47])));

  // Property: Check if output is updated correctly
  always @(*) begin assert (@(posedge clk) (sr_out == sr[63])); end

  // Property: Check if register is shifted correctly
  assert (@(posedge clk) ((shift == 1'b1) => 
      (sr[63 downto 56] == sr[55 downto 48]) &&
      (sr[55 downto 48] == sr[47 downto 40]) &&
      (sr[47 downto 40] == sr[39 downto 32]) &&
      (sr[39 downto 32] == sr[31 downto 24]) &&
      (sr[31 downto 24] == sr[23 downto 16]) &&
      (sr[23 downto 16] == sr[15 downto 8]) &&
      (sr[15 downto 8] == sr[7 downto 0])));

endmodule