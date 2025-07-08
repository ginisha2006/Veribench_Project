module tb_fibonacci_gen;
// Parameters
parameter WIDTH = 8;
// Inputs
reg clk;
reg rst;
reg start;
reg [WIDTH-1:0] n;
// Outputs
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
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	start	n	fib");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, start, n, fib);
    
    // Initialize signals
    rst = 1; start = 0; n = 0;
    #10;
    
    // Reset sequence
    rst = 0; #10;
    
    // Start generating Fibonacci number for n=5
    start = 1; n = 5; #10;
    start = 0; #100;
    
    // Generate another Fibonacci number for n=10
    start = 1; n = 10; #10;
    start = 0; #100;
    
    // Generate yet another Fibonacci number for n=1
    start = 1; n = 1; #10;
    start = 0; #100;
    
    // Finish the simulation
    $finish;
end
endmodule