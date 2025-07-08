module tb_fft_module;

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

logic clk;
logic rst;
logic start;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic done;

fft_module dut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst) ($onehot(0.9 * period(clk)));
endproperty

property p_data_width;
   !(|data_in[DATA_WIDTH-1:0]);
endproperty

property p_start_reset;
   !start |->!rst;
endproperty

property p_done_reset;
   !done |->!rst;
endproperty

property p_data_out_width;
   !(|data_out[DATA_WIDTH-1:0]);
endproperty

property p_overflow_underflow;
    ((data_in > (1 << (DATA_WIDTH - 1))) | (data_in < -(1 << (DATA_WIDTH - 1))) |->
        ##1 (data_out!= {DATA_WIDTH{1'bX}});
endproperty

property p_edge_cases;
    (start &&!rst) |->
        ##1 (~done || ~start);
endproperty

assert property (p_clk_period);
assert property (p_data_width);
assert property (p_start_reset);
assert property (p_done_reset);
assert property (p_data_out_width);
assert property (p_overflow_underflow);
assert property (p_edge_cases);

endmodule