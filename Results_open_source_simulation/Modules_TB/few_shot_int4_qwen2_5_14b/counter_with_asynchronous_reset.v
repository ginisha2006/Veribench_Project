module tb_counter;
// Inputs
reg clk;
reg reset;
reg ena;
// Outputs
wire [7:0] result;
// Instantiate the Counter
counter uut (
    .clk(clk),
    .reset(reset),
    .result(result),
    .ena(ena)
);
initial begin
    // Initialize inputs
    clk = 0;
    reset = 0;
    ena = 0;
    // Display the header for the output
    $display("Time	clk	reset	ena	result");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, clk, reset, ena, result);
    // Clock generation process
    forever #5 clk = ~clk;
end

initial begin
    // Initial state
    reset = 1; #10;
    reset = 0; #10;
    ena = 1; #10;
    ena = 0; #10;
    ena = 1; #20;
    ena = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule