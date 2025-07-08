module tb_fft_module;
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

logic clk;
logic rst;
logic start;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic done;

fft_module fft (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

property p_clk_period;
clocking @ (posedge clk); endclocking

property p_reset;
@(negedge clk) disable iff (!rst) =>!done; endproperty

property p_start;
@(posedge clk) disable iff (!start) =>!done; endproperty

property p_data_in_range;
[data_in >= 0 && data_in < (1 << DATA_WIDTH)] -> [data_out >= 0 && data_out < (1 << DATA_WIDTH)]; endproperty

property p_overflow;
[data_in == ((1 << DATA_WIDTH)-1)] |-> [data_out == ((1 << DATA_WIDTH)-1)]; endproperty

property p_underflow;
[data_in == 0] |-> [data_out == 0]; endproperty

assert property (p_clk_period);
assert property (p_reset);
assert property (p_start);
assert property (p_data_in_range);
assert property (p_overflow);
assert property (p_underflow);

endmodule