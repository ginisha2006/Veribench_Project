module tb_fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

reg clk;
wire rst;
wire bit_in;
wire pattern_detected;

fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
);

always #5 clk = ~clk;

assert (@(posedge rst) disable iff (!rst)
    rst |-> ##[0:1] (dut.state === fsm_1100::S0));

assert (@(posedge clk) disable iff (!rst)
    (dut.state === fsm_1100::S0) && (bit_in) |=> (dut.next_state === fsm_1100::S1));

assert (@(posedge clk) disable iff (!rst)
    (dut.state === fsm_1100::S1) && (bit_in) |=> (dut.next_state === fsm_1100::S2));

assert (@(posedge clk) disable iff (!rst)
    (dut.state === fsm_1100::S2) && (!bit_in) |=> (dut.next_state === fsm_1100::S3));

assert (@(posedge clk) disable iff (!rst)
    (dut.state === fsm_1100::S3) |-> (dut.next_state === fsm_1100::S0 || dut.next_state === fsm_1100::S1));

assert (@(posedge clk) disable iff (!rst)
    (dut.state === fsm_1100::S3) && (!bit_in) |-> (pattern_detected));

endmodule