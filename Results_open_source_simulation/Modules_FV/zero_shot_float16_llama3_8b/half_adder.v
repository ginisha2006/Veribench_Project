module tb_half_adder;

logic a, b, sum, carry;
half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;
    @(posedge clk) ((a == 0 && b == 0) | (a == 1 && b == 0) | (a == 0 && b == 1) | (a == 1 && b == 1)) => (sum == (a ^ b));
endproperty

property p_carry_correct;
    @(posedge clk) ((a && b) | (a &&!b) | (!a && b)) => (carry == (a && b));
endproperty

property p_no_overflow;
    @(posedge clk) (!(a || b) |!(a && b)) |-> ##[1:1] (!carry);
endproperty

property p_no_underflow;
    @(posedge clk) (a && b) |-> ##[1:1] (carry);
endproperty

property p_edge_transition;
    @(posedge clk) ($fell(clk) |=> (~a == a) & (~b == b));
endproperty

assert property (p_sum_correct);
assert property (p_carry_correct);
assert property (p_no_overflow);
assert property (p_no_underflow);
assert property (p_edge_transition);

initial begin
    #10 clk = 1'b0; // Initialize clock
    forever #5 clk = ~clk; // Generate clock
end

endmodule