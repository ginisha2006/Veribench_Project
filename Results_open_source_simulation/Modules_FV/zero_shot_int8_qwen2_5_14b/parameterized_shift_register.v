module tb_param_shift_reg(
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

wire clk_wire;
clk_gen clk_inst (.clk(clk_wire));

param_shift_reg #(.WIDTH(8)) dut (
    .clk(clk_wire),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
);

property reset_behavior;
    @(posedge clk_wire) disable iff (!rst)
    rst |-> ##1 data_out == 8'b0;
endproperty

assert property(reset_behavior);

property load_behavior;
    @(posedge clk_wire) disable iff (!load)
    load & !rst |=> ##1 data_out == data_in;
endproperty

assert property(load_behavior);

property no_change_when_not_loaded;
    @(posedge clk_wire) disable iff (load || rst)
    !load & !rst |-> ##1 data_out == data_out;
endproperty

assert property(no_change_when_not_loaded);

endmodule