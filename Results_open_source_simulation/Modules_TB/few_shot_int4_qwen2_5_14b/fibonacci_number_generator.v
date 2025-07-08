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
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Reset signals
    rst = 1; n = 0; start = 0; #15;
    rst = 0; #10;
    
    // Test case 1: Generate F(0)
    n = 0; start = 1; #20;
    start = 0; #10;
    
    // Test case 2: Generate F(1)
    n = 1; start = 1; #20;
    start = 0; #10;
    
    // Test case 3: Generate F(2)
    n = 2; start = 1; #20;
    start = 0; #10;
    
    // Test case 4: Generate F(3)
    n = 3; start = 1; #20;
    start = 0; #10;
    
    // Test case 5: Generate F(4)
    n = 4; start = 1; #20;
    start = 0; #10;
    
    // Test case 6: Generate F(5)
    n = 5; start = 1; #20;
    start = 0; #10;
    
    // Finish the simulation
    $finish;
end

initial begin
    // Display the header for the output
    $display("Time	n	fib");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%d	%b", $time, n, fib);
end
endmodule