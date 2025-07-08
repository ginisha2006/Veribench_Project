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
// Done signal
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
    clk = 0;
    rst = 1;
    #20;
    rst = 0;
    // Initialize start signal
    start = 0;
    // Initialize input data
    data_in = 0;
    // Monitor changes to outputs
    $monitor($time, "data_out: %h", data_out);
    // Test case: Single cycle operation
    clk = 1; #10; clk = 0; #10;
    start = 1; #100; start = 0; #100;
    // Test case: Multiple cycles operation
    clk = 1; #10; clk = 0; #10;
    start = 1; #200; start = 0; #200;
    // Test case: Reset operation
    clk = 1; #10; clk = 0; #10;
    rst = 1; #10; rst = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule