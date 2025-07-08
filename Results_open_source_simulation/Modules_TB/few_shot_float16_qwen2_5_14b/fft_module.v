module tb_fft_module;
// Parameters
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

// Clock generation process
reg clk;
always #5 clk = ~clk;

// Inputs
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
    // Initialize signals
    clk = 0;
    rst = 1;
    start = 0;
    data_in = 0;

    // Display the header for the output
    $display("Time	rst	start	data_in	data_out	done");

    // Reset the system
    #10 rst = 0;
    #10 rst = 1;

    // Start the first FFT operation
    start = 1;
    data_in = 10'd10; // Example input value
    #20 start = 0;

    // Wait until the FFT operation completes
    while (!done) #10;

    // Change input and restart FFT
    data_in = 10'd20; // Another example input value
    start = 1;
    #20 start = 0;

    // Wait until the second FFT operation completes
    while (!done) #10;

    // Finalize the simulation
    $finish;
end

// Monitor changes to inputs and outputs
$monitor("%0d	%b	%b	%b	%b	%b", $time, rst, start, data_in, data_out, done);
endmodule