module tb_half_adder;

logic a, b, sum, carry;
half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;
@(posedge clk) disable iff (!rst_n) ((a == 0 && b == 0) => sum == 0) |
                         ((a == 0 && b == 1) => sum == 1) |
                         ((a == 1 && b == 0) => sum == 1) |
                         ((a == 1 && b == 1) => sum == 0);
endproperty

property p_carry_correct;
@(posedge clk) disable iff (!rst_n) ((a == 0 && b == 0) => carry == 0) |
                         ((a == 0 && b == 1) => carry == 0) |
                         ((a == 1 && b == 0) => carry == 0) |
                         ((a == 1 && b == 1) => carry == 1);
endproperty

property p_no_overflow;
@(posedge clk) disable iff (!rst_n)!((a | b) == 1'b1);
endproperty

property p_no_underflow;
@(posedge clk) disable iff (!rst_n)!((~a & ~b) == 1'b0);
endproperty

property p_edge_cases;
@(posedge clk) disable iff (!rst_n) ((a == 1'b0) | (b == 1'b0));
endproperty

assert property (p_sum_correct);
assert property (p_carry_correct);
assert property (p_no_overflow);
assert property (p_no_underflow);
assert property (p_edge_cases);

endmodule