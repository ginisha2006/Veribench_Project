module tb_digital_filter;

parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

input clk;
input rst;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
input [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

digital_filter dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .data_out(data_out),
   .coeff(coeff)
);

property p_data_width;
    @(posedge clk) disable iff (!rst) ((|data_in[DATA_WIDTH-1:0]) && &(data_out[DATA_WIDTH-1:0]));
endproperty

property p_coeff_width;
    @(posedge clk) disable iff (!rst) ((|coeff[i][COEFF_WIDTH-1:0]) for (i=0; i<NUM_TAPS; i++));
endproperty

property p_data_out_range;
    @(posedge clk) disable iff (!rst) ($isunknown(data_out) || ($isposinf(data_out) || $isneginf(data_out)));
endproperty

property p_coeff_range;
    @(posedge clk) disable iff (!rst) ($isunknown(coeff[i]) for (i=0; i<NUM_TAPS; i++));
endproperty

property p_transition;
    @(posedge clk) disable iff (!rst) (!(rst) |-> ##1!rst);
endproperty

assert property (p_data_width);
assert property (p_coeff_width);
assert property (p_data_out_range);
assert property (p_coeff_range);
assert property (p_transition);

endmodule