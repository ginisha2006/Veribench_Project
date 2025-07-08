module tb_param_counter;
// Parameters
parameter MAX_COUNT = 255;

// Inputs
reg clk;
reg rst;

// Outputs
wire [$clog2(MAX_COUNT+1)-1:0] count;

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

    // Reset active high
    rst = 1; #10;
    rst = 0; #10;
end

initial begin
    // Display the header for the output
    $display("Time	rst	count");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b", $time, rst, count);

    // Wait until reset is released
    @(negedge rst);

    // Simulate normal operation
    repeat(2*MAX_COUNT) @posedge clk;

    // Reassert reset
    rst = 1; #10;
    rst = 0; #10;

    // Finish the simulation
    $finish;
end
endmodule