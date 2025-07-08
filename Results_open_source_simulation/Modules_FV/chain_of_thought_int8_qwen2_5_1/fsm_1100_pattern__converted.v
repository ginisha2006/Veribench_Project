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

always @(*) begin assert (@(posedge clk) disable iff (!rst) (rst |-> ##1 state == S0)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S0 && bit_in ##1 state == S1)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S1 && bit_in ##1 state == S2)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S2 && !bit_in ##1 state == S3)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S3 && bit_in ##1 state == S1)); end

assert (@(posedge clk) disable iff (rst) ((state == S0 && !bit_in ##1 state == S0) ||
                                     (state == S1 && !bit_in ##1 state == S0) ||
                                     (state == S2 && bit_in ##1 state == S0)));

always @(*) begin assert (@(posedge clk) disable iff (rst) (state == S3 && !bit_in |-> internal_pattern_detected)); end

always @(*) begin assert (@(posedge clk) disable iff (rst) (!(state == S3 && !bit_in) |-> !internal_pattern_detected)); end

endmodule