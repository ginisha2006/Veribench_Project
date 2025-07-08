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
    #100; // Initialize clock
    clk = 0;
    forever #(5) clk = ~clk; // Clock generation
end

initial begin
    #200; // Reset pulse
    rst = 1;
    #10;
    rst = 0;
end

integer i;
integer j;
integer k;

always @(posedge clk) begin
    if (rst) begin
        start <= 0;
    end else begin
        if (!done && start) begin
            start <= 0;
        end
    end
end

initial begin
    $monitor($time, "clk:%b, rst:%b, start:%b, data_in:%h, data_out:%h, done:%b", clk, rst, start, data_in, data_out, done);

    // Test case 1: Normal operation
    start <= 1;
    for (i = 0; i < FFT_POINTS; i++) begin
        #10;
        data_in <= $random();
    end
    #20;
    start <= 0;

    // Test case 2: Edge case - single sample
    start <= 1;
    data_in <= 0;
    #10;
    start <= 0;

    // Test case 3: Corner case - all zeros
    start <= 1;
    for (j = 0; j < FFT_POINTS; j++) begin
        data_in <= 0;
        #10;
    end
    start <= 0;

    // Test case 4: Corner case - all ones
    start <= 1;
    for (k = 0; k < FFT_POINTS; k++) begin
        data_in <= 16'hFFFF;
        #10;
    end
    start <= 0;

    #10000; // Run for some time
    $finish;
end

endmodule