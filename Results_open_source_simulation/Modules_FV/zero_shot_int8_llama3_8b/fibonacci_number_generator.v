module tb_fibonacci_gen;

import uvm_pkg::*;

reg clk;

reg rst;

reg start;

integer n;

reg [7:0] fib;

fibonacci_gen #(.WIDTH(8)) dut (.clk(clk),.rst(rst),.start(start),.n(n),.fib(fib));

property p_initial_state;
    @(posedge clk) ($rose(rst) |=> ($eq(dut.a, 0) && $eq(dut.b, 1) && $eq(dut.fib, 0) && $eq(dut.count, 0)));
endproperty

property p_start_sequence;
    @(posedge clk) ($rose(start) |=> ($eq(dut.count, 0) && $eq(dut.a, 0) && $eq(dut.b, 1)));
endproperty

property p_fib_generation;
    @(posedge clk) ($rose(start) |=> ($implies($lt(dut.count, dut.n) => $eq(dut.fib, dut.a + dut.b))));
endproperty

property p_count_increment;
    @(posedge clk) ($rose(start) |=> ($implies($lt(dut.count, dut.n) => $eq(dut.count, dut.count + 1))));
endproperty

property p_a_b_update;
    @(posedge clk) ($rose(start) |=> ($implies($lt(dut.count, dut.n) => $eq(dut.a, dut.b) && $eq(dut.b, dut.a + dut.b))));
endproperty

property p_overflow_underflow;
    @(posedge clk) ($rose(start) |=> ($implies($lt(dut.count, dut.n) => $not($signed(dut.fib) > $clog2(1 << dut.WIDTH))));
endproperty

assert property (p_initial_state);

assert property (p_start_sequence);

assert property (p_fib_generation);

assert property (p_count_increment);

assert property (p_a_b_update);

assert property (p_overflow_underflow);

#10000000; // wait for some time

$finish;

endmodule