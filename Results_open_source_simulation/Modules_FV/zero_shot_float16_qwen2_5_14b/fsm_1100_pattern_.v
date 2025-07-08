module tb_fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output pattern_detected
);

wire internal_pattern_detected;
fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(internal_pattern_detected)
);

reg clk_gen;
always #5 clk_gen = ~clk_gen;
assign clk = clk_gen;

property reset_assertion;
    @(posedge clk) disable iff (!rst) rst |-> ##[0:1] (internal_pattern_detected === 1'b0);
endproperty
assert property(reset_assertion);

property transition_S0_to_S1;
    @(posedge clk) disable iff (rst) (state == S0 && bit_in === 1'b1) |=> ##1 (state == S1);
endproperty
assert property(transition_S0_to_S1);

property transition_S1_to_S2;
    @(posedge clk) disable iff (rst) (state == S1 && bit_in === 1'b1) |=> ##1 (state == S2);
endproperty
assert property(transition_S1_to_S2);

property transition_S2_to_S3;
    @(posedge clk) disable iff (rst) (state == S2 && bit_in === 1'b0) |=> ##1 (state == S3);
endproperty
assert property(transition_S2_to_S3);

property transition_S3_to_S0;
    @(posedge clk) disable iff (rst) (state == S3 && bit_in === 1'b0) |=> ##1 (state == S0);
endproperty
assert property(transition_S3_to_S0);

property detect_pattern;
    @(posedge clk) disable iff (rst) (state == S3 && bit_in === 1'b0) |-> ##1 internal_pattern_detected === 1'b1;
endproperty
assert property(detect_pattern);

property no_detection_outside_pattern;
    @(posedge clk) disable iff (rst) !(state == S3 && bit_in === 1'b0) |-> ##1 internal_pattern_detected === 1'b0;
endproperty
assert property(no_detection_outside_pattern);

endmodule