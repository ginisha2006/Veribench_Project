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
        // Initialize signals
        clk = 0;
        rst = 1;
        start = 0;
        n = 0;
        #5 rst = 0;
        #5 start = 1; n = 1; #10 start = 0;
        #5 start = 1; n = 2; #10 start = 0;
        #5 start = 1; n = 3; #10 start = 0;
        #5 start = 1; n = 4; #10 start = 0;
        #5 start = 1; n = 5; #10 start = 0;
        #5 start = 1; n = 6; #10 start = 0;
        #5 start = 1; n = 7; #10 start = 0;
        #5 start = 1; n = 8; #10 start = 0;
        #5 start = 1; n = 9; #10 start = 0;
        #5 start = 1; n = 10; #10 start = 0;
        #5 start = 1; n = 11; #10 start = 0;
        #5 start = 1; n = 12; #10 start = 0;
        #5 start = 1; n = 13; #10 start = 0;
        #5 start = 1; n = 14; #10 start = 0;
        #5 start = 1; n = 15; #10 start = 0;
        #5 start = 1; n = 16; #10 start = 0;
        #5 start = 1; n = 17; #10 start = 0;
        #5 start = 1; n = 18; #10 start = 0;
        #5 start = 1; n = 19; #10 start = 0;
        #5 start = 1; n = 20; #10 start = 0;
        #5 start = 1; n = 21; #10 start = 0;
        #5 start = 1; n = 22; #10 start = 0;
        #5 start = 1; n = 23; #10 start = 0;
        #5 start = 1; n = 24; #10 start = 0;
        #5 start = 1; n = 25; #10 start = 0;
        #5 start = 1; n = 26; #10 start = 0;
        #5 start = 1; n = 27; #10 start = 0;
        #5 start = 1; n = 28; #10 start = 0;
        #5 start = 1; n = 29; #10 start = 0;
        #5 start = 1; n = 30; #10 start = 0;
        #5 start = 1; n = 31; #10 start = 0;
        #5 start = 1; n = 32; #10 start = 0;
        #5 start = 1; n = 33; #10 start = 0;
        #5 start = 1; n = 34; #10 start = 0;
        #5 start = 1; n = 35; #10 start = 0;
        #5 start = 1; n = 36; #10 start = 0;
        #5 start = 1; n = 37; #10 start = 0;
        #5 start = 1; n = 38; #10 start = 0;
        #5 start = 1; n = 39; #10 start = 0;
        #5 start = 1; n = 40; #10 start = 0;
        #5 start = 1; n = 41; #10 start = 0;
        #