module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;
    @(posedge clk) ((a + b == sum) |-> (!carry));
endproperty

property p_carry_set;
    @(posedge clk) ((a[WIDTH-1] &&!b[WIDTH-1]) | (b[WIDTH-1] &&!a[WIDTH-1]) | (a[WIDTH-1] && b[WIDTH-1])) |-> carry;
endproperty

property p_carry_reset;
    @(posedge clk) (!((a[WIDTH-1] &&!b[WIDTH-1]) | (b[WIDTH-1] &&!a[WIDTH-1]) | (a[WIDTH-1] && b[WIDTH-1]))) |->!carry;
endproperty

property p_overflow;
    @(posedge clk) ((a == (1 << WIDTH)-1) && (b!= 0)) |-> (sum == (1 << WIDTH)-1);
endproperty

property p_underflow;
    @(posedge clk) ((a == 0) && (b == (1 << WIDTH)-1)) |-> (sum == 0);
endproperty

assert property (p_sum_correct);
assert property (p_carry_set);
assert property (p_carry_reset);
assert property (p_overflow);
assert property (p_underflow);

endmodule