module tb_param_shift_reg;

parameter WIDTH = 8;

input clk;

input rst;

input load;

input [WIDTH-1:0] data_in;

output reg [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (.clk(clk),.rst(rst),.load(load),.data_in(data_in),.data_out(data_out));

property shift_reg_load_sets_data_out;

@(posedge clk) disable iff (!rst) ($rose(load) => ($onehot(data_out == data_in));

property shift_reg_rst_resets_data_out;

@(posedge clk) disable iff (!rst) ($fell(rst) => $setmismatch(data_out, 0));

property shift_reg_no_load_on_rst;

@(posedge clk) disable iff (!rst) (!$rose(load) |!rst);

property shift_reg_no_load_on_clk;

@(posedge clk) disable iff (!rst) (!$rose(load) |!clk);

property shift_reg_data_out_stays_same_on_idle;

@(posedge clk) disable iff (!rst) (!$rose(load) => $stable(data_out));

assert property (shift_reg_load_sets_data_out);

assert property (shift_reg_rst_resets_data_out);

assert property (shift_reg_no_load_on_rst);

assert property (shift_reg_no_load_on_clk);

assert property (shift_reg_data_out_stays_same_on_idle);

endmodule