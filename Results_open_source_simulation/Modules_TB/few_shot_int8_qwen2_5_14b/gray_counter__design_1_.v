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
// Clock generation process
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initialize signals
    reset = 1;
    enable = 0;
    #10;
    // Release reset
    reset = 0;
    enable = 1;
    #10;
    // Toggle enable
    enable = 0;
    #10;
    enable = 1;
    #100;
    // Finish the simulation
    $finish;
end
initial begin
    // Display the header for the output
    $display("Time	clk	reset	enable	gray_count");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, clk, reset, enable, gray_count);
end
endmodule