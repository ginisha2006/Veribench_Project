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

property reset_assertion;
    @(posedge clk) disable iff (!rst)
        !done |=> ##[0:$] done == 0;
endproperty
assert property(reset_assertion);

property start_done_sequence;
    @(posedge clk) disable iff (!rst)
        start |-> ##[1:$] done;
endproperty
assert property(start_done_sequence);

property data_stability_during_start;
    @(posedge clk) disable iff (!rst)
        start |-> data_in[*] == data_in[0];
endproperty
assert property(data_stability_during_start);

property done_after_start;
    @(posedge clk) disable iff (!rst)
        start |-> ##[1:$] done;
endproperty
assert property(done_after_start);

property no_data_output_before_done;
    @(posedge clk) disable iff (!rst)
        !done |-> data_out == 16'b0;
endproperty
assert property(no_data_output_before_done);

property data_valid_on_done;
    @(posedge clk) disable iff (!rst)
        done |-> data_out != 16'b0;
endproperty
assert property(data_valid_on_done);

endmodule