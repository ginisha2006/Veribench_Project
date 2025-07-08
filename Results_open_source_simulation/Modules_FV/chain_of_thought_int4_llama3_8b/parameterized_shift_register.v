module tb_param_shift_reg;

parameter WIDTH = 8;

input clk;
input rst;
input load;
input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

property p_reset_value;
    @(posedge clk) disable iff (!rst);
   !data_out[WIDTH-1:0];
endproperty

property p_load_data;
    @(posedge clk) disable iff (!load &&!rst);
    data_out == data_in;
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst);
    ($onehot {data_out[WIDTH-1:0]});
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst);
    data_out[WIDTH-1] == data_in[WIDTH-1];
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst);
    data_out[0] == data_in[0];
endproperty

assert property (p_reset_value);
assert property (p_load_data);
assert property (p_edge_cases);
assert property (p_overflow);
assert property (p_underflow);

endmodule