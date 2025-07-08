module tb_gray_count;
// Inputs
reg clk;
reg enable;
reg reset;
// Outputs
wire [7:0] gray_count;
// Instantiate the Gray Counter
gray_count uut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
);
initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Display the header for the output
    $display("Time	reset	enable	gray_count");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, reset, enable, gray_count);
    // Reset the counter
    reset = 1; enable = 0; #10;
    // Release reset
    reset = 0; enable = 1; #10;
    // Disable counting
    enable = 0; #10;
    // Enable counting again
    enable = 1; #100;
    // Final reset
    reset = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule