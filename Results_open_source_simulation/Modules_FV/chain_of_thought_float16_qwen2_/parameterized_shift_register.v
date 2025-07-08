module tb_param_shift_reg (
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

wire clk_wire;
assign clk_wire = clk;

property reset_assertion;
    @(posedge clk_wire) disable iff (!rst) data_out == 0;
endproperty
assert property(reset_assertion);

property load_data;
    @(posedge clk_wire) disable iff (!load | rst) data_out == data_in;
endproperty
assert property(load_data);

property no_change_when_not_load;
    @(posedge clk_wire) disable iff (load | rst) data_out !== data_in;
endproperty
assert property(no_change_when_not_load);

property reset_overrides_load;
    @(posedge clk_wire) disable iff (!rst) (data_out == 0) |-> (load | rst);
endproperty
assert property(reset_overrides_load);

property load_only_changes_on_posedge_clk;
    @(posedge clk_wire) disable iff (!load | rst) ($past(data_out != data_in));
endproperty
assert property(load_only_changes_on_posedge_clk);

property no_overflow_underflow;
    @(posedge clk_wire) disable iff (load | rst) data_out inside {[0:255]};
endproperty
assert property(no_overflow_underflow);

endmodule