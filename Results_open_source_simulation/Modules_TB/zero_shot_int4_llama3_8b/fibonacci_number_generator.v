module fibonacci_gen_tb;
    parameter WIDTH = 8;
    reg clk;
    reg rst;
    reg start;
    reg [WIDTH-1:0] n;
    wire [WIDTH-1:0] fib;

    fibonacci_gen #(
       .WIDTH(WIDTH)
    ) uut (
       .clk(clk),
       .rst(rst),
       .start(start),
       .n(n),
       .fib(fib)
    );

    initial begin
        #10; // delay for setup
        rst = 1; // reset
        repeat(2) @(posedge clk); // wait for two clock cycles
        rst = 0; // release reset
        #10; // delay for setup
        start = 1; // start generation
        n = 5; // generate Fibonacci sequence up to 5 numbers
        repeat(6) @(posedge clk); // wait for 6 clock cycles
        start = 0; // stop generation
        #10; // delay for setup
        rst = 1; // reset again
        repeat(2) @(posedge clk); // wait for two clock cycles
        rst = 0; // release reset
        #10; // delay for setup
        start = 1; // start generation
        n = 3; // generate Fibonacci sequence up to 3 numbers
        repeat(4) @(posedge clk); // wait for 4 clock cycles
        start = 0; // stop generation
    end

    always #5 clk = ~clk; // clock generator

    initial begin
        $monitor($time, "clk=%b, rst=%b, start=%b, n=%h, fib=%h", clk, rst, start, n, fib);
    end
endmodule