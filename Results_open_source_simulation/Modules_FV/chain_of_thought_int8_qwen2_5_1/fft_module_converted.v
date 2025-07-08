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
wire [15:0] data_out;
wire done;

always #5 clk =~clk;

fft_module #(.DATA_WIDTH(16), .FFT_POINTS(1024)) uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);

assert (@(posedge clk) disable iff (!rst)
    rst |-> (data_out == 16'b0 && !done));

assert (@(posedge clk) disable iff (!rst)
    rst |-> !start);

assert (@(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[1:$] done[*]);

assert (@(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[$:1] done[*]);

assert (@(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[$:1] data_out[*]);

assert (@(posedge clk) disable iff (!rst)
    !start |-> data_out == 16'b0);

assert (@(posedge clk) disable iff (!rst)
    start[*] |=> !start || start[*]);

assert (@(posedge clk) disable iff (!rst)
    done[*] |=> !done || done[*]);

endmodule