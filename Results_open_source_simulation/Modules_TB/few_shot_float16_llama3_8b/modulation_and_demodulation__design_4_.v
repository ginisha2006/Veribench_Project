timescale 1ns / 1ps
module tb_mod_demod;
// Parameter
parameter DATA_WIDTH = 16;  // Default width is 16 bits
// Clock and Reset
reg clk;
reg rst;
// Input Data
reg [DATA_WIDTH-1:0] data_in;
// Output Signals
wire [DATA_WIDTH-1:0] modulated_signal;
wire [DATA_WIDTH-1:0] demodulated_data;
// Instantiate the Modulation and Demodulation
mod_demod #(.DATA_WIDTH(DATA_WIDTH)) uut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Display the header for the output
    $display("Time	data_in	modulated_signal	demodulated_data");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, data_in, modulated_signal, demodulated_data);
    // Test Case 1: Test with random data
    data_in = $random; #100;
    // Test Case 2: Test with all zeros
    data_in = 0; #100;
    // Test Case 3: Test with all ones
    data_in = {DATA_WIDTH{1'b1}}; #100;
    // Test Case 4: Test with mid-value
    data_in = {DATA_WIDTH{1'b0}} | (1 << (DATA_WIDTH/2)); #100;
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk;