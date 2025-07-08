module tb_bidir_pin;
parameter WIDTH = 1;
inout [WIDTH-1:0] pin;
input dir;
input [WIDTH-1:0] data_out;
output [WIDTH-1:0] data_in;

bidir_pin dut (.pin(pin),.dir(dir),.data_out(data_out),.data_in(data_in));

property p_dir_input;
@(posedge clk) disable iff (!clk);
dir == data_out[0];
endproperty

property p_dir_output;
@(posedge clk) disable iff (!clk);
dir && data_in!= {WIDTH{1'bz}};
endproperty

property p_data_in_valid;
@(posedge clk) disable iff (!clk);
data_in == data_out;
endproperty

property p_data_out_valid;
@(posedge clk) disable iff (!clk);
dir && data_out!= {WIDTH{1'bz}};
endproperty

property p_dir_transition;
 @(posedge clk) disable iff (!clk);
dir && ($rose(dir) | $fell(dir));
endproperty

property p_dir_fall_transition;
 @(posedge clk) disable iff (!clk);
!dir && ($fell(dir) | $rose(dir));
endproperty

assert property (p_dir_input);
assert property (p_dir_output);
assert property (p_data_in_valid);
assert property (p_data_out_valid);
assert property (p_dir_transition);
assert property (p_dir_fall_transition);

endmodule