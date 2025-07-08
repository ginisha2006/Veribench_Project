module tb_param_counter;

parameter MAX_COUNT = 255;
reg clk;
reg rst;
wire [($clog2(MAX_COUNT+1)-1:0)] count;

param_counter uut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

initial begin
    // Initialize clock and reset signals
    clk = 0;
    rst = 1;
    #10 rst = 0; // De-assert reset after 10 time units

    // Clock period
    repeat(100) begin
        #5 clk = ~clk;
    end

    // Test all possible scenarios
    for (int i = 0; i < 3; i++) begin
        rst = 1;
        #20 clk = 0;
        #10 rst = 0;
        #50 clk = ~clk;
        #100 count == 0; // Check initial value
        #200 count == 1; // Increment once
        #400 count == 2; // Increment twice
        #600 count == 3; // Increment three times
        #800 count == 0; // Overflow detected
    end

    // Monitor the counter value
    $monitor ($time, "Count: %b", count);
end

endmodule