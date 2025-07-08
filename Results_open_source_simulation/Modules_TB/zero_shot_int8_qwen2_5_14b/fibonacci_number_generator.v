module tb_fibonacci_gen;
    parameter WIDTH = 8;
    reg clk;
    reg rst;
    reg start;
    reg [WIDTH-1:0] n;
    wire [WIDTH-1:0] fib;

    fibonacci_gen uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        start = 0;
        n = 0;
        
        #20 rst = 0;
        #10 n = 5; start = 1;
        #60 start = 0;
        #10 n = 10; start = 1;
        #60 start = 0;
        #10 n = 15; start = 1;
        #60 start = 0;
        #10 n = 20; start = 1;
        #60 start = 0;
        #10 n = 25; start = 1;
        #60 start = 0;
        #10 n = 30; start = 1;
        #60 start = 0;
        #10 n = 31; start = 1;
        #60 start = 0;
        #10 n = 32; start = 1;
        #60 start = 0;
        #10 n = 33; start = 1;
        #60 start = 0;
        #10 n = 34; start = 1;
        #60 start = 0;
        #10 n = 35; start = 1;
        #60 start = 0;
        #10 n = 39; start = 1;
        #60 start = 0;
        #10 n = 40; start = 1;
        #60 start = 0;
        #10 n = 41; start = 1;
        #60 start = 0;
        #10 n = 42; start = 1;
        #60 start = 0;
        #10 n = 43; start = 1;
        #60 start = 0;
        #10 n = 44; start = 1;
        #60 start = 0;
        #10 n = 45; start = 1;
        #60 start = 0;
        #10 n = 46; start = 1;
        #60 start = 0;
        #10 n = 47; start = 1;
        #60 start = 0;
        #10 n = 48; start = 1;
        #60 start = 0;
        #10 n = 49; start = 1;
        #60 start = 0;
        #10 n = 50; start = 1;
        #60 start = 0;
        #100 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor($time," ns: clk=%b, rst=%b, start=%b, n=%d, fib=%d", clk, rst, start, n, fib);
    end
endmodule