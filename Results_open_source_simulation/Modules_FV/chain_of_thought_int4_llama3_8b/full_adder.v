module tb_full_adder;

parameter PERIOD = 10; // period of the clock

logic clk;

logic rst;

logic [1:0] a;

logic [1:0] b;

logic cin;

logic sum;

logic cout;

full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

property p_sum_correct;

@ (posedge clk) disable iff (!rst)

assert property (@(posedge clk) sum == (a ^ b ^ cin));

property p_cout_correct;

@ (posedge clk) disable iff (!rst)

assert property (@(posedge clk) cout == ((a & b) | (b & cin) | (a & cin)));

property p_edge_cases;

@ (posedge clk) disable iff (!rst)

assert property (@(posedge clk) ($rose(a) | $fell(a)) implies ($rose(b) | $fell(b));

@ (posedge clk) disable iff (!rst)

assert property (@(posedge clk) ($rose(cin) | $fell(cin)) implies ($rose(a) | $fell(a));

always #PERIOD clk = ~clk;

initial begin

#5 rst = 1'b0;

#10 rst = 1'b1;

#20 $finish;

end

endmodule