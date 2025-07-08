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
        rst = 1;
        start = 0;
        n = 0;
        
        #10 rst = 0;
        #10 n = 5;
        start = 1;
        #10 start = 0;
        
        #10 n = 10;
        start = 1;
        #10 start = 0;
        
        #10 n = 0;
        start = 1;
        #10 start = 0;
        
        #10 $finish;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        $monitor($time, " ns: clk=%b, rst=%b, start=%b, n=%d, fib=%d", clk, rst, start, n, fib);
    end
endmodule