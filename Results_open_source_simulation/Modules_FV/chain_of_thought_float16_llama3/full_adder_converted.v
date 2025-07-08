module tb_full_adder;

logic a, b, cin, sum, cout;

full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

property p_sum_correct; @(posedge clk) assert property (@(posedge clk) (sum == (a ^ b ^ cin)));

property p_cout_correct; @(posedge clk) assert property (@(posedge clk) (cout == ((a & b) | (b & cin) | (a & cin)));

property p_edge_cases; @(posedge clk) assert property (!((a == 0) && (b == 0) && (cin == 0)) |-> (sum == 0) | (cout == 0));

property p_overflow; @(posedge clk) assert property (!(a == 1'b1) |=>!(cout == 1'b1));

endmodule