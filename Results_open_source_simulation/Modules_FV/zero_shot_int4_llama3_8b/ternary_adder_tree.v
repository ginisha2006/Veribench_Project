Here is the SystemVerilog testbench code for the ternary adder tree:

tb_ternary_adder_tree;

import "DVLIB::*";

(* property *);

property p_input_width; @(posedge clk) ($onehotb({A[WIDTH-1:0], B[WIDTH-1:0], C[WIDTH-1:0], D[WIDTH-1:0], E[WIDTH-1:0}) => OUT[WIDTH-1:0]); endproperty

property p_sum1_calculation; @(posedge clk) (sum1 == A + B + C); endproperty

property p_sum2_calculation; @(posedge clk) (sum2 == sum1 + D + E); endproperty

property p_output_calculation; @(posedge clk) (OUT == sum2); endproperty

property p_overflow_underflow; @(posedge clk) ((A | B | C | D | E) > WIDTH'd(1) | (A | B | C | D | E) < -WIDTH'd(1) => $fatal("Overflow/Underflow detected")); endproperty

(* assert property *) assert property (p_input_width);

(* assert property *) assert property (p_sum1_calculation);

(* assert property *) assert property (p_sum2_calculation);

(* assert property *) assert property (p_output_calculation);

(* assert property *) assert property (p_overflow_underflow);

endmodule