module tb_counter;
// Input signals
reg clk;
reg reset;
reg ena;
// Output signal
wire [7:0] result;
// Instantiate the Counter
counter uut (
   .clk(clk),
   .reset(reset),
   .result(result),
   .ena(ena)
);
initial begin
    // Initialize the clock
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize the reset
    reset = 0;
    // Initialize the enable
    ena = 0;
    // Display the header for the output
    $display("Time	result");
    // Monitor changes to the output
    $monitor("%0d	%b", $time, result);
    // Test Case 1: Reset the counter
    reset = 1; #10; reset = 0; #10;
    // Test Case 2: Enable the counter
    ena = 1; #100; ena = 0; #10;
    // Test Case 3: Disable the counter
    ena = 0; #100; ena = 1; #10;
    // Test Case 4: Reset and enable the counter
    reset = 1; #10; ena = 1; #100; reset = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule