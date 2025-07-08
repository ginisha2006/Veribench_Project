module tb_fft_module;
// Parameters
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;
// Clock and reset signals
reg clk;
reg rst;
// Start signal
reg start;
// Input data
reg [DATA_WIDTH-1:0] data_in;
// Output data
wire [DATA_WIDTH-1:0] data_out;
// Done flag
wire done;
// Instantiate the FFT Module
fft_module #(.DATA_WIDTH(DATA_WIDTH),.FFT_POINTS(FFT_POINTS)) uut (
   .clk(clk), 
   .rst(rst), 
   .start(start), 
   .data_in(data_in), 
   .data_out(data_out), 
   .done(done)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Initialize start signal
    start = 0;
    // Initialize input data
    data_in = 0;
    // Display the header for the output
    $display("Time	data_in	data_out	done");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%h	%h	%b", $time, data_in, data_out, done);
    // Test Case 1: Normal operation
    start = 1; #100; start = 0; #100;
    // Test Case 2: Multiple starts
    start = 1; #50; start = 0; #50; start = 1; #50; start = 0; #50;
    // Test Case 3: Reset during operation
    start = 1; #50; rst = 1; #20; rst = 0; #50;
    // Finish the simulation
    $finish;
end
endmodule