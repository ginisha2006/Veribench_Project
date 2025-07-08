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

property reset_assertion;
    @(posedge rst) disable iff (!rst)
    (fib == 0 && a == 0 && b == 1 && count == 0);
endproperty
assert property(reset_assertion);

property start_condition;
    @(posedge start) disable iff (!start)
    (n > 0 |-> ##[1:$] fib != 0);
endproperty
assert property(start_condition);

property correct_sequence;
    @(posedge clk) disable iff (!rst || !start)
    (count < n) |-> fib == a + b;
endproperty
assert property(correct_sequence);

property overflow_check;
    @(posedge clk) disable iff (!rst || !start)
    (a + b >= 256 |-> fib == 0);
endproperty
assert property(overflow_check);

property final_value;
    @(posedge clk) disable iff (!rst || !start)
    (count == n) |-> fib == a + b;
endproperty
assert property(final_value);

endmodule