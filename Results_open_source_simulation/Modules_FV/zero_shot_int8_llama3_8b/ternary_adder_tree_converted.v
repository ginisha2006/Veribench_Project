module tb_ternary_adder_tree();

import "DPI-C" function void print(string s);

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;

logic CLK;

logic [WIDTH-1:0] OUT;

ternary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.CLK(CLK),.OUT(OUT));

assert property (@(posedge CLK) p_sum1_valid);

assert property (@(posedge CLK) p_sum2_valid);

assert property (@(posedge CLK) p_out_valid);

assert property (@(posedge CLK) p_overflow_sum1);

assert property (@(posedge CLK) p_underflow_sum1);

assert property (@(posedge CLK) p_overflow_sum2);

assert property (@(posedge CLK) p_underflow_sum2);

assert property (@(posedge CLK) p_overflow_OUT);

assert property (@(posedge CLK) p_underflow_OUT);

endmodule