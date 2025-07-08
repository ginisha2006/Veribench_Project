module tb_ternary_adder_tree();

import "DPI-C" function void print(string s);

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;

logic CLK;

logic [WIDTH-1:0] OUT;

ternary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.CLK(CLK),.OUT(OUT));

property p_sum1_valid; @(posedge CLK) ($rose(sum1[WIDTH-1]) |=> $fell(sum1[WIDTH-1])); endproperty

property p_sum2_valid; @(posedge CLK) ($rose(sum2[WIDTH-1]) |=> $fell(sum2[WIDTH-1])); endproperty

property p_out_valid; @(posedge CLK) ($rose(OUT[WIDTH-1]) |=> $fell(OUT[WIDTH-1])); endproperty

property p_overflow_sum1; @(posedge CLK) ((sum1 >= 2**WIDTH) |-> $display("Overflow detected on sum1")); endproperty

property p_underflow_sum1; @(posedge CLK) ((sum1 < -2**WIDTH) |-> $display("Underflow detected on sum1")); endproperty

property p_overflow_sum2; @(posedge CLK) ((sum2 >= 2**WIDTH) |-> $display("Overflow detected on sum2")); endproperty

property p_underflow_sum2; @(posedge CLK) ((sum2 < -2**WIDTH) |-> $display("Underflow detected on sum2")); endproperty

property p_overflow_OUT; @(posedge CLK) ((OUT >= 2**WIDTH) |-> $display("Overflow detected on OUT")); endproperty

property p_underflow_OUT; @(posedge CLK) ((OUT < -2**WIDTH) |-> $display("Underflow detected on OUT")); endproperty

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