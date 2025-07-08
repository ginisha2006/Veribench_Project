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

property reset_assertion;
    @(posedge clk) disable iff (!rst) count == 0;
endproperty

assert property(reset_assertion);

property increment;
    @(posedge clk) disable iff (rst) count[$clog2(256)-1:0] == count[$clog2(256)-2:0] + 1 |-> count[$clog2(256)-1:0] inside {[1:254]};
endproperty

assert property(increment);

property overflow;
    @(posedge clk) disable iff (rst) count == 255 |=> count == 0;
endproperty

assert property(overflow);

property underflow_not_possible;
    @(posedge clk) disable iff (rst) count != -1;
endproperty

assert property(underflow_not_possible);

endmodule