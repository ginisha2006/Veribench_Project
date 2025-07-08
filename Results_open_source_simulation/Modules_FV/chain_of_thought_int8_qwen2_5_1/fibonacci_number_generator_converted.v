module tb_fibonacci_gen (
    input clk,
    input rst,
    input start,
    input [7:0] n,
    output reg [7:0] fib
);

    wire [7:0] a, b;
    wire [7:0] count;

    fibonacci_gen dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );

    always begin
        #5 clk = ~clk;
    end

    assert (@(posedge rst) disable iff (!rst)
        (a == 0) |-> ##1 (b == 1 && fib == 0 && count == 0));

    assert (@(posedge clk) disable iff (!start)
        (start && !rst) |-> ##[1:$] (count == n || fib == a + b));

    assert (@(posedge clk) disable iff (!start || rst)
        ($rose(count == n)) |-> (fib == a + b));

    assert (@(posedge clk) disable iff (!start || rst)
        (count < n) |-> (fib == a + b));

    assert (@(posedge clk) disable iff (!start || rst)
        (count != n - 1 && count != n) |-> !(fib == a + b));

endmodule