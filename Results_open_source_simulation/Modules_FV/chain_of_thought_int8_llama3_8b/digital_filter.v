module tb_digital_filter;

parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

input clk;
input rst;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
input [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

reg clk_gen;

always #10 clk_gen = ~clk_gen;

digital_filter dut(clk, rst, data_in, data_out, coeff);

property p_data_width_valid;
@(posedge clk) disable iff (!rst) ($size(data_in) == DATA_WIDTH);
assert property (p_data_width_valid);

property p_coeff_width_valid;
@(posedge clk) disable iff (!rst) ($size(coeff[0]) == COEFF_WIDTH);
assert property (p_coeff_width_valid);

property p_num_taps_valid;
@(posedge clk) disable iff (!rst) ($size(coeff) == NUM_TAPS);
assert property (p_num_taps_valid);

property p_data_out_width_valid;
@(posedge clk) disable iff (!rst) ($size(data_out) == DATA_WIDTH);
assert property (p_data_out_width_valid);

property p_no_underflow;
@(posedge clk) disable iff (!rst) ((data_in < 2**((DATA_WIDTH-1)-1)) |-> (data_out < 2**((DATA_WIDTH-1)-1)));
assert property (p_no_underflow);

property p_no_overflow;
@(posedge clk) disable iff (!rst) ((data_in > 2**(DATA_WIDTH-1)-1) |-> (data_out > 2**(DATA_WIDTH-1)-1));
assert property (p_no_overflow);

property p_invalid_transition;
@(posedge clk) disable iff (!rst) (!(rst) |=> (~rst));
assert property (p_invalid_transition);

endmodule