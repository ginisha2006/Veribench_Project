module tb_shift_8x64_taps;
  // Inputs
  reg clk;
  reg shift;
  reg [7:0] sr_in;
  // Outputs
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;
  // Instantiate the Shift Register
  shift_8x64_taps uut (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
  );
  initial begin
    // Clock generation
    clk = 0; forever #5 clk = ~clk;
    // Stimulus
    shift = 0; #10;
    sr_in = 8'hAA; #10;
    shift = 1; #10;
    sr_in = 8'hBB; #10;
    shift = 1; #10;
    sr_in = 8'hCC; #10;
    shift = 1; #10;
    sr_in = 8'hDD; #10;
    // ... add more test cases as needed
    $finish;
  end
  // Monitoring
  initial begin
    $monitor("Time	clk	shift	sr_in	sr_out	sr_tap_one	sr_tap_two	sr_tap_three", $time, clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
  end
endmodule