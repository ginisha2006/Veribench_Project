module tb_fft_module;
// Parameters
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;
// Clock and Reset Signals
reg clk;
reg rst;
// Input Signals
reg start;
reg [DATA_WIDTH-1:0] data_in;
// Output Signals
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
    // Clock Generation
    clk = 0;
    forever #5 clk = ~clk;
    // Reset Initialization
    rst = 1;
    #10 rst = 0;
    // Stimulus
    start = 0;
    #10 start = 1;
    // Data Input
    data_in = 0;
    #10 data_in = 1;
    // Wait for Completion
    while (!done) begin
        #10;
    end
    // Output Observation
    $display("Data Out: %h", data_out);
    $finish;
end
endmodule