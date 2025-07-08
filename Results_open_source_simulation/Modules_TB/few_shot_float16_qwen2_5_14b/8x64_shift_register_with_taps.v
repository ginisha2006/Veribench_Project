module tb_shift_8x64_taps;
// Inputs
reg clk;
reg shift;
reg [7:0] sr_in;
// Outputs
wire [7:0] sr_out;
wire [7:0] sr_tap_one;
wire [7:0] sr_tap_two;
wire [7:0] sr_tap_three;
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
    // Apply initial values
    shift = 0; sr_in = 8'hAA; #20;
    // Test case 1: No shifting
    shift = 0; sr_in = 8'hFF; #20;
    // Test case 2: Single shift
    shift = 1; sr_in = 8'h55; #20;
    // Test case 3: Multiple shifts
    shift = 1; sr_in = 8'h0F; #20;
    shift = 1; sr_in = 8'hF0; #20;
    shift = 1; sr_in = 8'hAB; #20;
    shift = 1; sr_in = 8'hCD; #20;
    // Check taps after multiple shifts
    shift = 0; sr_in = 8'hEF; #20;
    // Finish the simulation
    $finish;
end
endmodule