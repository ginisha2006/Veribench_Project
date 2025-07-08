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
        #10 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor($time," ns | clk=%b, rst=%b, start=%b, n=%d, fib=%d", clk, rst, start, n, fib);
    end
endmodule