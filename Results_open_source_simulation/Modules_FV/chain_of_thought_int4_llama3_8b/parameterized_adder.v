module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

property prop_sum_correct;
    @(posedge clk) disable iff (!clk);
    ((a + b == sum) |-> (carry == (a[W-1] & b[W-1]) | (a[W-1] &!b[W-1] &!carry) | (!a[W-1] & b[W-1] & carry));
endproperty

property prop_carry_set;
    @(posedge clk) disable iff (!clk);
    (a[W-1] & b[W-1] | a[W-1] &!b[W-1] &!carry |!a[W-1] & b[W-1] & carry -> carry);
endproperty

property prop_carry_reset;
    @(posedge clk) disable iff (!clk);
    (!a[W-1] &!b[W-1] & carry ->!carry);
endproperty

property prop_overflow;
    @(posedge clk) disable iff (!clk);
    (a[W-1] & b[W-1] &!carry -> $rose(carry));
endproperty

property prop_underflow;
    @(posedge clk) disable iff (!clk);
    (!a[W-1] &!b[W-1] & carry -> $fell(carry));
endproperty

assert property (prop_sum_correct);
assert property (prop_carry_set);
assert property (prop_carry_reset);
assert property (prop_overflow);
assert property (prop_underflow);

endmodule