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
        rst = 1; start = 0; n = 0;
        #10 rst = 0;
        #10 n = 1; start = 1;
        #10 start = 0;
        #10 n = 2; start = 1;
        #10 start = 0;
        #10 n = 3; start = 1;
        #10 start = 0;
        #10 n = 4; start = 1;
        #10 start = 0;
        #10 n = 7; start = 1;
        #10 start = 0;
        #10 n = 10; start = 1;
        #10 start = 0;
        #10 $finish;
    end

    initial begin
        $monitor($time," ns | fib=%d", fib);
    end
endmodule