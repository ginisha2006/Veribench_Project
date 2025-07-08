module tb_shift_8x64_taps;
// Clock
reg clk;
// Control signals
reg shift;
// Input data
reg [7:0] sr_in;
// Tap outputs
wire [7:0] sr_tap_one;
wire [7:0] sr_tap_two;
wire [7:0] sr_tap_three;
wire [7:0] sr_out;
// Shift register
reg [7:0] sr [63:0];
integer n;

initial begin
    // Initialize the shift register
    for (n = 0; n < 64; n++) begin
        sr[n] = 8'h00;
    end
    // Display the header for the output
    $display("Time	clk	shift	sr_in	sr_tap_one	sr_tap_two	sr_tap_three	sr_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, clk, shift, sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);
    // Test Case 1: Shift in new data
    clk = 0; shift = 0; #20; clk = 1; #10; shift = 1; #10; clk = 0; #10; clk = 1; #10; sr_in = 8'hAA; #10;
    // Test Case 2: Multiple shifts without changing input
    clk = 0; shift = 0; #20; clk = 1; #10; shift = 1; #10; clk = 0; #10; clk = 1; #10; #100; #10;
    // Test Case 3: Shift out taps
    clk = 0; shift = 0; #20; clk = 1; #10; shift = 1; #10; clk = 0; #10; clk = 1; #10; sr_in = 8'h00; #10;
    // Finish the simulation
    $finish;
end
endmodule