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
  always #10 clk = ~clk;

  // Property: Check if taps are updated correctly
  assert (@(posedge clk) ((shift == 1'b1) => 
      (sr_tap_one == sr[$signed(15)] &&
       sr_tap_two == sr[$signed(31)] &&
       sr_tap_three == sr[$signed(47)]));

  // Property: Check if output is updated correctly
  always @(*) begin assert (@(posedge clk) ((shift == 1'b1) => sr_out == sr[$signed(63)])); end

  // Property: Check if register is shifted correctly
  assert (@(posedge clk) ((shift == 1'b1) => 
      (sr[63] == sr_in && 
       foreach (i [62:0]) sr[i+1] == sr[i])));

endmodule