module tb_fibonacci_gen;

parameter WIDTH = 8;

input clk;

input rst;

input start;

input [WIDTH-1:0] n;

output reg [WIDTH-1:0] fib;

reg [WIDTH-1:0] a, b;

reg [WIDTH-1:0] count;

property fib_gen_correctness;

@(posedge clk) disable iff (!rst) ($rose(start) -> ((a == 0) && (b == 1)));

property fib_gen_edge_cases;

@(posedge clk) disable iff (!rst) ((start &&!count) -> (fib == 0));

@(posedge clk) disable iff (!rst) ((start && count == 1) -> (fib == 1));

@(posedge clk) disable iff (!rst) ((start && count > 1) -> (fib == (a + b)));

property fib_gen_overflow;

@(posedge clk) disable iff (!rst) ((start && count >= WIDTH) -> ($fell(count) || $rose(rst)));

property fib_gen_underflow;

@(posedge clk) disable iff (!rst) ((start && count < 0) -> ($fell(count) || $rose(rst)));

property fib_gen_illegal_transition;

@(posedge clk) disable iff (!rst) ((start && count == WIDTH - 1) -> ($fell(count) || $rose(rst)));

assert property (fib_gen_correctness);

assert property (fib_gen_edge_cases);

assert property (fib_gen_overflow);

assert property (fib_gen_underflow);

assert property (fib_gen_illegal_transition);

endmodule