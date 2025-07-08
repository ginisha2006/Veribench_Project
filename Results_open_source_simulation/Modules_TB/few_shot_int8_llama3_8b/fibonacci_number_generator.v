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
    clk = 0;
    rst = 1;
    #20 rst = 0;
    #10 start = 1;
    #100 start = 0;
    // Display the header for the output
    $display("Time	n	fib");
    // Monitor changes to output
    $monitor("%0d	%b	%b", $time, n, fib);
    // Test Case 1: Generate Fibonacci sequence for n=3
    n = 3; #100;
    // Test Case 2: Generate Fibonacci sequence for n=5
    n = 5; #100;
    // Test Case 3: Generate Fibonacci sequence for n=8
    n = 8; #100;
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk;  // Clock generation
endmodule