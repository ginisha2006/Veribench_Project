module tb_fibonacci_gen();
    parameter WIDTH = 8;
    
    wire clk;
    wire rst;
    wire start;
    wire [WIDTH-1:0] n;
    reg [WIDTH-1:0] fib;
    
    fibonacci_gen uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Functional correctness
    assert (@(posedge clk) disable iff (rst)
        (start && !($past(start))) |-> ##[2:$] (fib == $shift_left(1, n)));

    // Edge case when n is 0
    assert (@(posedge clk) disable iff (rst)
        (start && n == 0) |-> ##1 fib == 0);

    // Edge case when n is 1
    assert (@(posedge clk) disable iff (rst)
        (start && n == 1) |-> ##1 fib == 1);

    // Overflow check
    assert (@(posedge clk) disable iff (rst)
        (start && n > WIDTH - 2) |-> ##[2:$] fib == {WIDTH{1'b1}});

    // Illegal transition from reset state
    assert (@(posedge clk) disable iff (rst)
        (!rst && $past(rst)) |-> !(start && n != 0));
endmodule