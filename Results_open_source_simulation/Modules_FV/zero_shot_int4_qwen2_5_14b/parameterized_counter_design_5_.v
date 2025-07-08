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

property reset_assertion;
    @(posedge rst) disable iff (!rst)
    count == 0;
endproperty

assert property(reset_assertion);

property normal_counting;
    @(posedge clk) disable iff (!rst)
    count == count[prev] + 1 |-> count == count[prev] + 1 & count != 255;
endproperty

assert property(normal_counting);

property max_count_reset;
    @(posedge clk) disable iff (!rst)
    count == 255 |=> count[*1:$] == 0;
endproperty

assert property(max_count_reset);

endmodule