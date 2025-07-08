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
    @(posedge clk) disable iff (!rst) count == 0;
endproperty
assert property(reset_assertion);

property increment_assertion;
    @(posedge clk) disable iff (rst) count == (count[0:$clog2(256)-2:0] ? count : 0) + 1 |-> count == count + 1;
endproperty
assert property(increment_assertion);

property max_count_reset;
    @(posedge clk) disable iff (!rst) count == 255 |=> count == 0;
endproperty
assert property(max_count_reset);

property non_negative_count;
    @(posedge clk) count >= 0;
endproperty
assert property(non_negative_count);

property no_overflow;
    @(posedge clk) count != 256;
endproperty
assert property(no_overflow);

property no_underflow;
    @(posedge clk) count != -1;
endproperty
assert property(no_underflow);

endmodule