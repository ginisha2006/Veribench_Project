module tb_param_counter;
// Parameter
parameter MAX_COUNT = 255;  // Default maximum count is 255
// Clock and reset signals
reg clk;
reg rst;
// Initialize counter value
reg [$clog2(MAX_COUNT+1)-1:0] expected_count;
// Instantiate the Parameterized Counter
param_counter #(.MAX_COUNT(MAX_COUNT)) uut (
   .clk(clk), 
   .rst(rst), 
   .count(uut_count)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20;
    rst = 0; #10;
    // Monitor changes to the counter
    $monitor($time, " : count = %h", uut_count);
    // Test Case 1: Count from 0 to MAX_COUNT
    for (int i = 0; i <= MAX_COUNT; i++) begin
        expected_count = i;
        #10;
    end
    // Test Case 2: Reset the counter
    rst = 1; #10;
    rst = 0; #10;
    // Test Case 3: Count from 0 again
    for (int i = 0; i <= MAX_COUNT; i++) begin
        expected_count = i;
        #10;
    end
    // Finish the simulation
    $finish;
end
endmodule