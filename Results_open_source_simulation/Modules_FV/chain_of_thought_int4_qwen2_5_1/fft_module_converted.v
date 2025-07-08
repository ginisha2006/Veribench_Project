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

fft_module #(.DATA_WIDTH(16), .FFT_POINTS(1024)) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);

always begin
    clk <= ~clk; 
    #(5ns);
end

assert (@(posedge rst) disable iff (!rst)
 !done);

assert (@(posedge rst) disable iff (!rst)
 start == 0);

assert (@(posedge clk) disable iff (!rst)
 ($rose(done)) |-> ##[0:$] ($fell(done)));

assert (@(posedge rst) disable iff (!rst)
 data_out == 0);

assert (@(posedge clk) disable iff (!rst)
 start && !$past(done) |->
 ##[$:1024*8] done);

assert (@(posedge clk) disable iff (!rst)
 start && done ? data_out != 0 : data_out == 0);

endmodule