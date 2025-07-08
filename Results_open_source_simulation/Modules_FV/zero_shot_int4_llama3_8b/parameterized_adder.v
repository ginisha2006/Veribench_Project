module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

property prop_addition;
    @(posedge clk) ((a + b == sum) && (!carry));
endproperty

property prop_carry_out;
    @(posedge clk) (carry == (a[WIDTH-1] & ~b[WIDTH-1]) | (~a[WIDTH-1] & b[WIDTH-1]));
endproperty

property prop_carry_in;
    @(posedge clk) (carry == (sum[WIDTH-1] & ~sum[WIDTH-2]) | (~sum[WIDTH-1] & sum[WIDTH-2]));
endproperty

property prop_overflow;
    @(posedge clk) ($rose(carry) | $fell(carry));
endproperty

property prop_underflow;
    @(posedge clk) ($fell(carry) | $rose(carry));
endproperty

property prop_edge_cases;
    @(posedge clk) ((a == 0) | (b == 0) | (a == b) | (a == ~b));
endproperty

assert property (prop_addition);
assert property (prop_carry_out);
assert property (prop_carry_in);
assert property (prop_overflow);
assert property (prop_underflow);
assert property (prop_edge_cases);

endmodule