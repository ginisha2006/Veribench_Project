module tb_param_counter;
// Parameters
parameter MAX_COUNT = 255;
// Inputs
reg clk;
reg rst;
// Outputs
wire [clog2(MAX_COUNT+1)-1:0] count;

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
    
    // Apply reset
    rst = 1; #10;
    rst = 0; #10;
    
    // Wait for several cycles without reset
    repeat(100) @posedge clk;
    
    // Check overflow condition
    repeat(10) @posedge clk;
    
    // Reapply reset
    rst = 1; #10;
    rst = 0; #10;
    
    // Finish the simulation
    $finish;
end
endmodule