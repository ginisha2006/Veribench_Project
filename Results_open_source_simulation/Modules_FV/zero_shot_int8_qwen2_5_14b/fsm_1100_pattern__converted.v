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

always @(*) begin assert (@(posedge clk) disable iff (!rst) rst |-> ##[1:4] (dut.state == fsm_1100::S0)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (dut.state == fsm_1100::S0 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S1)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (dut.state == fsm_1100::S1 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S0); end
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S1 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S2));

always @(*) begin assert (@(posedge clk) disable iff (rst) (dut.state == fsm_1100::S2 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S2); end
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S2 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S3));

always @(*) begin assert (@(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b0) |=> ##1 (dut.state == fsm_1100::S0); end
    @(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b1) |=> ##1 (dut.state == fsm_1100::S1));

always @(*) begin assert (@(posedge clk) disable iff (rst) (dut.state == fsm_1100::S3 && bit_in === 1'b0) |-> pattern_detected === 1'b1); end

always @(*) begin assert (@(posedge clk) disable iff (rst) !(dut.state == fsm_1100::S3 && bit_in === 1'b0) |-> !pattern_detected); end

endmodule