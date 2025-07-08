module tb_half_adder;

parameter PERIOD = 10; // Clock period

logic clk;

logic rst;

logic [1:0] a;

logic [1:0] b;

logic sum_exp;

logic carry_exp;

half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;

@ (posedge clk) disable iff (!rst);

assert property (@(posedge clk) sum == (a ^ b));

property p_carry_correct;

@ (posedge clk) disable iff (!rst);

assert property (@(posedge clk) carry == (a && b));

property p_edge_cases;

@(negedge clk) disable iff (!rst);

assert property (~rst |-> ($onehot {a, b}));

property p_overflow_underflow;

@(posedge clk) disable iff (!rst);

assert property (~rst |-> ((a == 2'b01) | (b == 2'b01)));

clocking @ (posedge clk);

endmodule