module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;

logic [WIDTH-1:0] diff;

logic borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.diff(diff),.borrow(borrow));

property p_correctness;

@(posedge clk) disable iff (!rst_n)

((a == b) => (diff == 0 && borrow == 0)) ||

(a > b) => ((diff == a - b) && borrow == 0) ||

(a < b) => ((diff == (WIDTH'd32 - b + a + 1)) && borrow);

assert property (p_correctness);

property p_overflow;

@(posedge clk) disable iff (!rst_n)

(a >= (WIDTH'd32 - 1) && b == 0) => (diff == (WIDTH'd32 - 1) && borrow);

assert property (p_overflow);

property p_underflow;

@(posedge clk) disable iff (!rst_n)

(a == 0 && b >= (WIDTH'd32 - 1)) => (diff == 0 && borrow);

assert property (p_underflow);

endmodule