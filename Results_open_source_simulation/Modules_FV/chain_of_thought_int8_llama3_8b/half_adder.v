module tb_half_adder;

logic [1:0] a, b;
logic sum, carry;

half_adder dut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

property p_sum_correct;
    @(posedge clk) disable iff (!rst_n) ((a[0] == 0 && b[0] == 0) | (a[0] == 1 && b[0] == 1)) => sum == a[0] ^ b[0];
endproperty

property p_carry_correct;
    @(posedge clk) disable iff (!rst_n) ((a[0] == 1 && b[0] == 1) || (a[0] == 0 && b[0] == 0)) => carry == a[0] & b[0];
endproperty

property p_sum_carry_edge_cases;
    @(posedge clk) disable iff (!rst_n) ((a[0] == 1 && b[0] == 1) | (a[0] == 0 && b[0] == 0)) => ($onehot({sum, carry}));
endproperty

property p_sum_carry_overflow;
    @(posedge clk) disable iff (!rst_n) ((a[0] == 1 && b[0] == 1) && (a[0] == 1 && b[0] == 1)) | ((a[0] == 0 && b[0] == 0) && (a[0] == 0 && b[0] == 0)) => assert false;
endproperty

property p_sum_carry_underflow;
    @(posedge clk) disable iff (!rst_n) ((a[0] == 1 && b[0] == 0) && (a[0] == 0 && b[0] == 1)) => assert false;
endproperty

assert property (p_sum_correct);
assert property (p_carry_correct);
assert property (p_sum_carry_edge_cases);
assert property (p_sum_carry_overflow);
assert property (p_sum_carry_underflow);

endmodule