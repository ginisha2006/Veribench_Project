module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
logic [($clog2(MAX_COUNT+1)-1:0)] count_exp;
logic [($clog2(MAX_COUNT+1)-1:0)] count_act;

param_counter dut (
   .clk(clk),
   .rst(rst),
   .count(count_act)
);

property p_reset;
    @(posedge clk) disable iff (!rst);
    count == 0;
endproperty

property p_count_incr;
    @(posedge clk) disable iff (!rst);
    count <= count + 1 |-> count == count + 1;
endproperty

property p_max_count;
    @(posedge clk) disable iff (!rst);
    count >= MAX_COUNT |=> count == 0;
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst);
    count == MAX_COUNT |=> count == 0;
endproperty

assert property (p_reset);
assert property (p_count_incr);
assert property (p_max_count);
assert property (p_overflow);

endmodule