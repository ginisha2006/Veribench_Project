module fft_tb;
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

reg clk;
reg rst;
reg start;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire done;

initial begin
    #10; // Set up initial conditions
    rst = 1'b1;
    repeat (2) @(posedge clk); // Hold reset for two clock cycles
    rst = 1'b0;
    #10; // Release reset

    // Test with valid data
    start = 1'b1;
    data_in = 16'h1234;
    repeat (FFT_POINTS-1) @(posedge clk);
    start = 1'b0;
    #10; // Wait for completion

    // Test with invalid data
    start = 1'b1;
    data_in = 16'h0000;
    repeat (FFT_POINTS-1) @(posedge clk);
    start = 1'b0;
    #10; // Wait for completion

    // Test with multiple starts
    start = 1'b1;
    data_in = 16'h5678;
    repeat (FFT_POINTS*2-1) @(posedge clk);
    start = 1'b0;
    #10; // Wait for completion

    // Test with no start
    start = 1'b0;
    repeat (FFT_POINTS*3) @(posedge clk);

    $display("Test complete");
    $finish;
end

always #5 clk = ~clk; // Clock generation

initial begin
    clk = 1'b0;
    forever #(10) clk = ~clk;
end

initial begin
    $monitor($time, "clk=%b, rst=%b, start=%b, data_in=%h, data_out=%h, done=%b", clk, rst, start, data_in, data_out, done);
end

endmodule