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

fft_module #(.DATA_WIDTH(16), .FFT_POINTS(1024)) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);

assert (@(posedge clk) disable iff (!rst)
        !done |=> ##[0:$] done == 0);

assert (@(posedge clk) disable iff (!rst)
        start |-> ##[1:$] done);

assert (@(posedge clk) disable iff (!rst)
        start |-> data_in[*] == data_in[0]);

assert (@(posedge clk) disable iff (!rst)
        start |-> ##[1:$] done);

assert (@(posedge clk) disable iff (!rst)
        !done |-> data_out == 16'b0);

assert (@(posedge clk) disable iff (!rst)
        done |-> data_out != 16'b0);

endmodule