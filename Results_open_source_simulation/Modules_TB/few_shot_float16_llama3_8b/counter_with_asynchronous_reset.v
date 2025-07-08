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
    // Initialize the reset and enable signals
    reset = 1; #10; reset = 0;
    ena = 1;
    // Display the header for the output
    $display("Time	result");
    // Monitor changes to the output
    $monitor("%0d	%b", $time, result);
    // Test Case 1: Reset the counter
    #100; // Wait for 100 clock cycles
    // Test Case 2: Enable the counter
    #100; // Wait for 100 clock cycles
    // Test Case 3: Disable the counter
    ena = 0; #100; ena = 1;
    // Test Case 4: Reset the counter while enabled
    reset = 1; #10; reset = 0;
    // Finish the simulation
    $finish;
end
endmodule