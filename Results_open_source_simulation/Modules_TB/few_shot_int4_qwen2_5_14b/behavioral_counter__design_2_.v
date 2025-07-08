module tb_behav_counter;
// Inputs
reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
// Outputs
wire [7:0] qd;
// Instantiate the Behavioral Counter
behav_counter uut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
);
initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	d	clear	load	up_down	qd");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, d, clear, load, up_down, qd);
    // Initial state
    d = 8'd10; clear = 0; load = 0; up_down = 1; @(negedge clk); // Reset condition
    @(negedge clk); @(negedge clk); // Wait for two cycles after reset
    
    // Load value into counter
    clear = 1; load = 1; @(negedge clk); // Load new value
    @(negedge clk); @(negedge clk); // Wait for two cycles after loading
    
    // Counting Up
    load = 0; @(negedge clk); // Start counting up
    @(negedge clk); @(negedge clk); // Count up twice
    
    // Toggle direction to count down
    up_down = 0; @(negedge clk); // Start counting down
    @(negedge clk); @(negedge clk); // Count down twice
    
    // Clear the counter
    clear = 0; @(negedge clk); // Clear the counter
    @(negedge clk); @(negedge clk); // Wait for two cycles after clearing
    
    // Finish the simulation
    $finish;
end
endmodule