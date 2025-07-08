module tb_shift_8x64_taps;
// Clock
reg clk;
// Shift Enable
reg shift;
// Input
reg [7:0] sr_in;
// Outputs
wire [7:0] sr_tap_one;
wire [7:0] sr_tap_two;
wire [7:0] sr_tap_three;
wire [7:0] sr_out;
// Initialize the shift register
reg [7:0] sr [63:0];
integer n;
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
    // Initialize the clock
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize the shift register
    for (n = 0; n < 64; n++) begin
        sr[n] = 0;
    end
    sr[0] = 8'h12; // Initial value for the shift register
    // Display the header for the output
    $display("Time	shift	sr_in	sr_tap_one	sr_tap_two	sr_tap_three	sr_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, shift, sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);
    // Test the shift register
    shift = 0; sr_in = 0; #20;
    shift = 1; sr_in = 0; #20;
    shift = 0; sr_in = 8'h12; #20;
    shift = 1; sr_in = 8'h34; #20;
    // Finish the simulation
    $finish;
end
endmodule