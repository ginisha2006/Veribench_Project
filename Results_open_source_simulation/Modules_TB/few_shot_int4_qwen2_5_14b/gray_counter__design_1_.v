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
    // Initialize inputs
    clk = 0;
    enable = 1;
    reset = 0;
    // Clock generation
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	reset	enable	gray_count");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, reset, enable, gray_count);
    // Reset active
    reset = 1; #10;
    // Deactivate reset
    reset = 0; #10;
    // Disable counter
    enable = 0; #10;
    // Enable counter again
    enable = 1; #10;
    // Change reset after some cycles
    reset = 1; #10;
    // Deactivate reset again
    reset = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule