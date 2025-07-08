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

reg clk;

always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) disable iff (!rst) count == 0); end

always @(*) begin assert (@(posedge clk) disable iff (rst) count[$clog2(256)-1:0] == count[$clog2(256)-2:0] + 1 |-> count[$clog2(256)-1:0] inside {[1:254]}); end

always @(*) begin assert (@(posedge clk) disable iff (rst) count == 255 |=> count == 0); end

always @(*) begin assert (@(posedge clk) disable iff (rst) count != -1); end

endmodule