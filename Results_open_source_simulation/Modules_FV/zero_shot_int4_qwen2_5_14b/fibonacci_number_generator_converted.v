module tb_fibonacci_gen();
    parameter WIDTH = 8;
    
    wire clk;
    wire rst;
    wire start;
    wire [WIDTH-1:0] n;
    wire [WIDTH-1:0] fib;
    
    fibonacci_gen #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );
    
    // Clock generation
    reg clk;
    always #5 clk = ~clk;
    
    // Properties
    assert (@(posedge rst) disable iff (!rst)
        rst |-> (fib == 0 && n == 0 && start == 0));
    
    assert (@(posedge clk) disable iff (!rst)
        start ##1 start[*]
        |-> (fib[WIDTH-1] !== fib[WIDTH-2]));
    
    assert (@(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> ($past(fib) == $past(a) + $past(b)));
    
    assert (@(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> !(a > fib || b > fib || a < fib || b < fib));
    
    assert (@(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> (fib == $past($past(a) + $past(b))));
endmodule