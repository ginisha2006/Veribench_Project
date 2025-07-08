module tb_param_adder;

// Parameters
localparam WIDTH = 8;

// Input/Output signals
input [WIDTH-1:0] a, b;
output [WIDTH-1:0] sum;
output logic carry;

// DUT instantiation
param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

// Clock signal generation
logic clk;
always #5 clk = ~clk; // 10ns period

// Property 1: Functional correctness
property p_func_correctness;
@(posedge clk) disable iff (!clk) ((a + b)[WIDTH-1] == carry) && ($onehot(sum));
assert property (p_func_correctness);

// Property 2: Overflow detection
property p_overflow;
@(posedge clk) disable iff (!clk) ((a[WIDTH-1] == 1'b1) && (b[WIDTH-1] == 1'b1) && (sum[WIDTH-1]!= 1'b1));
assert property (p_overflow);

// Property 3: Underflow detection
property p_underflow;
@(posedge clk) disable iff (!clk) ((a[WIDTH-1] == 1'b0) && (b[WIDTH-1] == 1'b0) && (sum[WIDTH-1]!= 1'b0));
assert property (p_underflow);

endmodule