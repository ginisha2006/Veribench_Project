module tb_fft_module (
    input clk,
    input rst,
    input start,
    input [15:0] data_in,
    output reg [15:0] data_out,
    output reg done
);

reg clk;
wire rst;
wire start;
wire [15:0] data_in;
reg [15:0] data_out;
reg done;

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

fft_module #(.DATA_WIDTH(DATA_WIDTH), .FFT_POINTS(FFT_POINTS)) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);

always #5 clk =~clk;

property reset_assertion;
 @(posedge clk) disable iff (!rst) 
   !dut.done |=> ##[1:$] dut.done == 0;
endproperty

assert property(reset_assertion);

property start_done_sequence;
 @(posedge clk) disable iff (!rst) 
   dut.start && ##[1:$] dut.done;
endproperty

assert property(start_done_sequence);

property data_stability;
 @(posedge clk) disable iff (!rst) 
   !$isunknown(dut.data_out);
endproperty

assert property(data_stability);

property no_overflow_underflow;
 @(posedge clk) disable iff (!rst) 
   dut.data_out < 2**DATA_WIDTH && dut.data_out >= -2**(DATA_WIDTH-1);
endproperty

assert property(no_overflow_underflow);

endmodule