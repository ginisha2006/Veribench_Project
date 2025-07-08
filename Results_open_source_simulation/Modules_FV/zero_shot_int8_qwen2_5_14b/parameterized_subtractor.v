module tb_param_subtractor(
    input clk,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] diff,
    output reg borrow
);

wire [7:0] a_in = a;
wire [7:0] b_in = b;

param_subtractor #(.WIDTH(8)) dut (
    .a(a_in),
    .b(b_in),
    .diff(diff),
    .borrow(borrow)
);

property p_diff_correctness;
    @(posedge clk) disable iff (!reset)
    ({borrow, diff} == {1'b0, a_in} - b_in);
endproperty

assert property(p_diff_correctness);

property p_borrow_behavior;
    @(posedge clk) disable iff (!reset)
    ($rose(borrow)) |-> (a_in < b_in);
endproperty

assert property(p_borrow_behavior);

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    (a_in >= b_in) |=> !borrow;
endproperty

assert property(p_no_overflow_underflow);

endmodule