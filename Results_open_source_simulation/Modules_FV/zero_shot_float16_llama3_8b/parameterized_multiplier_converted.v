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
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a == 0) | (b == 0) | (product == 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($signed(product) > $max_value($signed((1 << (2*WIDTH))-1)))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($signed(product) < -$max_value($signed(1 << (2*WIDTH))))); end

endmodule