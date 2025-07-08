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

property reset_assertion;
    @(posedge clk) disable iff (!rst)
    rst |-> (data_out == 16'b0 && !done);
endproperty
assert property(reset_assertion);

property start_inactive_when_rst;
    @(posedge clk) disable iff (!rst)
    rst |-> !start;
endproperty
assert property(start_inactive_when_rst);

property data_out_validity;
    @(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[1:$] done[*];
endproperty
assert property(data_out_validity);

property done_signal_behavior;
    @(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[$:1] done[*];
endproperty
assert property(done_signal_behavior);

property data_flow_consistency;
    @(posedge clk) disable iff (!rst)
    ##[1:$] start[*] |-> ##[$:1] data_out[*];
endproperty
assert property(data_flow_consistency);

property no_data_output_before_start;
    @(posedge clk) disable iff (!rst)
    !start |-> data_out == 16'b0;
endproperty
assert property(no_data_output_before_start);

property start_edge_detection;
    @(posedge clk) disable iff (!rst)
    start[*] |=> !start || start[*];
endproperty
assert property(start_edge_detection);

property done_edge_detection;
    @(posedge clk) disable iff (!rst)
    done[*] |=> !done || done[*];
endproperty
assert property(done_edge_detection);

endmodule