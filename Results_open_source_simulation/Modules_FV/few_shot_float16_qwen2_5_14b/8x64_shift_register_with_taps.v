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

  // Ensure that shifting occurs correctly when shift is high
  property p_shift_correct;
    @(posedge clk) disable iff (!shift)
      $rose(shift) |-> ##1 sr[1] === sr[0] && sr[2] === sr[1] &&
                       sr[3] === sr[2] && sr[4] === sr[3] &&
                       sr[5] === sr[4] && sr[6] === sr[5] &&
                       sr[7] === sr[6] && sr[8] === sr[7] &&
                       sr[9] === sr[8] && sr[10] === sr[9] &&
                       sr[11] === sr[10] && sr[12] === sr[11] &&
                       sr[13] === sr[12] && sr[14] === sr[13] &&
                       sr[15] === sr[14] && sr[16] === sr[15] &&
                       sr[17] === sr[16] && sr[18] === sr[17] &&
                       sr[19] === sr[18] && sr[20] === sr[19] &&
                       sr[21] === sr[20] && sr[22] === sr[21] &&
                       sr[23] === sr[22] && sr[24] === sr[23] &&
                       sr[25] === sr[24] && sr[26] === sr[25] &&
                       sr[27] === sr[26] && sr[28] === sr[27] &&
                       sr[29] === sr[28] && sr[30] === sr[29] &&
                       sr[31] === sr[30] && sr[32] === sr[31] &&
                       sr[33] === sr[32] && sr[34] === sr[33] &&
                       sr[35] === sr[34] && sr[36] === sr[35] &&
                       sr[37] === sr[36] && sr[38] === sr[37] &&
                       sr[39] === sr[38] && sr[40] === sr[39] &&
                       sr[41] === sr[40] && sr[42] === sr[41] &&
                       sr[43] === sr[42] && sr[44] === sr[43] &&
                       sr[45] === sr[44] && sr[46] === sr[45] &&
                       sr[47] === sr[46] && sr[48] === sr[47] &&
                       sr[49] === sr[48] && sr[50] === sr[49] &&
                       sr[51] === sr[50] && sr[52] === sr[51] &&
                       sr[53] === sr[52] && sr[54] === sr[53] &&
                       sr[55] === sr[54] && sr[56] === sr[55] &&
                       sr[57] === sr[56] && sr[58] === sr[57] &&
                       sr[59] === sr[58] && sr[60] === sr[59] &&
                       sr[61] === sr[60] && sr[62] === sr[61] &&
                       sr[63] === sr[62] && sr[63] === sr_in;
  endproperty
  assert property (p_shift_correct);

  // Ensure tap values are correct
  property p_tap_values;
    @(posedge clk) disable iff (!shift)
      $rose(shift)