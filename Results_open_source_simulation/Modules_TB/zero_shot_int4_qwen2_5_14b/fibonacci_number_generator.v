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
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1; n = 0; start = 0; #20;
        rst = 0; n = 4; start = 1; #20;
        start = 0; #20;
        n = 7; start = 1; #20;
        start = 0; #20;
        n = 10; start = 1; #20;
        start = 0; #20;
        n = 16; start = 1; #20;
        start = 0; #20;
        $finish;
    end
    
    initial begin
        $monitor($time," ns: clk=%b, rst=%b, start=%b, n=%d, fib=%d", clk, rst, start, n, fib);
    end
endmodule