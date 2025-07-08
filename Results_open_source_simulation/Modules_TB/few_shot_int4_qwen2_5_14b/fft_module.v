module tb_fft_module;

// Parameters
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

// DUT instance
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

// Inputs
reg clk;
reg rst;
reg start;
reg [DATA_WIDTH-1:0] data_in;

// Outputs
wire [DATA_WIDTH-1:0] data_out;
wire done;

// Clock generation process
initial begin
    clk <= 0;
    forever #5 clk = ~clk;
end

initial begin
    // Initialize signals
    rst <= 1; start <= 0; data_in <= 0;
    // Wait for initial reset
    #10 rst <= 0;
    // Apply stimulus
    @(posedge clk) start <= 1;
    @(posedge clk) start <= 0;
    @(posedge clk) data_in <= 10'd1234;
    @(posedge clk) data_in <= 10'd4321;
    @(posedge clk) data_in <= 10'd9999;
    // Wait until done signal is asserted
    @(posedge done);
    // Finish the simulation
    $finish;
end

// Monitor process to observe outputs
initial begin
    $dumpfile("tb_fft_module.vcd");
    $dumpvars(0, tb_fft_module);
    $display("Time	data_in	done");
    $monitor("%0d	%b	%b", $time, data_in, done);
end

endmodule