module tb_shift_8x64_taps;
// Inputs
reg clk;
reg shift;
reg [7:0] sr_in;
// Outputs
wire [7:0] sr_out, sr_tap_one, sr_tap_two, sr_tap_three;
// Instantiate the Shift Register with Taps
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
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	clk	shift	sr_in	sr_out	sr_tap_one	sr_tap_two	sr_tap_three");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b	%b", $time, clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
    // Initial state
    shift = 0; sr_in = 8'hAA; #20;
    // Start shifting
    shift = 1; sr_in = 8'hFF; #20;
    // Change input while shifting
    sr_in = 8'hBB; #20;
    // Stop shifting
    shift = 0; sr_in = 8'hCC; #20;
    // Restart shifting with different value
    shift = 1; sr_in = 8'hDD; #20;
    // Final stop and reset
    shift = 0; sr_in = 8'hz; #20;
    // Finish the simulation
    $finish;
end
endmodule