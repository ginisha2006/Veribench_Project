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

always @(*) begin assert (@(posedge clk) disable iff (!rst) rst |-> ##[0:1] (internal_pattern_detected === 1'b0)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S0 && bit_in === 1'b1) |=> ##1 (state == S1)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S1 && bit_in === 1'b1) |=> ##1 (state == S2)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S2 && bit_in === 1'b0) |=> ##1 (state == S3)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S3 && bit_in === 1'b0) |=> ##1 (state == S0)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S3 && bit_in === 1'b0) |-> ##1 internal_pattern_detected === 1'b1); end

always @(*) begin assert (@(posedge clk) disable iff (rst) !(state == S3 && bit_in === 1'b0) |-> ##1 internal_pattern_detected === 1'b0); end

endmodule