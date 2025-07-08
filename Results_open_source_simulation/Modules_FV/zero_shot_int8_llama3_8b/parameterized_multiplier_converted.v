module tb_param_multiplier;

import uvm_pkg::*;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;

logic [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.product(product));

property p_product_calculation;

@(*) assert property ($onehot0({[WIDTH-1:0]{a} * [WIDTH-1:0]{b}} => product == {[2*WIDTH-1:0]{a} * [WIDTH-1:0]{b}}));

property p_overflow_underflow;

@(*) assert property (~($signed(product) > $max_value($signed({[WIDTH-1:0]{a} * [WIDTH-1:0]{b}}))) |

~($signed(product) < $min_value($signed({[WIDTH-1:0]{a} * [WIDTH-1:0]{b}})));

property p_edge_cases;

@(*) assert property ((a == 0) | (b == 0) | (a == $max_value({[WIDTH-1:0]})) | (b == $max_value({[WIDTH-1:0]})) => product == 0);

property p_illegal_transition;

@(*) assert property (!($stable(a) | $stable(b)) => $fell(product));

endmodule