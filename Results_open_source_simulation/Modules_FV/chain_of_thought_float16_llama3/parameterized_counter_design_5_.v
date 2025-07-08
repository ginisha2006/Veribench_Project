module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
reg [$clog2(MAX_COUNT+1)-1:0] count;

param_counter #(MAX_COUNT) dut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

property p_initial_count_zero;
    @(posedge clk) disable iff (!rst) count == 0;
endproperty

property p_increment_correct;
    @(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == $past(count)));
endproperty

property p_overflow_reset;
    @(posedge clk) disable iff (!rst) (count == MAX_COUNT && $past(count) < MAX_COUNT) |-> (count == 0);
endproperty

property p_underflow_reset;
    @(posedge clk) disable iff (!rst) (count == 0 && $past(count) > 0) |-> (count == 0);
endproperty

assert property (p_initial_count_zero);
assert property (p_increment_correct);
assert property (p_overflow_reset);
assert property (p_underflow_reset);

endmodule