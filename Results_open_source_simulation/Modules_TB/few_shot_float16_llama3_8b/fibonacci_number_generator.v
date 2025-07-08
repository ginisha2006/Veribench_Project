module tb_fibonacci_gen;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Clock and reset signals
reg clk;
reg rst;
// Start signal
reg start;
// Input value
reg [WIDTH-1:0] n;
// Output
wire [WIDTH-1:0] fib;
// Instantiate the Fibonacci Generator
fibonacci_gen #(.WIDTH(WIDTH)) uut (
   .clk(clk), 
   .rst(rst), 
   .start(start), 
   .n(n), 
   .fib(fib)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; start = 0; n = 5; #20;
    // Reset the DUT
    rst = 0; #10; rst = 1; #10;
    // Start the generation
    start = 1; #10;
    // Monitor changes to output
    $monitor($time, " fib = %b", fib);
    // Wait until the generation is complete
    repeat (n) @ (posedge clk); #10;
    // Stop the generation
    start = 0; #10;
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk;  // Generate a clock signal
endmodule