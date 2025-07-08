module tb_param_subtractor(
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] diff,
    output reg borrow,
    input clk
);

reg [7:0] a_int;
reg [7:0] b_int;

assign a = a_int;
assign b = b_int;

always #5 clk =~clk;

property p_diff_behavior;
    @(posedge clk) disable iff (!reset)
    ($rose(a_int)) |-> ##[1:2] diff == (a_int - b_int)[7:0];
endproperty

assert property(p_diff_behavior);

property p_borrow_behavior;
    @(posedge clk) disable iff (!reset)
    ($rose(a_int)) |-> ##[1:2] borrow === (a_int < b_int);
endproperty

assert property(p_borrow_behavior);

property p_underflow;
    @(posedge clk) disable iff (!reset)
    (a_int == 0 && b_int > 0) |=> borrow;
endproperty

assert property(p_underflow);

property p_no_overflow;
    @(posedge clk) disable iff (!reset)
    !($fell(borrow));
endproperty

assert property(p_no_overflow);

endmodule