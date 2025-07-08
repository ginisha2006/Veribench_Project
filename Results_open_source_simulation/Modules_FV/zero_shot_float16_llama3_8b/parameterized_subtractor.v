module tb_param_subtractor;

// Parameters
localparam WIDTH = 8;

// Input/Output signals
input [WIDTH-1:0] a, b;
output [WIDTH-1:0] diff;
output borrow;

// DUT instantiation
param_subtractor #(.WIDTH(WIDTH)) uut (.a(a),.b(b),.diff(diff),.borrow(borrow));

// Clock signal generation
reg clk;
always #5 clk = ~clk; // 10ns period

// Properties
property p_correct_subtraction;
@(posedge clk) disable iff (!clk) ((|{borrow, diff}) == (^~(a ^ b)));
assert property (p_correct_subtraction);

property p_overflow;
@(posedge clk) disable iff (!clk) ($signed({borrow, diff}) > $signed({WIDTH{1'b1})) |-> assert(false);
assert property (p_overflow);

property p_underflow;
@(posedge clk) disable iff (!clk) ($signed({borrow, diff}) < $signed({WIDTH{1'b1})) |-> assert(false);
assert property (p_underflow);

endmodule