module tb_param_multiplier;

// Parameters
localparam WIDTH = 8;

// Input/Output signals
input [WIDTH-1:0] a;
input [WIDTH-1:0] b;
output [2*WIDTH-1:0] product;

// DUT instantiation
param_multiplier #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.product(product));

// Clock signal generation
reg clk;
always #10 clk = ~clk; // 10ns period

// Properties
property p_multiply;
    @(posedge clk) disable iff (!clk) ((a == 0) | (b == 0) | (product == 0));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!clk) ($signed(product) > $max_value($signed((1 << (2*WIDTH))-1)));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!clk) ($signed(product) < -$max_value($signed(1 << (2*WIDTH))));
endproperty

assert property (p_multiply);
assert property (p_overflow);
assert property (p_underflow);

endmodule