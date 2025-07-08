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

property p_initial_count_zero;
    @(posedge clk) disable iff (!rst) count == 0;
endproperty

property p_increment_correct;
    @(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == count));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst) ((count == MAX_COUNT) => (count == 0));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst) (count == 0 => (count == 0));
endproperty

assert property (p_initial_count_zero);
assert property (p_increment_correct);
assert property (p_overflow);
assert property (p_underflow);

endmodule