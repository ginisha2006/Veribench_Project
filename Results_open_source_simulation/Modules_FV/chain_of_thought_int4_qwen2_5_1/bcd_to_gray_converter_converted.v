module tb_bcd_to_gray (
    input [3:0] bcd,
    output reg [3:0] gray,
    input clk
);

assert (@(posedge clk) disable iff (!reset)
    $onehot(bcd[3:0]) |-> $stable(gray));

assert (@(posedge clk) disable iff (!reset)
    gray == bcd ^ (bcd >> 1));

assert (@(posedge clk) disable iff (!reset)
    (bcd == 4'b0000) |-> (gray == 4'b0000);
    @(posedge clk) disable iff (!reset)
    (bcd == 4'b1001) |-> (gray == 4'b1001));

assert (@(posedge clk) disable iff (!reset)
    !($isunknown(bcd)) & !(bcd < 4'b0000) & !(bcd > 4'b1001));

endmodule