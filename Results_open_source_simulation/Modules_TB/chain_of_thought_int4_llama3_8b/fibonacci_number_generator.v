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
        repeat(5) @(posedge clk); // wait for clock cycles
        rst = 0; // release reset
        start = 1; // start generation
        #20; // wait for some time
        start = 0; // stop generation
        #50; // wait for some more time
        $monitor($time, "fib:", fib);
    end

    always #5 clk = ~clk; // generate clock
endmodule