module tb_shift_8x64_taps;
  reg clk;
  reg shift;
  reg [7:0] sr_in;
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  // Instantiate the Shift Register
  shift_8x64_taps dut (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize input pattern
    sr_in = 8'hAA;
    #10; // Wait for initial clock cycle
    shift = 1'b1; // Start shifting
    #100; // Shift for 100 cycles
    shift = 1'b0; // Stop shifting
    #10; // Wait for final clock cycle
    $finish;
  end

  // Monitor signals
  always @(posedge clk) begin
    $display("Time %0d: clk=%b, shift=%b, sr_in=%b, sr_out=%b, sr_tap_one=%b, sr_tap_two=%b, sr_tap_three=%b", $time, clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
  end

endmodule