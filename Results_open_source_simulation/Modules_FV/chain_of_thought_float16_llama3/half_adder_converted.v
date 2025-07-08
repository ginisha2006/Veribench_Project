module tb_half_adder;

logic a, b;

logic sum, carry;

half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;
@(posedge clk) assert property ($onehot(sum) |=> (sum == a ^ b));

property p_carry_correct;
@(posedge clk) assert property ((a & b) |=> carry);

property p_sum_carry_xor;
@(posedge clk) assert property (!carry |=> (sum == a ^ b));

property p_carry_zero;
@(posedge clk) assert property (!(a & b) |=>!carry);

property p_edge_cases;
@(negedge a or negedge b) assert property (sum == 0 && carry == 0);

property p_overflow;
@(posedge clk) assert property (!(a || b) |=> carry == 0);

endmodule