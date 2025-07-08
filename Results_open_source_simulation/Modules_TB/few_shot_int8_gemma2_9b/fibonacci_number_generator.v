module tb_fibonacci_gen;
// Parameters
parameter WIDTH = 8;
// Signals
reg clk;
reg rst;
reg start;
reg [WIDTH-1:0] n;
wire [WIDTH-1:0] fib;
// Instantiate the Fibonacci Generator
fibonacci_gen #(WIDTH) uut (
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
    // Reset and Start
    rst = 1;
    #10 rst = 0;
    start = 0;
    #10 start = 1;
    // Input Value
    n = 5;
    // Monitor output
    $display("Time	n	fib");
    $monitor("%0d	%b	%b", $time, n, fib);
    // Wait until simulation ends
    #100 $finish;
end
endmodule