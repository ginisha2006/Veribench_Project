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
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize shift register
    for (n = 0; n < 64; n++) begin
        sr[n] = 0;
    end
    sr[0] = 8'h12; // Initial value for the shift register
    
    // Display the header for the output
    $display("Time	shift	sr_in	sr_tap_one	sr_tap_two	sr_tap_three	sr_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%h	%h	%h	%h	%h", $time, shift, sr_in, sr_tap_one, sr_tap_two, sr_tap_three, sr_out);
    // Test shifting
    shift = 0; sr_in = 8'h34; #20;
    shift = 1; #10;
    shift = 0; #10;
    shift = 1; #10;
    // Test different initial values
    sr[0] = 8'h56; #10;
    shift = 1; #10;
    shift = 0; #10;
    shift = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule