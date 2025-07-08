module tb_param_shift_reg;

// Parameters
parameter WIDTH = 8;

// Input/Output signals
input clk;
input rst;
input load;
input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;

// DUT instantiation
param_shift_reg #(.WIDTH(WIDTH)) dut (.clk(clk),.rst(rst),.load(load),.data_in(data_in),.data_out(data_out));

// Clock generation
always #10 clk = ~clk; // Assuming 10ns period

// Properties
property prop_load_data;
    @(posedge clk) disable iff (!rst) ($rose(load) => data_out == data_in);
endproperty

property prop_idle;
    @(posedge clk) disable iff (!rst) (!load && data_out == data_out[WIDTH-1:0]);
endproperty

property prop_rst;
    @(posedge clk) disable iff (!rst) (rst => data_out == 0);
endproperty

property prop_edge;
    @(posedge clk) disable iff (!rst) ((load | rst) |->!($fell(clk)));
endproperty

assert property (prop_load_data);
assert property (prop_idle);
assert property (prop_rst);
assert property (prop_edge);

endmodule