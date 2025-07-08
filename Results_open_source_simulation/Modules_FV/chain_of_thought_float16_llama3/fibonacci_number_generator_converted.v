module tb_fibonacci_gen;

import uvm_pkg::*;

bit clk;

bit rst;

bit start;

integer n;

reg [7:0] fib;

reg [7:0] a;

reg [7:0] b;

reg [7:0] count;

property fib_gen_correctness;

@(*) assert property (fib_gen_correctness);

property fib_gen_correctness = ((n == 0) |-> (fib == 0)) &&

(n > 0) |=> ((a == 0) & (b == 1) & (fib == 1));

property fib_gen_edge_cases;

@(*) assert property (fib_gen_edge_cases);

property fib_gen_edge_cases = (!rst |=> ($stable(a) & $stable(b) & $stable(fib)));

property fib_gen_start_transition;

@(*) assert property (fib_gen_start_transition);

property fib_gen_start_transition = (start |=> (~start));

property fib_gen_n_overflow;

@(*) assert property (fib_gen_n_overflow);

property fib_gen_n_overflow = (n >= 256) |-> ($rose(count) |=> $fell(count));

property fib_gen_n_underflow;

@(*) assert property (fib_gen_n_underflow);

property fib_gen_n_underflow = (n < 0) |-> ($rose(count) |=> $fell(count));

initial begin

#10 clk = 1'b1;

#10 clk = 1'b0;

#20 rst = 1'b1;

#10 rst = 1'b0;

#10 start = 1'b1;

#100 start = 1'b0;

#10000 $finish;

end

endmodule