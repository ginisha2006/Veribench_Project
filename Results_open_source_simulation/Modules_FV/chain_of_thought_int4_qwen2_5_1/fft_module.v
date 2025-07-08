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

property reset_assertion;
 @(posedge rst) disable iff (!rst)
 !done;
endproperty

assert property(reset_assertion);

property start_inactive_when_rst;
 @(posedge rst) disable iff (!rst)
 start == 0;
endproperty

assert property(start_inactive_when_rst);

property done_behavior;
 @(posedge clk) disable iff (!rst)
 ($rose(done)) |-> ##[0:$] ($fell(done));
endproperty

assert property(done_behavior);

property data_stability_on_reset;
 @(posedge rst) disable iff (!rst)
 data_out == 0;
endproperty

assert property(data_stability_on_reset);

property done_after_start;
 @(posedge clk) disable iff (!rst)
 start && !$past(done) |->
 ##[$:1024*8] done;
endproperty

assert property(done_after_start);

property data_validity;
 @(posedge clk) disable iff (!rst)
 start && done ? data_out != 0 : data_out == 0;
endproperty

assert property(data_validity);

endmodule