module tb_bidir_pin;

parameter WIDTH = 1;
inout [WIDTH-1:0] pin;
input dir;
input [WIDTH-1:0] data_out;
output [WIDTH-1:0] data_in;

bidir_pin dut (.pin(pin),.dir(dir),.data_out(data_out),.data_in(data_in));

property p_dir_set;
@(posedge dir) |=> ($onehot(pin));
assert property (p_dir_set);

property p_data_out_drive;
@(posedge dir) |=> (dir? (pin == data_out) : ({WIDTH{1'bz} == pin)));
assert property (p_data_out_drive);

property p_data_in_drive;
@(negedge dir) |=> (dir? (data_in == {WIDTH{1'bz}}) : (data_in == pin));
assert property (p_data_in_drive);

property p_invalid_transition;
!(|-> (~dir && dir));
assert property (p_invalid_transition);

endmodule