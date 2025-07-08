module tb_seven_seg_display (
    input [3:0] data,
    output reg [6:0] seg
);

reg clk;
always #5 clk = ~clk;

assert (@(posedge clk) disable iff (!reset)
    data inside {[4'h0 : 4'hF]} |-> ##[0:$] seg inside {
        7'b1000000, 7'b1111001, 7'b0100100, 7'b0110000,
        7'b0011001, 7'b0010010, 7'b0000010, 7'b1111000,
        7'b0000000, 7'b0011000, 7'b0001000, 7'b0000011,
        7'b1000110, 7'b0100001, 7'b0000110, 7'b0001110
    } or seg == 7'b1111111);

endmodule