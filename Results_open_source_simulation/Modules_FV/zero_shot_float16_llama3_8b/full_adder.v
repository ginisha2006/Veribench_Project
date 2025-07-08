module tb_full_adder;

logic a, b, cin, sum, cout;
full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

property p_sum_correct;
    @(posedge clk) ((a ^ b ^ cin) === sum);
endproperty

property p_cout_correct;
    @(posedge clk) (((a & b) | (b & cin) | (a & cin)) === cout);
endproperty

property p_overflow;
    @(posedge clk) disable iff (!clk) ((a == 1'b1 && b == 1'b1 && cin == 1'b1) | (a == 1'b1 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b0 && cin == 1'b1));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!clk) ((a == 1'b0 && b == 1'b0 && cin == 1'b0) | (a == 1'b0 && b == 1'b0 && cin == 1'b1) | (a == 1'b0 && b == 1'b1 && cin == 1'b0));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!clk) ((a == 1'b0 && b == 1'b0 && cin == 1'b0) | (a == 1'b0 && b == 1'b0 && cin == 1'b1) | (a == 1'b0 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b0 && cin == 1'b0) | (a == 1'b1 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b1 && cin == 1'b1));
endproperty

assert property (p_sum_correct);
assert property (p_cout_correct);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_edge_cases);

endmodule