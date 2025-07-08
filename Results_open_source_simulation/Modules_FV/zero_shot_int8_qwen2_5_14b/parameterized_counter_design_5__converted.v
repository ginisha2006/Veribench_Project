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

always @(*) begin assert (@(posedge clk) disable iff (rst) count[$clog2(256)-1:0] inside {[1 : 254]}); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == 255 |-> count[+$time] == 0)); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) !(count < 0)); end

assert (@(posedge clk) disable iff (rst) (count == n |->
                                    ##1 count == n + 1) within {n inside {[0 : 253]}});

endmodule