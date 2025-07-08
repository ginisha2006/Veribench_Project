module tb_param_counter;
// Parameter
parameter MAX_COUNT = 255;  // Default maximum count is 255
// Clock and reset signals
reg clk;
reg rst;
// Counter value
reg [$clog2(MAX_COUNT+1)-1:0] count;
// Instantiate the Parameterized Counter
param_counter #(.MAX_COUNT(MAX_COUNT)) uut (
   .clk(clk), 
   .rst(rst), 
   .count(count)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20;
    rst = 0; #10;
    // Monitor changes to counter value
    $monitor($time, " count=%h", count);
    // Test case: Count from 0 to MAX_COUNT
    repeat (MAX_COUNT) begin
        #10 clk = ~clk; // Toggle clock
    end
    // Test case: Reset the counter
    rst = 1; #10;
    rst = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule