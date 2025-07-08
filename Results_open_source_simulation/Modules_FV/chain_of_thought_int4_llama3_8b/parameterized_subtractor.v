module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] diff;
logic borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .diff(diff),
   .borrow(borrow)
);

property p_diff_correct;
    @(posedge clk) disable iff (!rst_n);
    ((|b) => ($rose(borrow));
    (|a) => ($fell(borrow));
    (a == b) => ($stable(diff, 0));
    (a < b) => ($stable(diff, a - b));
    (a > b) => ($stable(diff, a - b));
endproperty

property p_borrow_correct;
    @(posedge clk) disable iff (!rst_n);
    (|b) => ($rise(borrow));
    (|a) => ($fall(borrow));
    (a == b) => ($stable(borrow, 0));
    (a < b) => ($stable(borrow, 1));
    (a > b) => ($stable(borrow, 0));
endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst_n);
    (a == 2**WIDTH - 1 && b == 1) |-> ($rose(borrow));
    (a == 1 && b == 2**WIDTH - 1) |-> ($fell(borrow));
    (a == 2**WIDTH - 1 && b == 2**WIDTH - 1) |-> ($stable(diff, 0));
    (a == 1 && b == 1) |-> ($stable(diff, 0));
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!rst_n);
    (a == 0 && b == 0) |-> ($stable(diff, 0));
    (a == 2**WIDTH - 1 && b == 2**WIDTH - 1) |-> ($stable(diff, 0));
    (a == 0 && b == 2**WIDTH - 1) |-> ($stable(diff, 2**WIDTH - 1));
    (a == 2**WIDTH - 1 && b == 0) |-> ($stable(diff, 2**WIDTH - 1));
endproperty

property p_illegal_transition;
    @(posedge clk) disable iff (!rst_n);
    (a!= b) |=> (!$stable(diff, diff));
    (a!= b) |=> (!$stable(borrow, borrow));
endproperty

assert property (p_diff_correct);
assert property (p_borrow_correct);
assert property (p_overflow_underflow);
assert property (p_edge_cases);
assert property (p_illegal_transition);

endmodule