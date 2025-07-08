module tb_gray_count;
// Inputs
reg clk;
reg enable;
reg reset;
// Outputs
wire [7:0] gray_count;
// Initialize variables
integer i;
// Instantiate the Gray Counter
gray_count uut (
   .clk(clk), 
   .enable(enable), 
   .reset(reset), 
   .gray_count(gray_count)
);
initial begin
    // Display the header for the output
    $display("Time	gray_count");
    // Monitor changes to outputs
    $monitor("%0d	%b", $time, gray_count);
    // Reset the counter
    reset = 1; #20; reset = 0;
    // Enable the counter
    enable = 1;
    // Run the counter for 100 clock cycles
    for (i = 0; i < 100; i++) begin
        #10 clk = ~clk;
    end
    // Disable the counter
    enable = 0;
    // Run the counter for another 100 clock cycles
    for (i = 0; i < 100; i++) begin
        #10 clk = ~clk;
    end
    // Finish the simulation
    $finish;
end
endmodule