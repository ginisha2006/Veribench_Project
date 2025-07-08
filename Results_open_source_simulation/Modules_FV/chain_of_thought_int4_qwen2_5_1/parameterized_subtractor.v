module tb_param_subtractor #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] diff,
    output borrow,
    input clk
);

logic [WIDTH-1:0] a, b, diff;
logic borrow;

param_subtractor #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
);

always begin
    clk <= ~clk; 
    #5;
end

property correct_diff;
    @(posedge clk) disable iff (!reset)
    ({1'b0,a} - b)[WIDTH-1:0] == diff;
endproperty

assert property(correct_diff);

property borrow_correct;
    @(posedge clk) disable iff (!reset)
    ({1'b0,a} < b) |-> borrow === 1'b1;
endproperty

assert property(borrow_correct);

property no_borrow_if_a_greater_or_equal;
    @(posedge clk) disable iff (!reset)
    ({1'b0,a} >= b) |-> borrow === 1'b0;
endproperty

assert property(no_borrow_if_a_greater_or_equal);

endmodule