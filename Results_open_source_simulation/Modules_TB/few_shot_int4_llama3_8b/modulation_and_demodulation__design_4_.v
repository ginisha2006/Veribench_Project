module tb_mod_demod;
// Parameter
parameter DATA_WIDTH = 16;  // Default data width is 16 bits
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
    clk = 0; rst = 1; #10; rst = 0;
    // Display the header for the output
    $display("Time	data_in	modulated_signal	demodulated_data");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, data_in, modulated_signal, demodulated_data);
    // Test Case 1: No modulation
    data_in = 0; #20;
    // Test Case 2: Modulate with ones
    data_in = {DATA_WIDTH{1'b1}}; #20;
    // Test Case 3: Modulate with zeros
    data_in = {DATA_WIDTH{1'b0}}; #20;
    // Test Case 4: Modulate with random data
    data_in = $random % (1 << DATA_WIDTH); #20;
    // Finish the simulation
    $finish;
end
endmodule