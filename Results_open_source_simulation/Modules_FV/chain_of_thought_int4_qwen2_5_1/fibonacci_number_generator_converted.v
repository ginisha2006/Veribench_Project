module tb_fibonacci_gen(
    input clk,
    input rst,
    input start,
    input [7:0] n,
    output reg [7:0] fib
);

reg [7:0] a, b;
reg [7:0] count;

always #5 clk = ~clk;

assert (@(posedge rst) disable iff (!rst)
    (fib == 0 && a == 0 && b == 1 && count == 0));

assert (@(posedge start) disable iff (!start)
    (n > 0 |-> ##[1:$] fib != 0));

assert (@(posedge clk) disable iff (!rst || !start)
    (count < n) |-> fib == a + b);

assert (@(posedge clk) disable iff (!rst || !start)
    (a + b >= 256 |-> fib == 0));

assert (@(posedge clk) disable iff (!rst || !start)
    (count == n) |-> fib == a + b);

endmodule