module tb_fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

wire clk_wire;
reg rst_wire;
reg bit_in_wire;
wire pattern_detected_wire;

fsm_1100 dut (
    .clk(clk_wire),
    .rst(rst_wire),
    .bit_in(bit_in_wire),
    .pattern_detected(pattern_detected_wire)
);

always #5 clk_wire = ~clk_wire;

property reset_assertion;
    @(posedge rst_wire) disable iff (!rst_wire)
    !rst_wire |-> ##[0:1] state == S0;
endproperty
assert property(reset_assertion);

property state_transition_S0;
    @(posedge clk_wire) disable iff (!rst_wire)
    state == S0 |=> (next_state == S1 || next_state == S0);
endproperty
assert property(state_transition_S0);

property state_transition_S1;
    @(posedge clk_wire) disable iff (!rst_wire)
    state == S1 |=> (next_state == S2 || next_state == S0);
endproperty
assert property(state_transition_S1);

property state_transition_S2;
    @(posedge clk_wire) disable iff (!rst_wire)
    state == S2 |=> (next_state == S2 || next_state == S3);
endproperty
assert property(state_transition_S2);

property state_transition_S3;
    @(posedge clk_wire) disable iff (!rst_wire)
    state == S3 |=> (next_state == S1 || next_state == S0);
endproperty
assert property(state_transition_S3);

property pattern_detection;
    @(posedge clk_wire) disable iff (!rst_wire)
    state == S3 && bit_in_wire == 0 |-> pattern_detected_wire;
endproperty
assert property(pattern_detection);

endmodule