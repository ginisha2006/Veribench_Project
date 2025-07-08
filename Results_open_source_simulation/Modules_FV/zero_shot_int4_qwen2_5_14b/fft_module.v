module tb_fft_module (
    input clk,
    input rst,
    input start,
    input [15:0] data_in,
    output reg [15:0] data_out,
    output reg done
);

fft_module #(
    .DATA_WIDTH(16),
    .FFT_POINTS(1024)
) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
);

reg clk;
always #5 clk = ~clk;

property reset_assertion;
 @(posedge rst) disable iff (!rst)
 !done;
endproperty
assert property(reset_assertion);

property start_done_sequence;
 @(posedge clk) disable iff (!rst)
 start |-> ##[0:$] done;
endproperty
assert property(start_done_sequence);

property done_stable;
 @(posedge clk) disable iff (!rst)
 done[*1:$] |->
 ($rose(done)) |-> done[*1:$];
endproperty
assert property(done_stable);

property data_out_valid;
 @(posedge clk) disable iff (!rst)
 start && done -> data_out != 16'b0;
endproperty
assert property(data_out_valid);

endmodule