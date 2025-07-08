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

assert (@(posedge clk) disable iff (!rst) 
        start |-> ##[1:$] !start);

assert (@(posedge clk) disable iff (!rst)
        start |=> ##[1:$] done);

assert (@(posedge clk) disable iff (!rst)
        done |-> ##1 !done);

assert (@(posedge clk) disable iff (!rst)
        start && !done |-> $stable(data_in));

assert (@(posedge clk) disable iff (!rst)
        !$isunknown(data_in) |-> data_in < 2**16);

assert (@(posedge clk) disable iff (!rst)
        !$isunknown(data_in) |-> data_in >= 0);

assign data_out = data_out_wire;
assign done = done_wire;

endmodule