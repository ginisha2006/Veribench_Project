module tb_param_counter;
// Parameter
parameter MAX_COUNT = 255;  // Default maximum count value
// Clock and reset signals
reg clk;
reg rst;
// Counter output
reg [$clog2(MAX_COUNT+1)-1:0] expected_count;
reg [$clog2(MAX_COUNT+1)-1:0] actual_count;
// Instantiate the Parameterized Counter
param_counter #(.MAX_COUNT(MAX_COUNT)) uut (
   .clk(clk),
   .rst(rst),
   .count(actual_count)
);
initial begin
    // Initialize clock and reset signals
    clk = 0;
    rst = 0;
    #20; // Wait for 20 time units
    rst = 1; // Reset the counter
    #10; // Wait for 10 time units
    rst = 0; // Release the reset
    // Monitor the counter value
    $monitor($time, "Count: %h", actual_count);
    // Test the counter
    repeat (MAX_COUNT) begin
        #10; // Wait for 10 time units
        clk = ~clk; // Toggle the clock
    end
    // Check the final count value
    $display("Final Count: %h", actual_count);
    // Finish the simulation
    $finish;
end
endmodule