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

assert (@(posedge clk) disable iff (!reset)
    ($rose(a_int)) |-> ##[1:2] diff == (a_int - b_int)[7:0]);

assert (@(posedge clk) disable iff (!reset)
    ($rose(a_int)) |-> ##[1:2] borrow === (a_int < b_int));

assert (@(posedge clk) disable iff (!reset)
    (a_int == 0 && b_int > 0) |=> borrow);

assert (@(posedge clk) disable iff (!reset)
    !($fell(borrow)));

endmodule