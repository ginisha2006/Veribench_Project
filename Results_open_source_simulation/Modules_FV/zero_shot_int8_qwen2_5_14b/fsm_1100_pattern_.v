module tb_fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output pattern_detected
);

wire clk;
reg rst;
reg bit_in;
wire pattern_detected;

fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
);

always #5 clk =~clk; // Clock signal generation

property reset_assertion;
    @(posedge clk) disable iff (!rst) rst |-> ##[1:4] (dut.state == fsm_1100::S0);
endproperty
assert property(reset_assertion);

property transition_S0_to_S1;
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S0 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S1);
endproperty
assert property(transition_S0_to_S1);

property transition_S1_to_S0_or_S2;
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S1 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S0);
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S1 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S2);
endproperty
assert property(transition_S1_to_S0_or_S2);

property transition_S2_to_S2_or_S3;
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S2 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S2);
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S2 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S3);
endproperty
assert property(transition_S2_to_S2_or_S3);

property transition_S3_to_S0_or_S1;
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S0);
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S1);
endproperty
assert property(transition_S3_to_S0_or_S1);

property pattern_detection;
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b0) |-> pattern_detected === 1'b1;
endproperty
assert property(pattern_detection);

property no_pattern_detection;
    @(posedge clk) disable iff (rst) !(dut.state == fsm_1100::S3 && bit_in === 1'b0) |-> !pattern_detected;
endproperty
assert property(no_pattern_detection);

endmodule