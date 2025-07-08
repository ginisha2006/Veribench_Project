module tb_fibonacci_gen;

parameter WIDTH = 8;

input clk;
input rst;
input start;
input [WIDTH-1:0] n;
output reg [WIDTH-1:0] fib;

reg [WIDTH-1:0] a, b;
reg [WIDTH-1:0] count;

property fib_property;
    @(posedge clk) disable iff (!rst) 
        [|fib == 0] && (a == 0 && b == 1) |-> (count == 0);
    @(posedge clk) disable iff (!rst) 
        [|fib!= 0] && (a == 0 || b == 0) |-> (count > 0);

    @(posedge clk) disable iff (!rst) 
        [|fib == 1] && (a == 0 && b == 1) |-> (count == 1);
    @(posedge clk) disable iff (!rst) 
        [|fib == 2] && (a == 1 && b == 1) |-> (count == 2);

    @(posedge clk) disable iff (!rst) 
        [|fib >= 2] && (a == 1 && b == 1) |-> (count > 2);

    @(posedge clk) disable iff (!rst) 
        [|fib < 2] && (a == 0 && b == 0) |-> (count == 0);

    @(posedge clk) disable iff (!rst) 
        [|fib > 2] && (a == 1 && b == 1) |-> (count > 2);

    @(posedge clk) disable iff (!rst) 
        [|fib < 2] && (a == 0 && b == 1) |-> (count == 1);

    @(posedge clk) disable iff (!rst) 
        [|fib > 2] && (a == 0 && b == 1) |-> (count > 1);

    @(posedge clk) disable iff (!rst) 
        [|fib < 2] && (a == 1 && b == 0) |-> (count == 1);

    @(posedge clk) disable iff (!rst) 
        [|fib > 2] && (a == 1 && b == 0) |-> (count > 1);

    @(posedge clk) disable iff (!rst) 
        [|fib < 2] && (a == 0 && b == 0) |-> (count == 0);

    @(posedge clk) disable iff (!rst) 
        [|fib > 2] && (a == 0 && b == 0) |-> (count > 0);

    assert property(fib_property);

endmodule