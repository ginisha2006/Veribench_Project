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
wire rst;

always #5 clk = ~clk;

assert (@(posedge rst) disable iff (!rst)
    count == 0);

assert (@(posedge clk) disable iff (!rst)
    count == count[prev] + 1 |-> count == count[prev] + 1 & count != 255);

assert (@(posedge clk) disable iff (!rst)
    count == 255 |=> count[*1:$] == 0);

endmodule