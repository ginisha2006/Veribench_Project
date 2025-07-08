module tb_param_shift_reg;

parameter WIDTH = 8;

input clk;
input rst;
input load;
input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (.clk(clk),.rst(rst),.load(load),.data_in(data_in),.data_out(data_out));

property p_reset_data_out_zero;
    @(posedge clk) disable iff (!rst) ($onehot(data_out));
endproperty

property p_load_data_out_eq_data_in;
    @(posedge clk) disable iff (!rst &&!load) ($rose(data_out) |-> $eq(data_out, data_in));
endproperty

property p_load_data_out_not_zero;
    @(posedge clk) disable iff (!rst && load) (!$rose(data_out) |-> $eq(data_out, data_in));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst) ((|data_in) |=> $rose(data_out));
    @(posedge clk) disable iff (!rst) ((!|data_in) |=> $fell(data_out));
endproperty

assert property (p_reset_data_out_zero);
assert property (p_load_data_out_eq_data_in);
assert property (p_load_data_out_not_zero);
assert property (p_edge_cases);

endmodule