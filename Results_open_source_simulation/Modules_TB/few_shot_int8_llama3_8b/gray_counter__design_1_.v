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
    // Initialize the clock
    clk = 0;
    forever #5 clk = ~clk;
    // Initialize the reset
    reset = 1;
    #20 reset = 0;
    // Monitor changes to outputs
    $monitor("%t gray_count=%b", $time, gray_count);
    // Test the counter
    #100;
    $display("Gray Count: %b", gray_count);
    // Finish the simulation
    $finish;
end
endmodule