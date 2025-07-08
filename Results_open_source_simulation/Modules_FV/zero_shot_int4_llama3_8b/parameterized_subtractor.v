module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] diff;
logic borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .diff(diff),
   .borrow(borrow)
);

property p_diff_eq;
    @(posedge clk) ((a - b)[WIDTH-1:0] == diff);
endproperty

property p_borrow_set;
    @(posedge clk) ((a < b) | (a == b && borrow));
endproperty

property p_borrow_clr;
    @(posedge clk) (~((a >= b) || (a == b && ~borrow)));
endproperty

property p_overflow;
    @(posedge clk) ($rose(borrow) && (a == (1 << WIDTH)-1));
endproperty

property p_underflow;
    @(posedge clk) ($fell(borrow) && (a == 0));
endproperty

property p_edge_cases;
    @(posedge clk) ((a == b) | (a == (1 << WIDTH)-1) | (a == 0));
endproperty

assert property (p_diff_eq);
assert property (p_borrow_set);
assert property (p_borrow_clr);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_edge_cases);

always #10 clk = ~clk; // Clock generation

endmodule