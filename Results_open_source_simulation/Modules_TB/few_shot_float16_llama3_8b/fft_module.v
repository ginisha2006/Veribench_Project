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
    $monitor("%0d	%x	%x	%b", $time, data_in, data_out, done);
    // Test Case 1: Start FFT with valid data
    start = 1; data_in = 16'h1234; #100; start = 0; #10;
    // Test Case 2: Start FFT with invalid data
    start = 1; data_in = 16'h0000; #100; start = 0; #10;
    // Test Case 3: Multiple FFT iterations
    repeat (10) begin
        start = 1; data_in = 16'hzeros; #100; start = 0; #10;
    end
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk;
endmodule