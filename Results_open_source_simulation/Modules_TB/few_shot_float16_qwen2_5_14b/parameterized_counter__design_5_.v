module tb_param_counter;
// Parameters
parameter MAX_COUNT = 255;
// Inputs
reg clk;
reg rst;
// Outputs
wire [7:0] count;  // Assuming $clog2(256) = 8
// Instantiate the Parameterized Counter
param_counter #(.MAX_COUNT(MAX_COUNT)) uut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	count");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, rst, count);
    
    // Apply reset at time 0
    rst = 1; #10;
    rst = 0;

    // Wait for counter to reach maximum value and wrap around
    #((MAX_COUNT + 1) * 10); 

    // Verify that the counter has wrapped around correctly
    if (count != 0) $display("ERROR: Counter did not wrap around as expected.");
    else $display("SUCCESS: Counter wrapped around correctly.");

    // Finish the simulation
    $finish;
end
endmodule