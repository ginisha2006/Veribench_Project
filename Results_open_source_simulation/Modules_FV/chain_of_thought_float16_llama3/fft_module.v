module tb_fft_module;

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

input clk;
input rst;
input start;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
output done;

fft_module dut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst) ($rose(clk));
endproperty

property p_data_width;
    [(DATA_WIDTH-1:0)] data_in_valid;
    assert property (@(posedge clk) disable iff (!rst) (|data_in[data_in_valid]);
endproperty

property p_fft_points;
    integer i;
    assert property (@(posedge clk) disable iff (!rst) ((i < FFT_POINTS) |-> (data_out[i*DATA_WIDTH+DATA_WIDTH-1:i*DATA_WIDTH]));
endproperty

property p_start_reset;
    assert property (@(posedge clk) disable iff (!rst) (!start |=>!done);
endproperty

property p_done_reset;
    assert property (@(posedge clk) disable iff (!rst) (start |=> done);
endproperty

property p_data_flow;
    assert property (@(posedge clk) disable iff (!rst) ((start &&!done) |=> (data_out!= 0));
endproperty

property p_overflow;
    assert property (@(posedge clk) disable iff (!rst) ((start &&!done) |=> (data_out[DATA_WIDTH-1] == 0));
endproperty

property p_underflow;
    assert property (@(posedge clk) disable iff (!rst) ((start &&!done) |=> (data_out[0] == 0));
endproperty

endmodule