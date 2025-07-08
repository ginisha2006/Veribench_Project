module tb_fft_module;

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

input clk;
input rst;
input start;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
output done;

fft_module #(.DATA_WIDTH(DATA_WIDTH),.FFT_POINTS(FFT_POINTS)) dut (clk, rst, start, data_in, data_out, done);

property p_clk_period;
    @(posedge clk) disable iff (!rst) ($rose(clk) |-> ##[1:0] $fell(clk));
endproperty

property p_data_width;
    [$bits(data_in)-1:0] data_in_range;
    @(posedge clk) disable iff (!rst) (data_in_range == data_in);
endproperty

property p_start_inactive_at_reset;
    @(posedge clk) disable iff (!rst)!start;
endproperty

property p_done_inactive_at_reset;
    @(posedge clk) disable iff (!rst)!done;
endproperty

property p_fft_output_width;
    [$bits(data_out)-1:0] data_out_range;
    @(posedge clk) disable iff (!rst) (data_out_range == data_out);
endproperty

property p_fft_output_valid_after_start;
    @(posedge clk) disable iff (!rst) (start |=> ##[1:$ceil($log2(FFT_POINTS))] data_out!= 0);
endproperty

assert property (p_clk_period);
assert property (p_data_width);
assert property (p_start_inactive_at_reset);
assert property (p_done_inactive_at_reset);
assert property (p_fft_output_width);
assert property (p_fft_output_valid_after_start);

endmodule