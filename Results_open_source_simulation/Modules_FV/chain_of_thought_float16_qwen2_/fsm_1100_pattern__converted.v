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

assert (@(posedge clk_wire) disable iff (!rst_wire)
    rst_wire |-> (dut.state == 2'b00));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b00) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b01));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b00) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b01) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b10));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b01) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b10) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b10));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b10) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b11));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11) ##1 bit_in_wire === 1'b1 |=> (dut.state == 2'b01));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11) ##1 bit_in_wire === 1'b0 |=> (dut.state == 2'b00));

assert (@(posedge clk_wire) disable iff (!rst_wire)
    (dut.state == 2'b11 && !bit_in_wire) |-> (pattern_detected === 1'b1));

endmodule