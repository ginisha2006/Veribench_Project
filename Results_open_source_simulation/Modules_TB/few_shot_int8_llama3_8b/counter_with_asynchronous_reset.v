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
    reset = 1;
    #100 reset = 0;
    // Enable the counter
    ena = 1;
    // Monitor changes to the result
    $monitor($time, " : result = %b", result);
    // Test case 1: Count from 0 to 255
    #500 $display("Counting from 0 to 255...");
    #2500 $display("Done counting!");
    // Test case 2: Reset the counter
    reset = 1;
    #10 reset = 0;
    #1000 $display("Resetting the counter...");
    // Test case 3: Disable the counter
    ena = 0;
    #1000 $display("Disabling the counter...");
    // Finish the simulation
    $finish;
end
endmodule