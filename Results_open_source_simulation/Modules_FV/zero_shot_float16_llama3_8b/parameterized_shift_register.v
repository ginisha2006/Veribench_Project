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
always #10 clk = ~clk; // 10ns period

// Properties
property p_load_data;
    @(posedge clk) disable iff (!rst) ($onehot(data_out));
endproperty

property p_reset;
    @(posedge clk) disable iff (!rst) (data_out == 0);
endproperty

property p_no_load_on_rst;
    @(posedge clk) disable iff (rst) (!load);
endproperty

property p_load_on_load;
    @(posedge clk) disable iff (load) (data_out == data_in);
endproperty

property p_no_overflow;
    @(posedge clk) disable iff ((data_in >= (1 << WIDTH)-1) || (data_in < -(1 << (WIDTH-1)))) (!load);
endproperty

property p_no_underflow;
    @(posedge clk) disable iff ((data_in < 0) || (data_in > (1 << WIDTH)-1)) (!load);
endproperty

assert property (p_load_data);
assert property (p_reset);
assert property (p_no_load_on_rst);
assert property (p_load_on_load);
assert property (p_no_overflow);
assert property (p_no_underflow);

endmodule