module tb_fft_module;
parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

logic clk;
logic rst;
logic start;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic done;

fft_module #(.DATA_WIDTH(DATA_WIDTH),.FFT_POINTS(FFT_POINTS)) dut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst) property(p_clk_period);
    property(p_clk_period)!($rose(clk) && $rose(clk));

assert property (p_clk_period);

property p_data_in_range;
    property(p_data_in_range) ($onehot(data_in) && $size(data_in) == DATA_WIDTH);

assert property (p_data_in_range);

property p_start_edge;
    @(posedge clk) disable iff (!rst) property(p_start_edge);
    property(p_start_edge) start == 1'b1;

assert property (p_start_edge);

property p_done_edge;
    @(posedge clk) disable iff (!rst) property(p_done_edge);
    property(p_done_edge) done == 1'b1;

assert property (p_done_edge);

property p_data_out_range;
    property(p_data_out_range) ($onehot(data_out) && $size(data_out) == DATA_WIDTH);

assert property (p_data_out_range);

property p_overflow;
    property(p_overflow) ($rose(data_out[DATA_WIDTH-1]);

assert property (p_overflow);

property p_underflow;
    property(p_underflow) ($fell(data_out[0]);

assert property (p_underflow);

endmodule