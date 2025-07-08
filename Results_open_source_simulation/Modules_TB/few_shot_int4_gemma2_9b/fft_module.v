module tb_fft_module;
// Parameters
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;
// Inputs
reg clk;
reg rst;
reg start;
reg [DATA_WIDTH-1:0] data_in;
// Outputs
wire [DATA_WIDTH-1:0] data_out;
wire done;
// Instantiate the FFT Module
fft_module #(
    .DATA_WIDTH(DATA_WIDTH),
    .FFT_POINTS(FFT_POINTS)
) uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);
initial begin
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Reset initialization
    rst = 1;
    #10 rst = 0;
    // Data Input
    data_in = 0;
    // Start FFT calculation
    start = 1;
    #10 start = 0;
    // Wait for completion
    while (!done) ;
    // Output results
    $display("Data Out: %h", data_out);
    $finish;
end
endmodule