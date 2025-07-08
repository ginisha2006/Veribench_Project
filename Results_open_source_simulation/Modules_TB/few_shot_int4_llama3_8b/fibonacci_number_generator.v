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
// Output signal
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
    #20;
    rst = 0;
    // Initialize start signal
    start = 0;
    // Initialize input value
    n = 5;  // Generate Fibonacci sequence up to 5th number
    // Clock cycle
    forever begin
        clk = ~clk;
        #10;
    end
    // Trigger start signal
    start = 1;
    // Wait until the sequence is generated
    repeat(5) @(posedge clk);
    start = 0;
    // Finish the simulation
    $finish;
end
endmodule