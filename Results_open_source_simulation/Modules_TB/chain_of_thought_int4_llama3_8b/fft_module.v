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
    #10; // delay for setup
    rst = 1'b1; // reset
    repeat (5) @(posedge clk); // wait for 5 clock cycles
    rst = 1'b0; // release reset
    #10; // delay for setup
    start = 1'b1; // start FFT
    repeat (FFT_POINTS) @(posedge clk); // wait for FFT points
    start = 1'b0; // stop FFT
    #10; // delay for teardown
    start = 1'b1; // restart FFT
    repeat (FFT_POINTS) @(posedge clk); // wait for FFT points
    start = 1'b0; // stop FFT
    #20; // delay for final teardown
    $finish; // end simulation
end

always #5 clk = ~clk; // clock generation

assign data_in = $random % (1 << DATA_WIDTH);

initial begin
    $monitor($time, "clk:", clk, "rst:", rst, "start:", start, "data_in:", data_in, "data_out:", data_out, "done:", done);
end

endmodule