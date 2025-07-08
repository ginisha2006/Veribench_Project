module tb_fft_module (
    input clk,
    input rst,
    input start,
    input [15:0] data_in,
    output reg [15:0] data_out,
    output reg done
);

reg clk;
wire [15:0] data_out_wire;
wire done_wire;

fft_module #(.DATA_WIDTH(16), .FFT_POINTS(1024)) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out_wire),
    .done(done_wire)
);

always #5 clk = ~clk;

property reset_assertion;
    @(posedge clk) disable iff (!rst) 
        start |-> ##[1:$] !start;
endproperty

assert property(reset_assertion);

property start_done_sequence;
    @(posedge clk) disable iff (!rst)
        start |=> ##[1:$] done;
endproperty

assert property(start_done_sequence);

property done_reset;
    @(posedge clk) disable iff (!rst)
        done |-> ##1 !done;
endproperty

assert property(done_reset);

property data_stability;
    @(posedge clk) disable iff (!rst)
        start && !done |-> $stable(data_in);
endproperty

assert property(data_stability);

property data_width_overflow;
    @(posedge clk) disable iff (!rst)
        !$isunknown(data_in) |-> data_in < 2**16;
endproperty

assert property(data_width_overflow);

property data_width_underflow;
    @(posedge clk) disable iff (!rst)
        !$isunknown(data_in) |-> data_in >= 0;
endproperty

assert property(data_width_underflow);

assign data_out = data_out_wire;
assign done = done_wire;

endmodule