timescale 1ns / 1ps
module tb_fsm_1100;
// Clock and reset signals
reg clk;
reg rst;
// Input signal
reg bit_in;
// Output signal
wire pattern_detected;
// Instantiate the Finite State Machine
fsm_1100 uut (
   .clk(clk),
   .rst(rst),
   .bit_in(bit_in),
   .pattern_detected(pattern_detected)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Monitor changes to outputs
    $monitor($time, " clk=%b, rst=%b, bit_in=%b, pattern_detected=%b", clk, rst, bit_in, pattern_detected);
    // Test Case 1: No pattern detected
    bit_in = 0; #100; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #50; bit_in = 1; #50; bit_in = 0; #