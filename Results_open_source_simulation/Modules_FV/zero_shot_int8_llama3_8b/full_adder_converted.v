module tb_full_adder;

parameter CLOCK_PERIOD = 10;

logic clk;

logic [1:0] a, b;

logic cin, sum, cout;

full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

always #CLOCK_PERIOD/2 clk = ~clk;

property p_sum_correct;

@(posedge clk) ($onehot(a) && $onehot(b) && $onehot(cin) => ($bitsum(a, b, cin) == sum));

property p_cout_correct;

@(posedge clk) ($onehot(a) && $onehot(b) && $onehot(cin) => ((a & b) | (b & cin) | (a & cin) == cout));

property p_overflow;

@(posedge clk) ($onehot(a) && $onehot(b) &&!cin => (a + b > 1'b1));

property p_underflow;

@(posedge clk) (!$onehot(a) &&!$onehot(b) && cin => (a + b < 1'b0));

assert property (p_sum_correct);

assert property (p_cout_correct);

assert property (p_overflow);

assert property (p_underflow);

endmodule