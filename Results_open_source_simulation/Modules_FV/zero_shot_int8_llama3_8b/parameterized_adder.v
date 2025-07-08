module tb_param_adder;

// Parameters
localparam WIDTH = 8;

// Signals
logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] sum;
logic carry;

// DUT instantiation
param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

// Clock generation
always #5 a <= ~a; // Non-deterministic clock
always #5 b <= ~b; // Non-deterministic clock

// Properties
property p_sum_correct;
@(posedge clk) ($onehot({a[WIDTH-1], b[WIDTH-1]} => sum == a + b));
endproperty

property p_carry_set;
@(posedge clk) (a[WIDTH-1] && b[WIDTH-1] => carry);
endproperty

property p_carry_reset;
@(posedge clk) (~a[WIDTH-1] && ~b[WIDTH-1] =>!carry);
endproperty

property p_overflow;
@(posedge clk) ((a >= 2**WIDTH - 1 || b >= 2**WIDTH - 1) => sum >= 2**WIDTH - 1);
endproperty

property p_underflow;
@(posedge clk) ((a < -(2**WIDTH) || b < -(2**WIDTH)) => sum < -(2**WIDTH));
endproperty

assert property (p_sum_correct);
assert property (p_carry_set);
assert property (p_carry_reset);
assert property (p_overflow);
assert property (p_underflow);

endmodule