module tb_fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

wire clk_wire;
reg rst_wire;
reg bit_in_wire;

fsm_1100 dut (
    .clk(clk_wire),
    .rst(rst_wire),
    .bit_in(bit_in_wire),
    .pattern_detected(pattern_detected)
);

always #5 clk_wire = ~clk_wire;

property reset_assertion;
    @(posedge clk_wire) disable iff (!rst_wire)
    rst_wire |-> (dut.state == 2'b00);
endproperty
assert property(reset_assertion);

property transition_S0_to_S1;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b00) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b01);
endproperty
assert property(transition_S0_to_S1);

property transition_S0_to_S0;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b00) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00);
endproperty
assert property(transition_S0_to_S0);

property transition_S1_to_S2;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b01) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b10);
endproperty
assert property(transition_S1_to_S2);

property transition_S1_to_S0;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b01) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00);
endproperty
assert property(transition_S1_to_S0);

property transition_S2_to_S2;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b10) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b10);
endproperty
assert property(transition_S2_to_S2);

property transition_S2_to_S3;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b10) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b11);
endproperty
assert property(transition_S2_to_S3);

property transition_S3_to_S1;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b01);
endproperty
assert property(transition_S3_to_S1);

property transition_S3_to_S0;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00);
endproperty
assert property(transition_S3_to_S0);

property pattern_detection;
    @(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11 && !bit_in_wire) |-> (pattern_detected === 1'b1);
endproperty
assert property(pattern_detection);

endmodule