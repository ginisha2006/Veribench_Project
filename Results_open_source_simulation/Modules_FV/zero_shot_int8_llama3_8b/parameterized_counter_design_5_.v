module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
logic [($clog2(MAX_COUNT+1)-1:0) count;

param_counter dut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

property p_count_reset;
    @(posedge clk) disable iff (!rst) ($rose(count) |-> ##[1:$] count == 0);
endproperty

property p_count_increment;
    @(posedge clk) disable iff (!rst) ((count < MAX_COUNT) |-> ##[1:$] count == count + 1);
endproperty

property p_count_overflow;
    @(posedge clk) disable iff (!rst) ((count == MAX_COUNT) |-> ##[1:$] count == 0);
endproperty

property p_count_underflow;
    @(posedge clk) disable iff (!rst) (count == 0 |-> ##[1:$] count == 0);
endproperty

assert property (p_count_reset);
assert property (p_count_increment);
assert property (p_count_overflow);
assert property (p_count_underflow);

endmodule