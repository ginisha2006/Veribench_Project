module tb_param_counter (
    input clk,
    input rst,
    output reg [$clog2(256)-1:0] count
);

param_counter #(.MAX_COUNT(255)) dut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

reg clk_signal;

always #5 clk_signal = ~clk_signal;
assign clk = clk_signal;

always @(*) begin assert (@(posedge clk) disable iff (!rst) count == 0); end

always @(*) begin assert (@(posedge clk) disable iff (rst) count == (count[0:$clog2(256)-2:0] ? count : 0) + 1 |-> count == count + 1); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) count == 255 |=> count == 0); end

always @(*) begin assert (@(posedge clk) count >= 0); end

always @(*) begin assert (@(posedge clk) count != 256); end

always @(*) begin assert (@(posedge clk) count != -1); end

endmodule